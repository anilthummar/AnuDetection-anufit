import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:anufit/core/enums/gender.dart';
import 'package:anufit/core/enums/unit_system.dart';
import 'package:anufit/features/onboarding/domain/entities/user_entity.dart';
import 'package:anufit/features/onboarding/domain/usecases/onboarding_usecases.dart';

part 'profile_event.dart';
part 'profile_state.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this._saveUser, this._getUser) : super(const ProfileState()) {
    on<ProfileLoadExisting>(_onLoadExisting);
    on<ProfileNameChanged>(_onNameChanged);
    on<ProfileAgeChanged>(_onAgeChanged);
    on<ProfileGenderChanged>(_onGenderChanged);
    on<ProfileHeightChanged>(_onHeightChanged);
    on<ProfileWeightChanged>(_onWeightChanged);
    on<ProfileSaveRequested>(_onSaveRequested);
    on<ProfileSaveWithGoalRequested>(_onSaveWithGoalRequested);
    on<ProfileSaveAcknowledged>(_onSaveAcknowledged);
  }

  final SaveUserProfileUseCase _saveUser;
  final GetUserProfileUseCase _getUser;

  Future<void> _onLoadExisting(
    ProfileLoadExisting event,
    Emitter<ProfileState> emit,
  ) async {
    final user = await _getUser();
    if (user != null) {
      emit(state.copyWith(
        name: user.name ?? '',
        age: user.age,
        gender: user.gender,
        height: user.height,
        weight: user.weight,
      ));
    }
  }

  void _onNameChanged(ProfileNameChanged event, Emitter<ProfileState> emit) {
    emit(state.copyWith(name: event.name));
  }

  void _onAgeChanged(ProfileAgeChanged event, Emitter<ProfileState> emit) {
    emit(state.copyWith(age: event.age));
  }

  void _onGenderChanged(ProfileGenderChanged event, Emitter<ProfileState> emit) {
    emit(state.copyWith(gender: event.gender));
  }

  void _onHeightChanged(ProfileHeightChanged event, Emitter<ProfileState> emit) {
    emit(state.copyWith(height: event.height));
  }

  void _onWeightChanged(ProfileWeightChanged event, Emitter<ProfileState> emit) {
    emit(state.copyWith(weight: event.weight));
  }

  Future<void> _onSaveRequested(
    ProfileSaveRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(isSaving: true, error: null, isSaved: false));
    try {
      final existing = await _getUser();
      final user = UserEntity(
        id: existing?.id ?? 0,
        name: state.name.isEmpty ? null : state.name,
        age: state.age,
        gender: state.gender,
        height: state.height,
        weight: state.weight,
        dailyGoal: existing?.dailyGoal ?? 10000,
        strideLength: existing?.strideLength,
        unit: existing?.unit ?? UnitSystem.metric,
        autoStride: existing?.autoStride ?? true,
        walkingSpeed: existing?.walkingSpeed,
        createdAt: existing?.createdAt ?? DateTime.now(),
      );
      await _saveUser(user);
      emit(state.copyWith(isSaving: false, isSaved: true));
    } on Object catch (e) {
      emit(state.copyWith(isSaving: false, error: e.toString()));
    }
  }

  Future<void> _onSaveWithGoalRequested(
    ProfileSaveWithGoalRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(isSaving: true, error: null, isSaved: false));
    try {
      final user = UserEntity(
        id: 0,
        name: state.name.isEmpty ? null : state.name,
        age: state.age,
        gender: state.gender,
        height: state.height,
        weight: state.weight,
        dailyGoal: event.dailyGoal,
        strideLength: null,
        unit: event.unit,
        autoStride: true,
        createdAt: DateTime.now(),
      );
      await _saveUser(user);
      emit(state.copyWith(isSaving: false, isSaved: true));
    } on Object catch (e) {
      emit(state.copyWith(isSaving: false, error: e.toString()));
    }
  }

  void _onSaveAcknowledged(ProfileSaveAcknowledged event, Emitter<ProfileState> emit) {
    emit(state.copyWith(isSaved: false));
  }
}
