import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

import 'package:anufit/core/services/local_notification_service.dart';
import 'package:anufit/features/reminder/domain/entities/reminder_entity.dart';

@lazySingleton
class ReminderScheduler {
  ReminderScheduler(this._notifications);

  final LocalNotificationService _notifications;

  Future<void> scheduleAll(List<ReminderEntity> reminders) async {
    for (final reminder in reminders) {
      if (reminder.enabled) {
        await schedule(reminder);
      } else {
        await cancel(reminder.notificationId);
      }
    }
  }

  Future<void> schedule(ReminderEntity reminder) async {
    await _notifications.initialize();
    tz_data.initializeTimeZones();
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      reminder.hour,
      reminder.minute,
    );
    if (scheduled.isBefore(now) && reminder.repeat != ReminderRepeat.once) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    final match = switch (reminder.repeat) {
      ReminderRepeat.daily => DateTimeComponents.time,
      ReminderRepeat.weekly => DateTimeComponents.dayOfWeekAndTime,
      ReminderRepeat.monthly => DateTimeComponents.dayOfMonthAndTime,
      ReminderRepeat.once || ReminderRepeat.custom => null,
    };

    await _notifications.scheduleReminder(
      id: reminder.notificationId,
      title: reminder.title,
      body: reminder.description,
      scheduledDate: scheduled,
      matchComponents: match,
    );
  }

  Future<void> cancel(int notificationId) =>
      _notifications.cancelReminder(notificationId);
}
