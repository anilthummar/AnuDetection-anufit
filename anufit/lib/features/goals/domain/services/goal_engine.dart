import 'package:anufit/core/services/activity_metrics_calculator.dart';
import 'package:anufit/features/goals/domain/entities/goal_entity.dart';
import 'package:anufit/features/onboarding/domain/entities/user_entity.dart';

abstract final class GoalEngine {
  static GoalStatus resolveStatus({
    required int currentSteps,
    required int stepGoal,
  }) {
    if (currentSteps <= 0) return GoalStatus.notStarted;
    if (currentSteps > stepGoal) return GoalStatus.exceeded;
    if (currentSteps >= stepGoal) return GoalStatus.completed;
    return GoalStatus.inProgress;
  }

  static GoalProgressEntity buildProgress({
    required GoalEntity goal,
    required int currentSteps,
    required UserEntity user,
    required DateTime now,
  }) {
    final distance = ActivityMetricsCalculator.distanceKm(steps: currentSteps, user: user);
    final calories = ActivityMetricsCalculator.calories(currentSteps);
    final walkingTime = ActivityMetricsCalculator.walkingTime(steps: currentSteps, user: user);
    final completion = ActivityMetricsCalculator.completionPercentage(
      current: currentSteps,
      goal: goal.stepGoal,
    );

    return GoalProgressEntity(
      goal: goal,
      currentSteps: currentSteps,
      currentDistanceKm: distance,
      currentCalories: calories,
      currentWalkingTime: walkingTime,
      status: resolveStatus(currentSteps: currentSteps, stepGoal: goal.stepGoal),
      completionPercentage: completion,
      remainingSteps: (goal.stepGoal - currentSteps).clamp(0, goal.stepGoal),
      estimatedCompletion: ActivityMetricsCalculator.estimatedCompletion(
        todaySteps: currentSteps,
        goal: goal.stepGoal,
        now: now,
      ),
    );
  }
}
