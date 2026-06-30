import 'package:injectable/injectable.dart';

import 'package:anufit/core/enums/gender.dart';
import 'package:anufit/core/enums/unit_system.dart';
import 'package:anufit/core/services/streak_calculator.dart';
import 'package:anufit/features/activity/data/datasource/activity_local_datasource.dart';
import 'package:anufit/features/activity/domain/entities/timeline_entity.dart';
import 'package:anufit/features/activity/domain/repository/activity_repository.dart';
import 'package:anufit/features/activity/domain/services/timeline_aggregator.dart';
import 'package:anufit/features/goals/domain/repository/goal_repository.dart';
import 'package:anufit/features/onboarding/domain/entities/user_entity.dart';
import 'package:anufit/features/onboarding/domain/repository/onboarding_repository.dart';
import 'package:anufit/features/step_counter/domain/entities/hourly_step_point.dart';
import 'package:anufit/features/step_counter/domain/entities/step_data.dart';
import 'package:anufit/features/step_counter/domain/repository/step_repository.dart';

@LazySingleton(as: ActivityRepository)
class ActivityRepositoryImpl implements ActivityRepository {
  ActivityRepositoryImpl(
    this._local,
    this._stepRepository,
    this._goalRepository,
    this._onboardingRepository,
  );

  final ActivityLocalDatasource _local;
  final StepRepository _stepRepository;
  final GoalRepository _goalRepository;
  final OnboardingRepository _onboardingRepository;

  final Map<String, TimelineSummary> _cache = {};

  @override
  Future<TimelineSummary> getTimeline(
    TimelineFilter filter, {
    DateTime? customDate,
  }) async {
    final dates = _datesForFilter(filter, customDate);
    if (dates.length == 1) {
      return _getSingleDayTimeline(dates.first);
    }

    final cacheKey = 'range-${filter.name}-${dates.first.toIso8601String()}';
    if (_cache.containsKey(cacheKey)) return _cache[cacheKey]!;

    final user = await _loadUser();
    final goal = await _goalRepository.getGoal();
    final dailyHourly = <List<HourlyStepPoint>>[];
    for (final date in dates) {
      await syncTimelineForDate(date);
      dailyHourly.add(await _stepRepository.getHourlyStepsForDate(date));
    }

    final entries = TimelineAggregator.mergeHourlyAcrossDays(
      dailyHourly: dailyHourly,
      user: user,
      stepGoal: goal.stepGoal,
    );
    final summary = TimelineAggregator.summarize(entries);
    _cache[cacheKey] = summary;
    return summary;
  }

  @override
  Future<List<StepPeriodSummary>> getWeeklySummaries() =>
      _stepRepository.getWeeklySteps();

  @override
  Future<Map<DateTime, List<TimelineEntry>>> getHeatmapData(
    TimelineFilter filter, {
    DateTime? customDate,
  }) async {
    final user = await _loadUser();
    final goal = await _goalRepository.getGoal();
    final dates = _datesForFilter(filter, customDate);
    final result = <DateTime, List<TimelineEntry>>{};

    for (final date in dates) {
      final hourly = await _stepRepository.getHourlyStepsForDate(date);
      result[date] = TimelineAggregator.buildEntries(
        hourly: hourly,
        user: user,
        stepGoal: goal.stepGoal,
      );
    }
    return result;
  }

  @override
  Future<List<ActivityInsight>> getInsights() async {
    final today = await getTimeline(TimelineFilter.today);
    final weekly = await _stepRepository.getWeeklySteps();
    final goal = await _goalRepository.getGoal();
    final monthly = await _stepRepository.getMonthlySteps();
    final streak = StreakCalculator.calculate(
      dailyRecords: monthly.map((r) => (date: r.periodStart, steps: r.steps)).toList(),
      goal: goal.stepGoal,
      today: DateTime.now(),
    );
    final todaySteps = await _stepRepository.getTodaySteps();
    final consistency = InsightGenerator.weeklyConsistency(
      weekly: weekly,
      goal: goal.stepGoal,
    );
    final average = InsightGenerator.averageDailySteps(monthly);

    return InsightGenerator.generate(
      summary: today,
      currentStreak: streak.currentStreak,
      averageDailySteps: average,
      weeklyConsistency: consistency,
      stepGoal: goal.stepGoal,
      todaySteps: todaySteps,
    );
  }

  @override
  Future<void> syncTimelineForDate(DateTime date) async {
    final user = await _loadUser();
    final hourly = await _stepRepository.getHourlyStepsForDate(date);
    await _local.upsertTimeline(
      date: date,
      hourly: hourly,
      user: user,
    );
    _cache.remove('${date.year}-${date.month}-${date.day}');
  }

  Future<TimelineSummary> _getSingleDayTimeline(DateTime date) async {
    final cacheKey = '${date.year}-${date.month}-${date.day}';
    if (_cache.containsKey(cacheKey)) return _cache[cacheKey]!;

    await syncTimelineForDate(date);
    final cached = await _local.getTimelineForDate(date);
    final user = await _loadUser();
    final goal = await _goalRepository.getGoal();
    final entries = cached
        .map(
          (m) => TimelineEntry(
            hour: m.hour,
            steps: m.steps,
            distanceKm: m.distanceKm,
            calories: m.calories,
            walkingTime: Duration(minutes: m.walkingTimeMinutes),
            goalReached: m.steps >= (goal.stepGoal / 24).ceil(),
          ),
        )
        .toList();

    if (entries.isEmpty) {
      final hourly = await _stepRepository.getHourlyStepsForDate(date);
      final built = TimelineAggregator.buildEntries(
        hourly: hourly,
        user: user,
        stepGoal: goal.stepGoal,
      );
      final summary = TimelineAggregator.summarize(built);
      _cache[cacheKey] = summary;
      return summary;
    }

    final summary = TimelineAggregator.summarize(entries);
    _cache[cacheKey] = summary;
    return summary;
  }

  List<DateTime> _datesForFilter(TimelineFilter filter, DateTime? customDate) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    return switch (filter) {
      TimelineFilter.today => [today],
      TimelineFilter.yesterday => [today.subtract(const Duration(days: 1))],
      TimelineFilter.thisWeek => List.generate(
          today.weekday,
          (i) => today.subtract(Duration(days: today.weekday - 1 - i)),
        ),
      TimelineFilter.thisMonth => List.generate(
          today.day,
          (i) => DateTime(today.year, today.month, i + 1),
        ),
      TimelineFilter.custom => [
          if (customDate != null)
            DateTime(customDate.year, customDate.month, customDate.day)
          else
            today,
        ],
    };
  }

  Future<UserEntity> _loadUser() async {
    return await _onboardingRepository.getUser() ??
        UserEntity(
          id: 0,
          age: 30,
          gender: Gender.male,
          height: 170,
          weight: 70,
          dailyGoal: 10000,
          unit: UnitSystem.metric,
          autoStride: true,
          createdAt: DateTime.now(),
        );
  }
}
