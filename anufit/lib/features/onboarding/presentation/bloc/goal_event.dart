part of 'goal_bloc.dart';

sealed class GoalEvent extends Equatable {
  const GoalEvent();

  @override
  List<Object?> get props => [];
}

final class GoalLoadExisting extends GoalEvent {
  const GoalLoadExisting();
}

final class GoalPresetSelected extends GoalEvent {
  const GoalPresetSelected(this.goal);

  final int goal;

  @override
  List<Object?> get props => [goal];
}

final class GoalCustomChanged extends GoalEvent {
  const GoalCustomChanged(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}

final class GoalSaveRequested extends GoalEvent {
  const GoalSaveRequested();
}

final class GoalSaveAcknowledged extends GoalEvent {
  const GoalSaveAcknowledged();
}
