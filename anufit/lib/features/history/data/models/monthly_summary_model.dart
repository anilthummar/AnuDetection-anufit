import 'package:isar_community/isar.dart';

part 'monthly_summary_model.g.dart';

@collection
class MonthlySummaryModel {
  Id id = Isar.autoIncrement;

  @Index(composite: [CompositeIndex('year')])
  late int month;

  late int year;

  int steps = 0;
  double distanceKm = 0;
  double calories = 0;
  int walkingTimeMinutes = 0;
  int activeDays = 0;
}
