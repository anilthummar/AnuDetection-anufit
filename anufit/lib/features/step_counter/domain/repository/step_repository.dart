import 'package:anufit/features/step_counter/domain/entities/hourly_step_point.dart';
import 'package:anufit/features/step_counter/domain/entities/step_data.dart';

abstract class StepRepository {
  Stream<StepData> watchLiveSteps();

  Future<void> startTracking();

  Future<void> stopTracking();

  Future<void> pauseTracking();

  Future<void> resumeTracking();

  Future<void> resetTodaySteps();

  Future<void> adjustSteps(int adjustment);

  Future<int> getTodaySteps();

  Future<List<StepPeriodSummary>> getWeeklySteps();

  Future<List<StepPeriodSummary>> getMonthlySteps();

  Future<List<HourlyStepPoint>> getTodayHourlySteps();

  Future<List<HourlyStepPoint>> getHourlyStepsForDate(DateTime date);

  Future<List<StepPeriodSummary>> getDailySummaries({
    required DateTime start,
    required DateTime end,
  });

  Future<int> getLifetimeSteps();
}
