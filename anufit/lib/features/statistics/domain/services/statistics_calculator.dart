import 'package:anufit/core/services/activity_metrics_calculator.dart';
import 'package:anufit/features/history/domain/entities/history_entity.dart';
import 'package:anufit/features/onboarding/domain/entities/user_entity.dart';
import 'package:anufit/features/statistics/domain/entities/statistics_entity.dart';
import 'package:anufit/features/step_counter/domain/entities/hourly_step_point.dart';

abstract final class StatisticsCalculator {
  static PeriodMetrics daily({
    required int steps,
    required UserEntity user,
    required int goal,
    required List<HourlyStepPoint> hourly,
  }) {
    final distance = ActivityMetricsCalculator.distanceKm(steps: steps, user: user);
    final walkingTime = ActivityMetricsCalculator.walkingTime(steps: steps, user: user);
    final activeHours = hourly.where((h) => h.steps > 0).length;
    final speed = walkingTime.inHours > 0
        ? distance / (walkingTime.inMinutes / 60)
        : 0.0;

    return PeriodMetrics(
      steps: steps,
      calories: ActivityMetricsCalculator.calories(steps),
      distanceKm: distance,
      walkingTime: walkingTime,
      goalCompletionRate: ActivityMetricsCalculator.completionPercentage(
        current: steps,
        goal: goal,
      ),
      activeHours: activeHours,
      averageSpeedKmh: speed,
    );
  }

  static PeriodMetrics fromDailySummaries({
    required List<DailySummaryEntity> days,
    required int goal,
  }) {
    if (days.isEmpty) {
      return const PeriodMetrics(
        steps: 0,
        calories: 0,
        distanceKm: 0,
        walkingTime: Duration.zero,
      );
    }

    var steps = 0;
    var calories = 0.0;
    var distance = 0.0;
    var walkingMinutes = 0;
    var goalsMet = 0;
    DailySummaryEntity? highest;
    DailySummaryEntity? lowest;
    DailySummaryEntity? longestWalkDay;

    for (final day in days) {
      steps += day.steps;
      calories += day.calories;
      distance += day.distanceKm;
      walkingMinutes += day.walkingTime.inMinutes;
      if (day.goalCompleted) goalsMet++;
      if (highest == null || day.steps > highest.steps) highest = day;
      if (lowest == null || day.steps < lowest.steps) lowest = day;
      if (longestWalkDay == null ||
          day.walkingTime > longestWalkDay.walkingTime) {
        longestWalkDay = day;
      }
    }

    final avgPace = distance > 0 ? walkingMinutes / distance : 0.0;

    return PeriodMetrics(
      steps: steps,
      calories: calories,
      distanceKm: distance,
      walkingTime: Duration(minutes: walkingMinutes),
      averageDailySteps: (steps / days.length).round(),
      goalCompletionRate: goalsMet / days.length,
      activeDays: days.where((d) => d.steps > 0).length,
      averagePaceMinPerKm: avgPace,
      highestStepDay: highest?.date,
      lowestStepDay: lowest?.date,
      peakDay: highest?.date,
      restDay: lowest?.date,
      longestWalk: longestWalkDay?.walkingTime,
    );
  }

  static List<StatisticsInsight> generateInsights({
    required PeriodMetrics metrics,
    required LifetimeSummaryEntity lifetime,
    required List<DailySummaryEntity> recentDays,
  }) {
    final insights = <StatisticsInsight>[];

    if (metrics.peakDay != null) {
      insights.add(StatisticsInsight(
        title: 'Most Active Day',
        value: _formatDate(metrics.peakDay!),
        iconName: 'trending_up',
      ));
    }

    if (metrics.longestWalk != null) {
      insights.add(StatisticsInsight(
        title: 'Longest Walking Session',
        value: _formatDuration(metrics.longestWalk!),
        iconName: 'directions_walk',
      ));
    }

    if (metrics.goalCompletionRate != null) {
      insights.add(StatisticsInsight(
        title: 'Goal Success Rate',
        value: '${(metrics.goalCompletionRate! * 100).round()}%',
        iconName: 'flag',
      ));
    }

    if (metrics.averageDailySteps != null) {
      insights.add(StatisticsInsight(
        title: 'Average Daily Distance',
        value: '${(metrics.distanceKm / (recentDays.isEmpty ? 1 : recentDays.length)).toStringAsFixed(1)} km',
        iconName: 'straighten',
      ));
    }

    insights.add(StatisticsInsight(
      title: 'Lifetime Steps',
      value: _formatLargeNumber(lifetime.totalSteps),
      iconName: 'emoji_events',
    ));

    if (recentDays.length >= 7) {
      final firstHalf = recentDays.take(recentDays.length ~/ 2).fold<int>(0, (s, d) => s + d.steps);
      final secondHalf = recentDays.skip(recentDays.length ~/ 2).fold<int>(0, (s, d) => s + d.steps);
      final trend = secondHalf > firstHalf ? 'Up' : secondHalf < firstHalf ? 'Down' : 'Stable';
      insights.add(StatisticsInsight(
        title: 'Weekly Trend',
        value: trend,
        iconName: 'show_chart',
      ));
    }

    return insights;
  }

  static String _formatDate(DateTime date) =>
      '${date.day}/${date.month}/${date.year}';

  static String _formatDuration(Duration d) {
    if (d.inHours > 0) return '${d.inHours}h ${d.inMinutes.remainder(60)}m';
    return '${d.inMinutes}m';
  }

  static String _formatLargeNumber(int n) {
    if (n >= 1000000) return '${(n / 1000000).toStringAsFixed(1)}M';
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}K';
    return '$n';
  }
}
