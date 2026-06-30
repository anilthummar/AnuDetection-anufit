import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

import 'package:anufit/core/enums/gender.dart';
import 'package:anufit/core/enums/unit_system.dart';
import 'package:anufit/features/goals/domain/repository/goal_repository.dart';
import 'package:anufit/features/history/data/datasource/history_local_datasource.dart';
import 'package:anufit/features/history/domain/entities/history_entity.dart';
import 'package:anufit/features/history/domain/services/analytics_engine.dart';
import 'package:anufit/features/onboarding/domain/entities/user_entity.dart';
import 'package:anufit/features/onboarding/domain/repository/onboarding_repository.dart';
import 'package:anufit/features/statistics/domain/entities/statistics_entity.dart';
import 'package:anufit/features/statistics/domain/repository/statistics_repository.dart';
import 'package:anufit/features/statistics/domain/services/statistics_calculator.dart';
import 'package:anufit/features/step_counter/domain/repository/step_repository.dart';

@LazySingleton(as: StatisticsRepository)
class StatisticsRepositoryImpl implements StatisticsRepository {
  StatisticsRepositoryImpl(
    this._historyLocal,
    this._analytics,
    this._stepRepository,
    this._goalRepository,
    this._onboardingRepository,
  );

  final HistoryLocalDatasource _historyLocal;
  final AnalyticsEngine _analytics;
  final StepRepository _stepRepository;
  final GoalRepository _goalRepository;
  final OnboardingRepository _onboardingRepository;

  StatisticsBundle? _cache;

  @override
  Future<StatisticsBundle> getStatistics({
    StatisticsPeriod period = StatisticsPeriod.weekly,
  }) async {
    await _analytics.syncRecent();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final goal = await _goalRepository.getGoal();
    final user = await _loadUser();

    final rangeStart = switch (period) {
      StatisticsPeriod.daily => today,
      StatisticsPeriod.weekly => today.subtract(const Duration(days: 6)),
      StatisticsPeriod.monthly => DateTime(today.year, today.month, 1),
      StatisticsPeriod.yearly => DateTime(today.year, 1, 1),
      StatisticsPeriod.lifetime => DateTime(2000),
    };

    final models = await _historyLocal.getDailyRange(
      start: rangeStart,
      end: today,
      limit: 400,
    );
    final days = models
        .map(
          (m) => DailySummaryEntity(
            date: m.date,
            steps: m.steps,
            distanceKm: m.distanceKm,
            calories: m.calories,
            walkingTime: Duration(minutes: m.walkingTimeMinutes),
            goalCompleted: m.goalCompleted,
          ),
        )
        .toList();

    final todaySteps = await _stepRepository.getTodaySteps();
    final hourly = await _stepRepository.getTodayHourlySteps();

    final metrics = period == StatisticsPeriod.daily
        ? StatisticsCalculator.daily(
            steps: todaySteps,
            user: user,
            goal: goal.stepGoal,
            hourly: hourly,
          )
        : StatisticsCalculator.fromDailySummaries(days: days, goal: goal.stepGoal);

    final lifetime = await _analytics.getLifetimeSummary();
    final insights = StatisticsCalculator.generateInsights(
      metrics: metrics,
      lifetime: lifetime,
      recentDays: days,
    );

    final heatmapStart = today.subtract(const Duration(days: 364));
    final heatmapModels = await _historyLocal.getDailyRange(
      start: heatmapStart,
      end: today,
      limit: 400,
    );
    final heatmap = heatmapModels
        .map((m) => (date: m.date, steps: m.steps))
        .toList();

    final weeklyBars = await _buildWeeklyBars(today);
    final monthlyLine = await _buildMonthlyLine(today.year);
    final yearlyBars = await _buildYearlyBars(today.year);

    final bundle = StatisticsBundle(
      period: period,
      metrics: metrics,
      insights: insights,
      lifetime: lifetime,
      heatmap: heatmap,
      hourlyPoints: hourly,
      weeklyBars: weeklyBars,
      monthlyLine: monthlyLine,
      yearlyBars: yearlyBars,
      unit: user.unit,
    );
    _cache = bundle;
    return bundle;
  }

  @override
  Future<ChartState> getChartData(ChartType type) async {
    final bundle = _cache ?? await getStatistics();
    final points = switch (type) {
      ChartType.daily => bundle.hourlyPoints
          .map((h) => ChartDataPoint(label: '${h.hour}', value: h.steps.toDouble()))
          .toList(),
      ChartType.weekly => bundle.weeklyBars,
      ChartType.monthly => bundle.monthlyLine,
      ChartType.yearly => bundle.yearlyBars,
    };
    return ChartState(type: type, points: points);
  }

  Future<List<ChartDataPoint>> _buildWeeklyBars(DateTime today) async {
    final start = today.subtract(const Duration(days: 6));
    final models = await _historyLocal.getDailyRange(start: start, end: today, limit: 7);
    return models
        .map((m) => ChartDataPoint(
              label: DateFormat('E').format(m.date),
              value: m.steps.toDouble(),
            ))
        .toList();
  }

  Future<List<ChartDataPoint>> _buildMonthlyLine(int year) async {
    final now = DateTime.now();
    final models = await _historyLocal.getDailyRange(
      start: DateTime(year, now.month, 1),
      end: now,
      limit: 31,
    );
    return models
        .map((m) => ChartDataPoint(label: '${m.date.day}', value: m.steps.toDouble()))
        .toList();
  }

  Future<List<ChartDataPoint>> _buildYearlyBars(int year) async {
    final months = await _historyLocal.getMonthlyForYear(year);
    return months
        .map((m) => ChartDataPoint(
              label: DateFormat('MMM').format(DateTime(year, m.month)),
              value: m.steps.toDouble(),
            ))
        .toList();
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
