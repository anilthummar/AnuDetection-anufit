import 'package:isar_community/isar.dart';

part 'step_tracking_state_model.g.dart';

@collection
class StepTrackingStateModel {
  Id id = 1;

  int dailyBaseline = 0;

  int lastHardwareTotal = 0;

  late DateTime baselineDate;

  String timezoneId = '';

  bool isTracking = false;

  bool isPaused = false;

  int manualAdjustment = 0;
}
