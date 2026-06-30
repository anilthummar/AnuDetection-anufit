part of 'step_tracking_bloc.dart';

class StepTrackingState extends Equatable {
  const StepTrackingState({
    required this.liveData,
    required this.todaySteps,
    required this.weeklySteps,
    required this.monthlySteps,
    required this.isBusy,
    this.errorMessage,
  });

  factory StepTrackingState.initial() {
    return StepTrackingState(
      liveData: StepData.initial(),
      todaySteps: 0,
      weeklySteps: const [],
      monthlySteps: const [],
      isBusy: false,
    );
  }

  final StepData liveData;
  final int todaySteps;
  final List<StepPeriodSummary> weeklySteps;
  final List<StepPeriodSummary> monthlySteps;
  final bool isBusy;
  final String? errorMessage;

  StepTrackingState copyWith({
    StepData? liveData,
    int? todaySteps,
    List<StepPeriodSummary>? weeklySteps,
    List<StepPeriodSummary>? monthlySteps,
    bool? isBusy,
    String? errorMessage,
    bool clearError = false,
  }) {
    return StepTrackingState(
      liveData: liveData ?? this.liveData,
      todaySteps: todaySteps ?? this.todaySteps,
      weeklySteps: weeklySteps ?? this.weeklySteps,
      monthlySteps: monthlySteps ?? this.monthlySteps,
      isBusy: isBusy ?? this.isBusy,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        liveData,
        todaySteps,
        weeklySteps,
        monthlySteps,
        isBusy,
        errorMessage,
      ];
}
