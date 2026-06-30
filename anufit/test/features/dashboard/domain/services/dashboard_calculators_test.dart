import 'package:flutter_test/flutter_test.dart';

import 'package:anufit/features/dashboard/domain/services/dashboard_calculators.dart';
import 'package:anufit/features/onboarding/domain/entities/user_entity.dart';
import 'package:anufit/core/enums/gender.dart';
import 'package:anufit/core/enums/unit_system.dart';

void main() {
  final user = UserEntity(
    id: 1,
    name: 'Anil',
    age: 30,
    gender: Gender.male,
    height: 175,
    weight: 72,
    dailyGoal: 10000,
    unit: UnitSystem.metric,
    autoStride: true,
    createdAt: DateTime(2026, 1, 1),
  );

  group('ActivityMetricsCalculator', () {
    test('calculates calories from steps', () {
      expect(ActivityMetricsCalculator.calories(2500), 100);
    });

    test('calculates completion percentage', () {
      expect(
        ActivityMetricsCalculator.completionPercentage(current: 7500, goal: 10000),
        0.75,
      );
    });

    test('calculates distance using stride', () {
      final distance = ActivityMetricsCalculator.distanceKm(steps: 1000, user: user);
      expect(distance, greaterThan(0));
    });

    test('calculates walking time for manual stride stored in meters', () {
      final imperialUser = UserEntity(
        id: 2,
        age: 30,
        gender: Gender.male,
        height: 170,
        weight: 71,
        dailyGoal: 3000,
        strideLength: 0.71,
        unit: UnitSystem.imperial,
        autoStride: false,
        createdAt: DateTime(2026, 1, 1),
      );
      final distance = ActivityMetricsCalculator.distanceKm(steps: 1141, user: imperialUser);
      final walkingTime = ActivityMetricsCalculator.walkingTime(steps: 1141, user: imperialUser);

      expect(distance, closeTo(0.81, 0.05));
      expect(walkingTime.inMinutes, greaterThan(5));
    });
  });

  group('StreakCalculator', () {
    test('counts consecutive goal days', () {
      final today = DateTime(2026, 6, 29);
      final streak = StreakCalculator.calculate(
        dailyRecords: [
          (date: today, steps: 12000),
          (date: today.subtract(const Duration(days: 1)), steps: 11000),
          (date: today.subtract(const Duration(days: 2)), steps: 9000),
        ],
        goal: 10000,
        today: today,
      );
      expect(streak.currentStreak, 2);
      expect(streak.longestStreak, 2);
    });
  });

  group('AchievementCalculator', () {
    test('unlocks milestones based on today steps', () {
      final achievements = AchievementCalculator.preview(
        todaySteps: 5200,
        historicalDailySteps: const [3000, 8000],
      );
      expect(achievements.any((a) => a.id == 'steps_5k' && a.isUnlocked), isTrue);
    });
  });

  group('greetingForHour', () {
    test('returns morning greeting before noon', () {
      expect(greetingForHour(9), 'Good Morning');
    });
  });
}
