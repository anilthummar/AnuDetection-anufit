import 'package:isar_community/isar.dart';

part 'activity_timeline_model.g.dart';

@collection
class ActivityTimelineModel {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String dayHourKey;

  late DateTime date;

  late int hour;

  int steps = 0;

  double distanceKm = 0;

  double calories = 0;

  int walkingTimeMinutes = 0;
}
