import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:anufit/core/services/health_metrics_engine.dart';
import 'package:anufit/features/onboarding/domain/entities/user_entity.dart';
import 'package:anufit/features/onboarding/domain/repository/onboarding_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this._repository) : super(const ProfileInitial()) {
    on<ProfileLoadRequested>(_onLoad);
    on<ProfileSaveRequested>(_onSave);
    on<ProfileFieldChanged>(_onFieldChanged);
  }

  final OnboardingRepository _repository;

  Future<void> _onLoad(ProfileLoadRequested event, Emitter<ProfileState> emit) async {
    emit(const ProfileLoading());
    try {
      final user = await _repository.getUser();
      if (user == null) {
        emit(const ProfileError('No profile found'));
        return;
      }
      emit(ProfileLoaded(user: user, draft: user));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  void _onFieldChanged(ProfileFieldChanged event, Emitter<ProfileState> emit) {
    final current = state;
    if (current is! ProfileLoaded) return;
    emit(current.copyWith(draft: event.user));
  }

  Future<void> _onSave(ProfileSaveRequested event, Emitter<ProfileState> emit) async {
    final current = state;
    if (current is! ProfileLoaded) return;
    emit(current.copyWith(isSaving: true, saveMessage: null));
    try {
      await _repository.saveUser(current.draft);
      emit(ProfileLoaded(
        user: current.draft,
        draft: current.draft,
        isSaving: false,
        saveMessage: 'Profile saved',
      ));
    } catch (e) {
      emit(current.copyWith(isSaving: false, saveMessage: e.toString()));
    }
  }
}

class ProfileViewData extends Equatable {
  const ProfileViewData({required this.user});

  final UserEntity user;

  double get bmi => HealthMetricsEngine.bmi(weightKg: user.weight, heightCm: user.height);
  BmiCategory get bmiCategory => HealthMetricsEngine.bmiCategory(bmi);
  double get strideMeters => HealthMetricsEngine.strideMeters(
        heightCm: user.height,
        gender: user.gender,
        autoStride: user.autoStride,
        manualStride: user.strideLength,
        unit: user.unit,
      );

  @override
  List<Object?> get props => [user];
}
