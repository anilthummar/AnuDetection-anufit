import 'package:isar_community/isar.dart';

part 'reminder_model.g.dart';

@collection
class ReminderModel {
  Id id = Isar.autoIncrement;

  String title = '';
  String description = '';
  String type = 'custom';
  String repeat = 'daily';
  int hour = 9;
  int minute = 0;
  bool enabled = true;
  int notificationId = 0;
}
