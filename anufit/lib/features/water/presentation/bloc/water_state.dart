part of 'water_bloc.dart';

sealed class WaterState extends Equatable {
  const WaterState();

  @override
  List<Object?> get props => [];
}

class WaterInitial extends WaterState {
  const WaterInitial();
}

class WaterLoading extends WaterState {
  const WaterLoading();
}

class WaterLoaded extends WaterState {
  const WaterLoaded({required this.dashboard, this.isSaving = false});

  final WaterDashboardEntity dashboard;
  final bool isSaving;

  WaterLoaded copyWith({WaterDashboardEntity? dashboard, bool? isSaving}) {
    return WaterLoaded(
      dashboard: dashboard ?? this.dashboard,
      isSaving: isSaving ?? this.isSaving,
    );
  }

  @override
  List<Object?> get props => [dashboard, isSaving];
}

class WaterError extends WaterState {
  const WaterError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
