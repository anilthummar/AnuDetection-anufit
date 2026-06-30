import 'package:anufit/core/entities/streak_info.dart';
import 'package:anufit/features/dashboard/domain/entities/dashboard_summary.dart';
import 'package:anufit/features/step_counter/domain/entities/hourly_step_point.dart';
import 'package:anufit/features/step_counter/domain/entities/step_data.dart';

abstract class DashboardRepository {
  Future<DashboardSummary> getTodaySummary();

  Stream<StepData> watchLiveSteps();

  Future<GoalProgress> getGoalProgress({int? todaySteps});

  Future<double> getCalories({int? steps});

  Future<double> getDistance({int? steps});

  Future<Duration> getWalkingTime({int? steps});

  Future<StreakInfo> getCurrentStreak();

  Future<List<Achievement>> getAchievementsPreview({int? todaySteps});

  Future<List<HourlyStepPoint>> getHourlySteps();

  Future<void> startTracking();

  Future<void> pauseTracking();

  Future<void> resumeTracking();
}
