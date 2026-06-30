import 'package:anufit/core/services/activity_metrics_calculator.dart';
import 'package:anufit/features/activity/domain/entities/timeline_entity.dart';
import 'package:anufit/features/onboarding/domain/entities/user_entity.dart';
import 'package:anufit/features/step_counter/domain/entities/hourly_step_point.dart';
import 'package:anufit/features/step_counter/domain/entities/step_data.dart';

abstract final class TimelineAggregator {
  static List<TimelineEntry> buildEntries({
    required List<HourlyStepPoint> hourly,
    required UserEntity user,
    required int stepGoal,
  }) {
    final map = {for (final h in hourly) h.hour: h.steps};
    return List.generate(24, (hour) {
      final steps = map[hour] ?? 0;
      return TimelineEntry(
        hour: hour,
        steps: steps,
        distanceKm: ActivityMetricsCalculator.distanceKm(steps: steps, user: user),
        calories: ActivityMetricsCalculator.calories(steps),
        walkingTime: ActivityMetricsCalculator.walkingTime(steps: steps, user: user),
        goalReached: steps > 0 && steps >= (stepGoal / 24).ceil(),
      );
    }).where((e) => e.steps > 0).toList();
  }

  static List<TimelineEntry> mergeHourlyAcrossDays({
    required List<List<HourlyStepPoint>> dailyHourly,
    required UserEntity user,
    required int stepGoal,
  }) {
    final hourlyTotals = List.filled(24, 0);
    for (final day in dailyHourly) {
      for (final point in day) {
        hourlyTotals[point.hour] += point.steps;
      }
    }

    return List.generate(24, (hour) {
      final steps = hourlyTotals[hour];
      return TimelineEntry(
        hour: hour,
        steps: steps,
        distanceKm: ActivityMetricsCalculator.distanceKm(steps: steps, user: user),
        calories: ActivityMetricsCalculator.calories(steps),
        walkingTime: ActivityMetricsCalculator.walkingTime(steps: steps, user: user),
        goalReached: steps > 0 && steps >= (stepGoal / 24).ceil(),
      );
    }).where((e) => e.steps > 0).toList();
  }

  static TimelineSummary summarize(List<TimelineEntry> entries) {
    if (entries.isEmpty) {
      return const TimelineSummary(
        entries: [],
        peakHour: 0,
        leastActiveHour: 0,
        totalSteps: 0,
        averageIntensity: 0,
      );
    }

    final total = entries.fold<int>(0, (sum, e) => sum + e.steps);
    TimelineEntry peak = entries.first;
    TimelineEntry least = entries.first;
    for (final entry in entries) {
      if (entry.steps > peak.steps) peak = entry;
      if (entry.steps < least.steps) least = entry;
    }

    return TimelineSummary(
      entries: entries,
      peakHour: peak.hour,
      leastActiveHour: least.hour,
      totalSteps: total,
      averageIntensity: total / entries.length,
    );
  }
}

abstract final class InsightGenerator {
  static List<ActivityInsight> generate({
    required TimelineSummary summary,
    required int currentStreak,
    required int averageDailySteps,
    required double weeklyConsistency,
    required int stepGoal,
    required int todaySteps,
  }) {
    final insights = <ActivityInsight>[];

    if (summary.entries.isNotEmpty) {
      insights.add(
        ActivityInsight(
          title: 'Most Active Hour',
          description: '${_formatHour(summary.peakHour)} with ${summary.entries.firstWhere((e) => e.hour == summary.peakHour, orElse: () => summary.entries.first).steps} steps',
          iconName: 'schedule',
        ),
      );
    }

    insights.add(
      ActivityInsight(
        title: 'Current Streak',
        description: '$currentStreak day${currentStreak == 1 ? '' : 's'} hitting your goal',
        iconName: 'local_fire_department',
      ),
    );

    insights.add(
      ActivityInsight(
        title: 'Average Daily Steps',
        description: '$averageDailySteps steps per day',
        iconName: 'directions_walk',
      ),
    );

    insights.add(
      ActivityInsight(
        title: 'Weekly Consistency',
        description: '${(weeklyConsistency * 100).round()}% of days on track',
        iconName: 'trending_up',
      ),
    );

    final completion = ActivityMetricsCalculator.completionPercentage(
      current: todaySteps,
      goal: stepGoal,
    );
    insights.add(
      ActivityInsight(
        title: 'Goal Completion Rate',
        description: '${(completion * 100).round()}% of today\'s step goal',
        iconName: 'flag',
      ),
    );

    return insights;
  }

  static String _formatHour(int hour) {
    final period = hour >= 12 ? 'PM' : 'AM';
    final display = hour % 12 == 0 ? 12 : hour % 12;
    return '$display:00 $period';
  }

  static double weeklyConsistency({
    required List<StepPeriodSummary> weekly,
    required int goal,
  }) {
    if (weekly.isEmpty) return 0;
    final met = weekly.where((d) => d.steps >= goal).length;
    return met / weekly.length;
  }

  static int averageDailySteps(List<StepPeriodSummary> records) {
    if (records.isEmpty) return 0;
    final total = records.fold<int>(0, (sum, r) => sum + r.steps);
    return (total / records.length).round();
  }
}
