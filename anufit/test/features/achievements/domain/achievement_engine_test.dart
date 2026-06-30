import 'package:flutter_test/flutter_test.dart';

import 'package:anufit/features/achievements/domain/entities/achievement_entity.dart';
import 'package:anufit/features/achievements/domain/rules/achievement_rules.dart';
import 'package:anufit/features/achievements/domain/services/achievement_engine.dart';

void main() {
  const stats = UserStats(
    todaySteps: 12000,
    lifetimeSteps: 120000,
    currentStreak: 8,
    longestStreak: 20,
    todayDistanceKm: 8,
    lifetimeDistanceKm: 120,
    todayCalories: 480,
    lifetimeCalories: 4800,
    todayWalkingTime: const Duration(hours: 1, minutes: 30),
    lifetimeWalkingTime: const Duration(hours: 40),
    averageDailySteps: 8500,
    goalCompletionRate: 1.2,
  );

  test('SevenDayStreakRule unlocks at 7 days', () {
    final rule = SevenDayStreakRule();
    expect(rule.isUnlocked(stats), isTrue);
    expect(rule.rewardXp(), 70);
  });

  test('Lifetime100kStepsRule reports progress', () {
    final rule = Lifetime100kStepsRule();
    expect(rule.isUnlocked(stats), isTrue);
    expect(rule.progress(stats), closeTo(1.0, 0.01));
  });

  test('AchievementEngine detects newly unlocked achievements', () {
    final evaluations = AchievementEngine.evaluate(stats: stats, stored: {});
    final unlocked = evaluations.where((e) => e.newlyUnlocked).length;
    expect(unlocked, greaterThan(0));
  });
}
