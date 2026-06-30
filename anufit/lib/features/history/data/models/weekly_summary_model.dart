import 'package:isar_community/isar.dart';

part 'weekly_summary_model.g.dart';

@collection
class WeeklySummaryModel {
  Id id = Isar.autoIncrement;

  @Index(composite: [CompositeIndex('year')])
  late int week;

  late int year;

  int steps = 0;
  double distanceKm = 0;
  double calories = 0;
  int walkingTimeMinutes = 0;
}
