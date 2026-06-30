import 'package:flutter_test/flutter_test.dart';

import 'package:anufit/core/enums/gender.dart';
import 'package:anufit/core/enums/unit_system.dart';
import 'package:anufit/features/activity/domain/services/timeline_aggregator.dart';
import 'package:anufit/features/onboarding/domain/entities/user_entity.dart';
import 'package:anufit/features/step_counter/domain/entities/hourly_step_point.dart';

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

  test('TimelineAggregator finds peak hour', () {
    final entries = TimelineAggregator.buildEntries(
      hourly: const [
        HourlyStepPoint(hour: 7, steps: 500),
        HourlyStepPoint(hour: 8, steps: 1200),
        HourlyStepPoint(hour: 9, steps: 800),
      ],
      user: user,
      stepGoal: 10000,
    );
    final summary = TimelineAggregator.summarize(entries);
    expect(summary.peakHour, 8);
    expect(summary.totalSteps, 2500);
  });

  test('TimelineAggregator merges hourly data across days', () {
    final entries = TimelineAggregator.mergeHourlyAcrossDays(
      dailyHourly: const [
        [HourlyStepPoint(hour: 8, steps: 400)],
        [HourlyStepPoint(hour: 8, steps: 600)],
      ],
      user: user,
      stepGoal: 10000,
    );
    expect(entries.single.steps, 1000);
  });
}
