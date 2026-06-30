part of 'walking_preferences_bloc.dart';

sealed class WalkingPreferencesEvent extends Equatable {
  const WalkingPreferencesEvent();

  @override
  List<Object?> get props => [];
}

final class WalkingPreferencesLoadExisting extends WalkingPreferencesEvent {
  const WalkingPreferencesLoadExisting();
}

final class WalkingPreferencesUnitChanged extends WalkingPreferencesEvent {
  const WalkingPreferencesUnitChanged(this.unit);

  final UnitSystem unit;

  @override
  List<Object?> get props => [unit];
}

final class WalkingPreferencesStrideChanged extends WalkingPreferencesEvent {
  const WalkingPreferencesStrideChanged(this.strideLength);

  final double strideLength;

  @override
  List<Object?> get props => [strideLength];
}

final class WalkingPreferencesAutoStrideChanged extends WalkingPreferencesEvent {
  const WalkingPreferencesAutoStrideChanged(this.autoStride);

  final bool autoStride;

  @override
  List<Object?> get props => [autoStride];
}

final class WalkingPreferencesWalkingSpeedChanged extends WalkingPreferencesEvent {
  const WalkingPreferencesWalkingSpeedChanged(this.walkingSpeed);

  final double? walkingSpeed;

  @override
  List<Object?> get props => [walkingSpeed];
}

final class WalkingPreferencesSaveRequested extends WalkingPreferencesEvent {
  const WalkingPreferencesSaveRequested();
}

final class WalkingPreferencesSaveAcknowledged extends WalkingPreferencesEvent {
  const WalkingPreferencesSaveAcknowledged();
}
