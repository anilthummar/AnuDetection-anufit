part of 'walking_preferences_bloc.dart';

class WalkingPreferencesState extends Equatable {
  const WalkingPreferencesState({
    this.unit = UnitSystem.metric,
    this.strideLength = 0.75,
    this.autoStride = true,
    this.walkingSpeed,
    this.isSaving = false,
    this.isSaved = false,
  });

  final UnitSystem unit;
  final double strideLength;
  final bool autoStride;
  final double? walkingSpeed;
  final bool isSaving;
  final bool isSaved;

  WalkingPreferencesState copyWith({
    UnitSystem? unit,
    double? strideLength,
    bool? autoStride,
    double? walkingSpeed,
    bool? isSaving,
    bool? isSaved,
  }) {
    return WalkingPreferencesState(
      unit: unit ?? this.unit,
      strideLength: strideLength ?? this.strideLength,
      autoStride: autoStride ?? this.autoStride,
      walkingSpeed: walkingSpeed ?? this.walkingSpeed,
      isSaving: isSaving ?? this.isSaving,
      isSaved: isSaved ?? this.isSaved,
    );
  }

  @override
  List<Object?> get props => [unit, strideLength, autoStride, walkingSpeed, isSaving, isSaved];
}
