import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:anufit/features/history/domain/entities/history_entity.dart';
import 'package:anufit/features/history/domain/repository/history_repository.dart';

part 'history_event.dart';
part 'history_state.dart';

@injectable
class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc(this._repository) : super(const HistoryInitial()) {
    on<HistoryLoadRequested>(_onLoad);
    on<HistoryFilterChanged>(_onFilterChanged);
    on<HistorySearchChanged>(_onSearchChanged);
    on<HistoryLoadMoreRequested>(_onLoadMore);
    on<HistoryPeriodChanged>(_onPeriodChanged);
  }

  final HistoryRepository _repository;
  static const _pageSize = 20;

  Future<void> _onLoad(HistoryLoadRequested event, Emitter<HistoryState> emit) async {
    emit(const HistoryLoading());
    try {
      await _repository.ensureSynced(filter: event.filter);
      final page = await _repository.getDailyHistory(
        filter: event.filter,
        customStart: event.customStart,
        customEnd: event.customEnd,
        search: event.search,
        pageSize: _pageSize,
      );
      final weekly = await _repository.getWeeklyHistory();
      final monthly = await _repository.getMonthlyHistory();
      final yearly = await _repository.getYearlyHistory();
      final activeDates = await _repository.getActiveDates(
        start: DateTime.now().subtract(const Duration(days: 60)),
        end: DateTime.now(),
      );
      emit(HistoryLoaded(
        period: event.period,
        filter: event.filter,
        dailyItems: page.items,
        hasMore: page.hasMore,
        page: 0,
        weekly: weekly,
        monthly: monthly,
        yearly: yearly,
        activeDates: activeDates,
        search: event.search,
      ));
    } catch (error) {
      emit(HistoryError(error.toString()));
    }
  }

  Future<void> _onFilterChanged(HistoryFilterChanged event, Emitter<HistoryState> emit) async {
    add(HistoryLoadRequested(
      period: event.period,
      filter: event.filter,
      customStart: event.customStart,
      customEnd: event.customEnd,
      search: event.search,
    ));
  }

  Future<void> _onSearchChanged(HistorySearchChanged event, Emitter<HistoryState> emit) async {
    final current = state;
    if (current is! HistoryLoaded) return;
    add(HistoryLoadRequested(
      period: current.period,
      filter: current.filter,
      search: event.search,
    ));
  }

  Future<void> _onLoadMore(HistoryLoadMoreRequested event, Emitter<HistoryState> emit) async {
    final current = state;
    if (current is! HistoryLoaded || !current.hasMore) return;
    try {
      final nextPage = current.page + 1;
      final page = await _repository.getDailyHistory(
        filter: current.filter,
        search: current.search,
        page: nextPage,
        pageSize: _pageSize,
      );
      emit(current.copyWith(
        dailyItems: [...current.dailyItems, ...page.items],
        hasMore: page.hasMore,
        page: nextPage,
      ));
    } catch (error) {
      emit(HistoryError(error.toString()));
    }
  }

  Future<void> _onPeriodChanged(HistoryPeriodChanged event, Emitter<HistoryState> emit) async {
    final current = state;
    if (current is HistoryLoaded) {
      emit(current.copyWith(period: event.period));
    }
  }
}
