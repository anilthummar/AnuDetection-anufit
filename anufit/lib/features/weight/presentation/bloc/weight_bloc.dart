import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:anufit/features/weight/domain/entities/weight_entity.dart';
import 'package:anufit/features/weight/domain/repository/weight_repository.dart';

part 'weight_event.dart';
part 'weight_state.dart';

@injectable
class WeightBloc extends Bloc<WeightEvent, WeightState> {
  WeightBloc(this._repository) : super(const WeightInitial()) {
    on<WeightLoadRequested>(_onLoad);
    on<WeightLogRequested>(_onLog);
    on<WeightGoalSetRequested>(_onSetGoal);
    on<WeightChartPeriodChanged>(_onPeriodChanged);
  }

  final WeightRepository _repository;

  Future<void> _onLoad(WeightLoadRequested event, Emitter<WeightState> emit) async {
    emit(const WeightLoading());
    try {
      final dashboard = await _repository.getDashboard();
      emit(WeightLoaded(dashboard: dashboard, chartPeriod: WeightChartPeriod.weekly));
    } catch (e) {
      emit(WeightError(e.toString()));
    }
  }

  Future<void> _onLog(WeightLogRequested event, Emitter<WeightState> emit) async {
    final current = state;
    if (current is WeightLoaded) emit(current.copyWith(isSaving: true));
    try {
      await _repository.logWeight(weightKg: event.weightKg, note: event.note);
      add(const WeightLoadRequested());
    } catch (e) {
      emit(WeightError(e.toString()));
    }
  }

  Future<void> _onSetGoal(WeightGoalSetRequested event, Emitter<WeightState> emit) async {
    await _repository.setGoalWeight(event.goalKg);
    add(const WeightLoadRequested());
  }

  void _onPeriodChanged(WeightChartPeriodChanged event, Emitter<WeightState> emit) {
    final current = state;
    if (current is WeightLoaded) {
      emit(current.copyWith(chartPeriod: event.period));
    }
  }
}
