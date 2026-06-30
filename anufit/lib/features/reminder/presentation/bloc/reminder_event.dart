part of 'reminder_bloc.dart';

sealed class ReminderEvent extends Equatable {
  const ReminderEvent();

  @override
  List<Object?> get props => [];
}

class ReminderLoadRequested extends ReminderEvent {
  const ReminderLoadRequested();
}

class ReminderToggleRequested extends ReminderEvent {
  const ReminderToggleRequested({required this.id, required this.enabled});

  final int id;
  final bool enabled;

  @override
  List<Object?> get props => [id, enabled];
}

class ReminderSaveRequested extends ReminderEvent {
  const ReminderSaveRequested(this.reminder);

  final ReminderEntity reminder;

  @override
  List<Object?> get props => [reminder];
}

class ReminderDeleteRequested extends ReminderEvent {
  const ReminderDeleteRequested(this.id);

  final int id;

  @override
  List<Object?> get props => [id];
}
