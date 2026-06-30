part of 'motivation_goal_bloc.dart';

sealed class MotivationGoalEvent extends Equatable {
  const MotivationGoalEvent();
  @override
  List<Object?> get props => [];
}

final class MotivationGoalLoadRequested extends MotivationGoalEvent {
  const MotivationGoalLoadRequested();
}

final class MotivationGoalUpdateRequested extends MotivationGoalEvent {
  const MotivationGoalUpdateRequested(this.goal);
  final GoalEntity goal;
  @override
  List<Object?> get props => [goal];
}

final class MotivationGoalResetRequested extends MotivationGoalEvent {
  const MotivationGoalResetRequested();
}

final class MotivationGoalProgressUpdated extends MotivationGoalEvent {
  const MotivationGoalProgressUpdated(this.progress);
  final GoalProgressEntity progress;
  @override
  List<Object?> get props => [progress];
}
