part of 'step_tracking_bloc.dart';

sealed class StepTrackingEvent extends Equatable {
  const StepTrackingEvent();

  @override
  List<Object?> get props => [];
}

final class StepTrackingLiveUpdate extends StepTrackingEvent {
  const StepTrackingLiveUpdate(this.data);

  final StepData data;

  @override
  List<Object?> get props => [data];
}

final class StepTrackingStartRequested extends StepTrackingEvent {
  const StepTrackingStartRequested();
}

final class StepTrackingStopRequested extends StepTrackingEvent {
  const StepTrackingStopRequested();
}

final class StepTrackingPauseRequested extends StepTrackingEvent {
  const StepTrackingPauseRequested();
}

final class StepTrackingResumeRequested extends StepTrackingEvent {
  const StepTrackingResumeRequested();
}

final class StepTrackingResetRequested extends StepTrackingEvent {
  const StepTrackingResetRequested();
}

final class StepTrackingAdjustRequested extends StepTrackingEvent {
  const StepTrackingAdjustRequested(this.adjustment);

  final int adjustment;

  @override
  List<Object?> get props => [adjustment];
}

final class StepTrackingRefreshSummariesRequested extends StepTrackingEvent {
  const StepTrackingRefreshSummariesRequested();
}

final class StepTrackingErrorOccurred extends StepTrackingEvent {
  const StepTrackingErrorOccurred(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
