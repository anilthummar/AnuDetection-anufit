part of 'dashboard_bloc.dart';

sealed class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => [];
}

final class LoadDashboard extends DashboardEvent {
  const LoadDashboard();
}

final class RefreshDashboard extends DashboardEvent {
  const RefreshDashboard();
}

final class LiveStepsUpdated extends DashboardEvent {
  const LiveStepsUpdated(this.data);

  final StepData data;

  @override
  List<Object?> get props => [data];
}

final class GoalChanged extends DashboardEvent {
  const GoalChanged(this.goal);

  final int goal;

  @override
  List<Object?> get props => [goal];
}

final class HealthSyncCompleted extends DashboardEvent {
  const HealthSyncCompleted();
}

final class UserProfileUpdated extends DashboardEvent {
  const UserProfileUpdated();
}

final class DashboardStartWalkRequested extends DashboardEvent {
  const DashboardStartWalkRequested();
}

final class DashboardPauseTrackingRequested extends DashboardEvent {
  const DashboardPauseTrackingRequested();
}

final class DashboardResumeTrackingRequested extends DashboardEvent {
  const DashboardResumeTrackingRequested();
}

final class DashboardErrorOccurred extends DashboardEvent {
  const DashboardErrorOccurred(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
