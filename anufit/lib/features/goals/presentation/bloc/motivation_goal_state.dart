part of 'motivation_goal_bloc.dart';

sealed class MotivationGoalState extends Equatable {
  const MotivationGoalState();
  @override
  List<Object?> get props => [];
}

final class MotivationGoalInitial extends MotivationGoalState {
  const MotivationGoalInitial();
}

final class MotivationGoalLoading extends MotivationGoalState {
  const MotivationGoalLoading();
}

final class MotivationGoalLoaded extends MotivationGoalState {
  const MotivationGoalLoaded({required this.progress});
  final GoalProgressEntity progress;
  @override
  List<Object?> get props => [progress];
}

final class MotivationGoalError extends MotivationGoalState {
  const MotivationGoalError(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
