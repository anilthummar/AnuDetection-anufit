import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:anufit/features/onboarding/domain/entities/user_entity.dart';
import 'package:anufit/features/onboarding/domain/usecases/onboarding_usecases.dart';

part 'goal_event.dart';
part 'goal_state.dart';

@injectable
class GoalBloc extends Bloc<GoalEvent, GoalState> {
  GoalBloc(this._getUser, this._saveUser) : super(const GoalState()) {
    on<GoalLoadExisting>(_onLoadExisting);
    on<GoalPresetSelected>(_onPresetSelected);
    on<GoalCustomChanged>(_onCustomChanged);
    on<GoalSaveRequested>(_onSaveRequested);
    on<GoalSaveAcknowledged>(_onSaveAcknowledged);
  }

  final GetUserProfileUseCase _getUser;
  final SaveUserProfileUseCase _saveUser;

  Future<void> _onLoadExisting(GoalLoadExisting event, Emitter<GoalState> emit) async {
    final user = await _getUser();
    if (user != null) {
      emit(state.copyWith(selectedGoal: user.dailyGoal));
    }
  }

  void _onPresetSelected(GoalPresetSelected event, Emitter<GoalState> emit) {
    emit(state.copyWith(selectedGoal: event.goal, isCustom: false));
  }

  void _onCustomChanged(GoalCustomChanged event, Emitter<GoalState> emit) {
    emit(state.copyWith(isCustom: true, customGoal: event.value));
  }

  Future<void> _onSaveRequested(GoalSaveRequested event, Emitter<GoalState> emit) async {
    emit(state.copyWith(isSaving: true, isSaved: false));
    final user = await _getUser();
    if (user == null) {
      emit(state.copyWith(isSaving: false));
      return;
    }
    final updated = UserEntity(
      id: user.id,
      name: user.name,
      age: user.age,
      gender: user.gender,
      height: user.height,
      weight: user.weight,
      dailyGoal: state.effectiveGoal,
      strideLength: user.strideLength,
      unit: user.unit,
      autoStride: user.autoStride,
      walkingSpeed: user.walkingSpeed,
      createdAt: user.createdAt,
    );
    await _saveUser(updated);
    emit(state.copyWith(isSaving: false, isSaved: true));
  }

  void _onSaveAcknowledged(GoalSaveAcknowledged event, Emitter<GoalState> emit) {
    emit(state.copyWith(isSaved: false));
  }
}
