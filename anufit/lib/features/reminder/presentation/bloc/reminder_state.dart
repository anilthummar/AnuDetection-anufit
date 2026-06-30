part of 'reminder_bloc.dart';

sealed class ReminderState extends Equatable {
  const ReminderState();

  @override
  List<Object?> get props => [];
}

class ReminderInitial extends ReminderState {
  const ReminderInitial();
}

class ReminderLoading extends ReminderState {
  const ReminderLoading();
}

class ReminderLoaded extends ReminderState {
  const ReminderLoaded({required this.reminders});

  final List<ReminderEntity> reminders;

  @override
  List<Object?> get props => [reminders];
}

class ReminderError extends ReminderState {
  const ReminderError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
