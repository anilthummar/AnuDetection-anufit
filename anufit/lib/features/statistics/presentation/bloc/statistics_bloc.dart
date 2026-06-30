import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:anufit/features/statistics/domain/entities/statistics_entity.dart';
import 'package:anufit/features/statistics/domain/repository/statistics_repository.dart';

part 'statistics_event.dart';
part 'statistics_state.dart';

@injectable
class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
  StatisticsBloc(this._repository) : super(const StatisticsInitial()) {
    on<StatisticsLoadRequested>(_onLoad);
    on<StatisticsPeriodChanged>(_onPeriodChanged);
  }

  final StatisticsRepository _repository;

  Future<void> _onLoad(StatisticsLoadRequested event, Emitter<StatisticsState> emit) async {
    emit(const StatisticsLoading());
    try {
      final bundle = await _repository.getStatistics(period: event.period);
      emit(StatisticsLoaded(bundle: bundle));
    } catch (error) {
      emit(StatisticsError(error.toString()));
    }
  }

  Future<void> _onPeriodChanged(
    StatisticsPeriodChanged event,
    Emitter<StatisticsState> emit,
  ) async {
    add(StatisticsLoadRequested(period: event.period));
  }
}
