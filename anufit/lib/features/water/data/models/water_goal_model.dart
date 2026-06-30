import 'package:isar_community/isar.dart';

part 'water_goal_model.g.dart';

@collection
class WaterGoalModel {
  Id id = 1;
  double dailyGoalLiters = 2.0;
  late DateTime updatedAt;
}
