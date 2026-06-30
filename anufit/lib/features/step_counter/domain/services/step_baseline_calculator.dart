import 'package:anufit/features/step_counter/domain/entities/step_data.dart';

/// Pure baseline math for hardware step counters.
abstract final class StepBaselineCalculator {
  static int dailySteps({
    required int hardwareTotal,
    required int dailyBaseline,
    int manualAdjustment = 0,
  }) {
    final raw = hardwareTotal - dailyBaseline;
    return (raw + manualAdjustment).clamp(0, 1 << 30);
  }

  static DateTime localDate(DateTime moment) {
    return DateTime(moment.year, moment.month, moment.day);
  }

  static int newDayBaseline(int hardwareTotal) => hardwareTotal;

  static int baselineAfterHardwareReset({
    required int lastHardwareTotal,
    required int lastDailyBaseline,
    required int newHardwareTotal,
  }) {
    if (newHardwareTotal >= lastHardwareTotal) {
      return lastDailyBaseline;
    }
    final previousDaily = dailySteps(
      hardwareTotal: lastHardwareTotal,
      dailyBaseline: lastDailyBaseline,
    );
    return newHardwareTotal - previousDaily;
  }

  static bool isNewLocalDay({
    required DateTime storedDate,
    required DateTime now,
    required String storedTimezone,
    required String currentTimezone,
  }) {
    if (storedTimezone != currentTimezone) {
      return true;
    }
    return localDate(storedDate) != localDate(now);
  }

  static StepBaseline rolloverBaseline({
    required StepBaseline current,
    required int hardwareTotal,
    required DateTime now,
    required String timezoneId,
  }) {
    return StepBaseline(
      date: localDate(now),
      hardwareBaseline: newDayBaseline(hardwareTotal),
      lastHardwareTotal: hardwareTotal,
      timezoneId: timezoneId,
      manualAdjustment: 0,
    );
  }
}
