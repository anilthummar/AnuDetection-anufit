import 'package:anufit/features/activity/domain/entities/timeline_entity.dart';
import 'package:anufit/features/step_counter/domain/entities/step_data.dart';

abstract class ActivityRepository {
  Future<TimelineSummary> getTimeline(TimelineFilter filter, {DateTime? customDate});

  Future<List<ActivityInsight>> getInsights();

  Future<List<StepPeriodSummary>> getWeeklySummaries();

  Future<Map<DateTime, List<TimelineEntry>>> getHeatmapData(
    TimelineFilter filter, {
    DateTime? customDate,
  });

  Future<void> syncTimelineForDate(DateTime date);
}
