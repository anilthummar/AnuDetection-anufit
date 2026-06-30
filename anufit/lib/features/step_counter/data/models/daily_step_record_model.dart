import 'package:isar_community/isar.dart';

part 'daily_step_record_model.g.dart';

@collection
class DailyStepRecordModel {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late DateTime date;

  int steps = 0;

  int hardwareBaseline = 0;

  int hardwareTotalEnd = 0;
}
