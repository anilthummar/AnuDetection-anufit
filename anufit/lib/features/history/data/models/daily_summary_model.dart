import 'package:isar_community/isar.dart';

part 'daily_summary_model.g.dart';

@collection
class DailySummaryModel {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late DateTime date;

  int steps = 0;
  double distanceKm = 0;
  double calories = 0;
  int walkingTimeMinutes = 0;
  bool goalCompleted = false;
}
