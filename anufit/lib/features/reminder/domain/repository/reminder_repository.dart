import 'package:anufit/features/reminder/domain/entities/reminder_entity.dart';

abstract class ReminderRepository {
  Future<List<ReminderEntity>> getReminders();
  Future<ReminderEntity> saveReminder(ReminderEntity reminder);
  Future<void> deleteReminder(int id);
  Future<void> toggleReminder(int id, bool enabled);
  Future<void> rescheduleAll();
}
