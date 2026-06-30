import 'package:isar_community/isar.dart';

part 'goal_model.g.dart';

@collection
class GoalModel {
  Id goalId = 1;

  int stepGoal = 10000;

  double? distanceGoalKm;

  double? calorieGoal;

  int? walkingTimeGoalMinutes;

  late DateTime updatedAt;
}
