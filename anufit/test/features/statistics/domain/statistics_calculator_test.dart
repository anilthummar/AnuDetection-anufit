import 'package:flutter_test/flutter_test.dart';

import 'package:anufit/core/enums/gender.dart';
import 'package:anufit/core/enums/unit_system.dart';
import 'package:anufit/features/history/domain/entities/history_entity.dart';
import 'package:anufit/features/onboarding/domain/entities/user_entity.dart';
import 'package:anufit/features/statistics/domain/services/statistics_calculator.dart';

void main() {
  final user = UserEntity(
    id: 1,
    age: 30,
    gender: Gender.male,
    height: 175,
    weight: 72,
    dailyGoal: 10000,
    unit: UnitSystem.metric,
    autoStride: true,
    createdAt: DateTime(2026, 1, 1),
  );

  test('StatisticsCalculator.fromDailySummaries computes totals', () {
    final metrics = StatisticsCalculator.fromDailySummaries(
      days: [
        DailySummaryEntity(
          date: DateTime(2026, 6, 28),
          steps: 8000,
          distanceKm: 6,
          calories: 320,
          walkingTime: const Duration(hours: 1),
          goalCompleted: false,
        ),
        DailySummaryEntity(
          date: DateTime(2026, 6, 29),
          steps: 12000,
          distanceKm: 9,
          calories: 480,
          walkingTime: const Duration(hours: 1, minutes: 30),
          goalCompleted: true,
        ),
      ],
      goal: 10000,
    );

    expect(metrics.steps, 20000);
    expect(metrics.goalCompletionRate, 0.5);
    expect(metrics.averageDailySteps, 10000);
  });

  test('StatisticsCalculator.daily computes active hours', () {
    final metrics = StatisticsCalculator.daily(
      steps: 5000,
      user: user,
      goal: 10000,
      hourly: const [],
    );
    expect(metrics.steps, 5000);
    expect(metrics.goalCompletionRate, 0.5);
  });
}
