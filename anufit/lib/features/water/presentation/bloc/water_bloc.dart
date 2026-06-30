import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:anufit/features/water/domain/entities/water_entity.dart';
import 'package:anufit/features/water/domain/repository/water_repository.dart';

part 'water_event.dart';
part 'water_state.dart';

@injectable
class WaterBloc extends Bloc<WaterEvent, WaterState> {
  WaterBloc(this._repository) : super(const WaterInitial()) {
    on<WaterLoadRequested>(_onLoad);
    on<WaterAddRequested>(_onAdd);
    on<WaterGoalSetRequested>(_onSetGoal);
  }

  final WaterRepository _repository;

  Future<void> _onLoad(WaterLoadRequested event, Emitter<WaterState> emit) async {
    emit(const WaterLoading());
    try {
      final dashboard = await _repository.getDashboard();
      emit(WaterLoaded(dashboard: dashboard));
    } catch (e) {
      emit(WaterError(e.toString()));
    }
  }

  Future<void> _onAdd(WaterAddRequested event, Emitter<WaterState> emit) async {
    final current = state;
    if (current is WaterLoaded) emit(current.copyWith(isSaving: true));
    await _repository.addWater(amountMl: event.amountMl);
    add(const WaterLoadRequested());
  }

  Future<void> _onSetGoal(WaterGoalSetRequested event, Emitter<WaterState> emit) async {
    await _repository.setDailyGoalLiters(event.liters);
    add(const WaterLoadRequested());
  }
}
