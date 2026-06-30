import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:anufit/core/enums/gender.dart';
import 'package:anufit/core/enums/unit_system.dart';
import 'package:anufit/features/onboarding/domain/entities/user_entity.dart';
import 'package:anufit/features/onboarding/domain/usecases/onboarding_usecases.dart';

part 'walking_preferences_event.dart';
part 'walking_preferences_state.dart';

@injectable
class WalkingPreferencesBloc extends Bloc<WalkingPreferencesEvent, WalkingPreferencesState> {
  WalkingPreferencesBloc(this._getUser, this._saveUser) : super(const WalkingPreferencesState()) {
    on<WalkingPreferencesLoadExisting>(_onLoadExisting);
    on<WalkingPreferencesUnitChanged>(_onUnitChanged);
    on<WalkingPreferencesStrideChanged>(_onStrideChanged);
    on<WalkingPreferencesAutoStrideChanged>(_onAutoStrideChanged);
    on<WalkingPreferencesWalkingSpeedChanged>(_onWalkingSpeedChanged);
    on<WalkingPreferencesSaveRequested>(_onSaveRequested);
    on<WalkingPreferencesSaveAcknowledged>(_onSaveAcknowledged);
  }

  final GetUserProfileUseCase _getUser;
  final SaveUserProfileUseCase _saveUser;

  Future<void> _onLoadExisting(
    WalkingPreferencesLoadExisting event,
    Emitter<WalkingPreferencesState> emit,
  ) async {
    final user = await _getUser();
    if (user != null) {
      emit(WalkingPreferencesState(
        unit: user.unit,
        strideLength: user.strideLength ?? _estimateStride(user.height, user.gender),
        autoStride: user.autoStride,
        walkingSpeed: user.walkingSpeed,
      ));
    }
  }

  void _onUnitChanged(WalkingPreferencesUnitChanged event, Emitter<WalkingPreferencesState> emit) {
    emit(state.copyWith(unit: event.unit));
  }

  void _onStrideChanged(WalkingPreferencesStrideChanged event, Emitter<WalkingPreferencesState> emit) {
    emit(state.copyWith(strideLength: event.strideLength, autoStride: false));
  }

  void _onAutoStrideChanged(
    WalkingPreferencesAutoStrideChanged event,
    Emitter<WalkingPreferencesState> emit,
  ) {
    emit(state.copyWith(autoStride: event.autoStride));
  }

  void _onWalkingSpeedChanged(
    WalkingPreferencesWalkingSpeedChanged event,
    Emitter<WalkingPreferencesState> emit,
  ) {
    emit(state.copyWith(walkingSpeed: event.walkingSpeed));
  }

  Future<void> _onSaveRequested(
    WalkingPreferencesSaveRequested event,
    Emitter<WalkingPreferencesState> emit,
  ) async {
    emit(state.copyWith(isSaving: true, isSaved: false));
    final user = await _getUser();
    if (user == null) {
      emit(state.copyWith(isSaving: false));
      return;
    }
    final stride = state.autoStride ? _estimateStride(user.height, user.gender) : state.strideLength;
    final updated = UserEntity(
      id: user.id,
      name: user.name,
      age: user.age,
      gender: user.gender,
      height: user.height,
      weight: user.weight,
      dailyGoal: user.dailyGoal,
      strideLength: stride,
      unit: state.unit,
      autoStride: state.autoStride,
      walkingSpeed: state.walkingSpeed,
      createdAt: user.createdAt,
    );
    await _saveUser(updated);
    emit(state.copyWith(isSaving: false, isSaved: true, strideLength: stride));
  }

  void _onSaveAcknowledged(
    WalkingPreferencesSaveAcknowledged event,
    Emitter<WalkingPreferencesState> emit,
  ) {
    emit(state.copyWith(isSaved: false));
  }

  double _estimateStride(double heightCm, Gender gender) {
    final heightM = heightCm / 100;
    final factor = gender == Gender.female ? 0.413 : 0.415;
    return double.parse((heightM * factor).toStringAsFixed(2));
  }
}
