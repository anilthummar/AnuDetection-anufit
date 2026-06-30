import 'package:isar_community/isar.dart';

part 'weight_goal_model.g.dart';

@collection
class WeightGoalModel {
  Id id = 1;
  double goalWeightKg = 0;
  late DateTime updatedAt;
}
