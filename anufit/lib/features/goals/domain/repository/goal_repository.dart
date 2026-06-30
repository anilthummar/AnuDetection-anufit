import 'package:anufit/features/goals/domain/entities/goal_entity.dart';

abstract class GoalRepository {
  Future<GoalEntity> getGoal();

  Future<GoalProgressEntity> getGoalProgress();

  Stream<GoalProgressEntity> watchGoalProgress();

  Future<void> updateGoal(GoalEntity goal);

  Future<void> resetGoal();

  Future<double> calculateCompletion({int? currentSteps});

  Future<DateTime?> estimateCompletionTime({int? currentSteps});

  void dispose();
}
