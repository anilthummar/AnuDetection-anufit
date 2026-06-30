import 'package:isar_community/isar.dart';

part 'achievement_model.g.dart';

@collection
class AchievementModel {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String ruleId;

  late String title;

  late String category;

  bool completed = false;

  DateTime? completedAt;

  double progress = 0;

  int xp = 0;
}
