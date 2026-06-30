import 'package:flutter_test/flutter_test.dart';

import 'package:anufit/core/enums/gender.dart';
import 'package:anufit/core/enums/unit_system.dart';
import 'package:anufit/features/goals/domain/entities/goal_entity.dart';
import 'package:anufit/features/goals/domain/services/goal_engine.dart';
import 'package:anufit/features/onboarding/domain/entities/user_entity.dart';

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

  test('resolveStatus returns inProgress for partial steps', () {
    expect(
      GoalEngine.resolveStatus(currentSteps: 5000, stepGoal: 10000),
      GoalStatus.inProgress,
    );
  });

  test('resolveStatus returns exceeded above goal', () {
    expect(
      GoalEngine.resolveStatus(currentSteps: 12000, stepGoal: 10000),
      GoalStatus.exceeded,
    );
  });

  test('buildProgress calculates remaining steps', () {
    final progress = GoalEngine.buildProgress(
      goal: GoalEntity(stepGoal: 10000, updatedAt: DateTime.now()),
      currentSteps: 8250,
      user: user,
      now: DateTime(2026, 6, 29, 14),
    );
    expect(progress.remainingSteps, 1750);
    expect(progress.completionPercentage, closeTo(0.825, 0.001));
  });
}
