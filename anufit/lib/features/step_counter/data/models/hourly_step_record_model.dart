import 'package:isar_community/isar.dart';

part 'hourly_step_record_model.g.dart';

@collection
class HourlyStepRecordModel {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late DateTime hourStart;

  int steps = 0;
}
