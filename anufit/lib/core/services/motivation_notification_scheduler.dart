import 'package:injectable/injectable.dart';

import 'package:anufit/core/services/local_notification_service.dart';
import 'package:anufit/features/goals/domain/repository/goal_repository.dart';
import 'package:anufit/features/step_counter/domain/repository/step_repository.dart';

@lazySingleton
class MotivationNotificationScheduler {
  MotivationNotificationScheduler(
    this._notifications,
    this._stepRepository,
    this._goalRepository,
  );

  final LocalNotificationService _notifications;
  final StepRepository _stepRepository;
  final GoalRepository _goalRepository;

  bool _scheduled = false;

  Future<void> scheduleMotivationReminders() async {
    if (_scheduled) return;
    await _notifications.initialize();
    await _notifications.scheduleDailyReminder();
    await _notifications.scheduleStreakCheck();
    _scheduled = true;
  }

  Future<void> checkStreakAtRisk() async {
    final goal = await _goalRepository.getGoal();
    final steps = await _stepRepository.getTodaySteps();
    if (steps >= goal.stepGoal) return;

    final weekly = await _stepRepository.getWeeklySteps();
    if (weekly.length < 2) return;

    final sorted = [...weekly]..sort((a, b) => b.periodStart.compareTo(a.periodStart));
    var streak = 0;
    for (final day in sorted) {
      if (day.steps >= goal.stepGoal) {
        streak++;
      } else {
        break;
      }
    }

    if (streak >= 3) {
      await _notifications.showStreakAtRisk(streak: streak);
    }
  }
}
