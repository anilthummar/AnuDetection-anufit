import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:anufit/features/statistics/domain/entities/statistics_entity.dart';
import 'package:anufit/features/statistics/domain/repository/statistics_repository.dart';

part 'chart_event.dart';
part 'chart_state.dart';

@injectable
class ChartBloc extends Bloc<ChartEvent, ChartBlocState> {
  ChartBloc(this._repository) : super(const ChartBlocInitial()) {
    on<ChartLoadRequested>(_onLoad);
    on<ChartTypeChanged>(_onTypeChanged);
  }

  final StatisticsRepository _repository;

  Future<void> _onLoad(ChartLoadRequested event, Emitter<ChartBlocState> emit) async {
    emit(ChartBlocLoading(type: event.type));
    try {
      final chart = await _repository.getChartData(event.type);
      emit(ChartBlocLoaded(chart: chart));
    } catch (error) {
      emit(ChartBlocError(error.toString()));
    }
  }

  Future<void> _onTypeChanged(ChartTypeChanged event, Emitter<ChartBlocState> emit) async {
    add(ChartLoadRequested(type: event.type));
  }
}
