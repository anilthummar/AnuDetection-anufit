part of 'weight_bloc.dart';

sealed class WeightState extends Equatable {
  const WeightState();

  @override
  List<Object?> get props => [];
}

class WeightInitial extends WeightState {
  const WeightInitial();
}

class WeightLoading extends WeightState {
  const WeightLoading();
}

class WeightLoaded extends WeightState {
  const WeightLoaded({
    required this.dashboard,
    required this.chartPeriod,
    this.isSaving = false,
  });

  final WeightDashboardEntity dashboard;
  final WeightChartPeriod chartPeriod;
  final bool isSaving;

  WeightLoaded copyWith({
    WeightDashboardEntity? dashboard,
    WeightChartPeriod? chartPeriod,
    bool? isSaving,
  }) {
    return WeightLoaded(
      dashboard: dashboard ?? this.dashboard,
      chartPeriod: chartPeriod ?? this.chartPeriod,
      isSaving: isSaving ?? this.isSaving,
    );
  }

  @override
  List<Object?> get props => [dashboard, chartPeriod, isSaving];
}

class WeightError extends WeightState {
  const WeightError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
