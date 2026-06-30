import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:anufit/features/reminder/domain/entities/reminder_entity.dart';
import 'package:anufit/features/reminder/domain/repository/reminder_repository.dart';

part 'reminder_event.dart';
part 'reminder_state.dart';

@injectable
class ReminderBloc extends Bloc<ReminderEvent, ReminderState> {
  ReminderBloc(this._repository) : super(const ReminderInitial()) {
    on<ReminderLoadRequested>(_onLoad);
    on<ReminderToggleRequested>(_onToggle);
    on<ReminderSaveRequested>(_onSave);
    on<ReminderDeleteRequested>(_onDelete);
  }

  final ReminderRepository _repository;

  Future<void> _onLoad(ReminderLoadRequested event, Emitter<ReminderState> emit) async {
    emit(const ReminderLoading());
    try {
      final reminders = await _repository.getReminders();
      await _repository.rescheduleAll();
      emit(ReminderLoaded(reminders: reminders));
    } catch (e) {
      emit(ReminderError(e.toString()));
    }
  }

  Future<void> _onToggle(ReminderToggleRequested event, Emitter<ReminderState> emit) async {
    await _repository.toggleReminder(event.id, event.enabled);
    add(const ReminderLoadRequested());
  }

  Future<void> _onSave(ReminderSaveRequested event, Emitter<ReminderState> emit) async {
    await _repository.saveReminder(event.reminder);
    add(const ReminderLoadRequested());
  }

  Future<void> _onDelete(ReminderDeleteRequested event, Emitter<ReminderState> emit) async {
    await _repository.deleteReminder(event.id);
    add(const ReminderLoadRequested());
  }
}
