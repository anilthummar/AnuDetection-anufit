import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

@lazySingleton
class LocalNotificationService {
  LocalNotificationService();

  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();
    await _plugin.initialize(
      const InitializationSettings(android: android, iOS: ios),
    );

    const channel = AndroidNotificationChannel(
      'anufit_motivation',
      'Motivation',
      description: 'Goal, streak, and achievement notifications',
      importance: Importance.high,
    );

    const reminderChannel = AndroidNotificationChannel(
      'anufit_reminders',
      'Reminders',
      description: 'Walking, water, weight, and custom reminders',
      importance: Importance.high,
    );

    final androidPlugin = _plugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    await androidPlugin?.createNotificationChannel(channel);
    await androidPlugin?.createNotificationChannel(reminderChannel);

    _initialized = true;
  }

  Future<void> scheduleReminder({
    required int id,
    required String title,
    required String body,
    required tz.TZDateTime scheduledDate,
    DateTimeComponents? matchComponents,
  }) async {
    if (!_initialized) await initialize();
    await _plugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      _reminderDetails,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: matchComponents,
    );
  }

  Future<void> cancelReminder(int id) async {
    if (!_initialized) await initialize();
    await _plugin.cancel(id);
  }

  static const _reminderDetails = NotificationDetails(
    android: AndroidNotificationDetails(
      'anufit_reminders',
      'Reminders',
      importance: Importance.high,
      priority: Priority.high,
    ),
    iOS: DarwinNotificationDetails(),
  );

  Future<void> showGoalCompleted({required int steps, required int goal}) {
    return _show(
      id: 1001,
      title: 'Goal completed! 🎉',
      body: 'You hit $steps steps (goal: $goal).',
    );
  }

  Future<void> showHalfwayToGoal({required int steps, required int goal}) {
    return _show(
      id: 1002,
      title: 'Halfway there!',
      body: '$steps / $goal steps — keep going.',
    );
  }

  Future<void> showDailyReminder() {
    return _show(
      id: 1003,
      title: 'Time to move',
      body: 'A short walk helps you stay on track today.',
    );
  }

  Future<void> showStreakAtRisk({required int streak}) {
    return _show(
      id: 1004,
      title: 'Streak at risk 🔥',
      body: 'Your $streak-day streak needs steps before midnight.',
    );
  }

  Future<void> showAchievementUnlocked({
    required String title,
    required int xp,
  }) {
    return _show(
      id: 1005,
      title: 'Achievement unlocked 🏆',
      body: '$title — +$xp XP',
    );
  }

  Future<void> scheduleDailyReminder() async {
    if (!_initialized) await initialize();
    tz_data.initializeTimeZones();
    final now = tz.TZDateTime.now(tz.local);
    final scheduled = tz.TZDateTime(tz.local, now.year, now.month, now.day, 9);
    await _plugin.zonedSchedule(
      2001,
      'Time to move',
      'A short walk helps you stay on track today.',
      scheduled.isBefore(now) ? scheduled.add(const Duration(days: 1)) : scheduled,
      _scheduledDetails,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> scheduleStreakCheck() async {
    if (!_initialized) await initialize();
    tz_data.initializeTimeZones();
    final now = tz.TZDateTime.now(tz.local);
    final scheduled = tz.TZDateTime(tz.local, now.year, now.month, now.day, 20);
    await _plugin.zonedSchedule(
      2002,
      'Streak check',
      'Check your steps before the day ends.',
      scheduled.isBefore(now) ? scheduled.add(const Duration(days: 1)) : scheduled,
      _scheduledDetails,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  static const _scheduledDetails = NotificationDetails(
    android: AndroidNotificationDetails(
      'anufit_motivation',
      'Motivation',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
    ),
    iOS: DarwinNotificationDetails(),
  );

  Future<void> _show({
    required int id,
    required String title,
    required String body,
  }) async {
    if (!_initialized) await initialize();
    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        'anufit_motivation',
        'Motivation',
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );
    await _plugin.show(id, title, body, details);
  }
}
