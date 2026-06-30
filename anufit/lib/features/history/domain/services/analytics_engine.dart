import 'package:injectable/injectable.dart';

import 'package:anufit/core/enums/gender.dart';
import 'package:anufit/core/enums/unit_system.dart';
import 'package:anufit/core/services/activity_metrics_calculator.dart';
import 'package:anufit/features/goals/data/datasource/goal_local_datasource.dart';
import 'package:anufit/features/history/data/datasource/history_local_datasource.dart';
import 'package:anufit/features/history/data/models/daily_summary_model.dart';
import 'package:anufit/features/history/data/models/monthly_summary_model.dart';
import 'package:anufit/features/history/data/models/weekly_summary_model.dart';
import 'package:anufit/features/history/domain/entities/history_entity.dart';
import 'package:anufit/features/onboarding/domain/entities/user_entity.dart';
import 'package:anufit/features/onboarding/domain/repository/onboarding_repository.dart';
import 'package:anufit/features/step_counter/data/datasource/step_local_datasource.dart';
import 'package:anufit/features/step_counter/domain/services/step_baseline_calculator.dart';

/// Precomputes and caches daily, weekly, monthly, and lifetime summaries.
@lazySingleton
class AnalyticsEngine {
  AnalyticsEngine(
    this._stepLocal,
    this._historyLocal,
    this._goalLocal,
    this._onboardingRepository,
  );

  final StepLocalDatasource _stepLocal;
  final HistoryLocalDatasource _historyLocal;
  final GoalLocalDatasource _goalLocal;
  final OnboardingRepository _onboardingRepository;

  Future<void> syncForDate(DateTime date) async {
    final day = StepBaselineCalculator.localDate(date);
    final records = await _stepLocal.getDailySummaries(start: day, end: day);
    final stepCount = records.firstOrNull?.steps ?? 0;

    final user = await _loadUser();
    final goal = await _goalLocal.getOrCreateGoal();

    final walkingTime = ActivityMetricsCalculator.walkingTime(steps: stepCount, user: user);

    await _historyLocal.upsertDaily(
      DailySummaryModel()
        ..date = day
        ..steps = stepCount
        ..distanceKm = ActivityMetricsCalculator.distanceKm(steps: stepCount, user: user)
        ..calories = ActivityMetricsCalculator.calories(stepCount)
        ..walkingTimeMinutes = walkingTime.inMinutes
        ..goalCompleted = stepCount >= goal.stepGoal,
    );

    await _syncWeeklyForDate(day, user);
    await _syncMonthlyForDate(day, user);
  }

  Future<void> syncRecent({int days = 90}) async {
    final end = DateTime.now();
    final start = end.subtract(Duration(days: days));
    final records = await _stepLocal.getDailySummaries(start: start, end: end);
    for (final record in records) {
      await syncForDate(record.periodStart);
    }
  }

  Future<LifetimeSummaryEntity> getLifetimeSummary() async {
    final all = await _historyLocal.getAllDaily();
    if (all.isEmpty) {
      return const LifetimeSummaryEntity(
        totalSteps: 0,
        totalDistanceKm: 0,
        totalCalories: 0,
        totalWalkingTime: Duration.zero,
        activeDays: 0,
      );
    }

    var steps = 0;
    var distance = 0.0;
    var calories = 0.0;
    var walkingMinutes = 0;
    for (final day in all) {
      steps += day.steps;
      distance += day.distanceKm;
      calories += day.calories;
      walkingMinutes += day.walkingTimeMinutes;
    }

    return LifetimeSummaryEntity(
      totalSteps: steps,
      totalDistanceKm: distance,
      totalCalories: calories,
      totalWalkingTime: Duration(minutes: walkingMinutes),
      activeDays: all.where((d) => d.steps > 0).length,
    );
  }

  Future<void> _syncWeeklyForDate(DateTime day, UserEntity user) async {
    final week = isoWeek(day);
    final year = day.year;
    final weekStart = _weekStart(day);
    final weekEnd = weekStart.add(const Duration(days: 6));
    final dailies = await _historyLocal.getDailyRange(
      start: weekStart,
      end: weekEnd,
      limit: 7,
    );

    var steps = 0;
    var distance = 0.0;
    var calories = 0.0;
    var walkingMinutes = 0;
    for (final d in dailies) {
      steps += d.steps;
      distance += d.distanceKm;
      calories += d.calories;
      walkingMinutes += d.walkingTimeMinutes;
    }

    await _historyLocal.upsertWeekly(
      WeeklySummaryModel()
        ..week = week
        ..year = year
        ..steps = steps
        ..distanceKm = distance
        ..calories = calories
        ..walkingTimeMinutes = walkingMinutes,
    );
  }

  Future<void> _syncMonthlyForDate(DateTime day, UserEntity user) async {
    final month = day.month;
    final year = day.year;
    final monthStart = DateTime(year, month, 1);
    final monthEnd = DateTime(year, month + 1, 0);
    final dailies = await _historyLocal.getDailyRange(
      start: monthStart,
      end: monthEnd,
      limit: 31,
    );

    var steps = 0;
    var distance = 0.0;
    var calories = 0.0;
    var walkingMinutes = 0;
    var activeDays = 0;
    for (final d in dailies) {
      steps += d.steps;
      distance += d.distanceKm;
      calories += d.calories;
      walkingMinutes += d.walkingTimeMinutes;
      if (d.steps > 0) activeDays++;
    }

    await _historyLocal.upsertMonthly(
      MonthlySummaryModel()
        ..month = month
        ..year = year
        ..steps = steps
        ..distanceKm = distance
        ..calories = calories
        ..walkingTimeMinutes = walkingMinutes
        ..activeDays = activeDays,
    );
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

  static int isoWeek(DateTime date) {
    final thursday = date.add(Duration(days: 3 - (date.weekday + 6) % 7));
    final firstThursday = DateTime(thursday.year, 1, 4);
    return 1 + (thursday.difference(firstThursday).inDays / 7).floor();
  }

  static DateTime _weekStart(DateTime date) {
    return StepBaselineCalculator.localDate(
      date.subtract(Duration(days: date.weekday - 1)),
    );
  }
}

extension _FirstOrNull<E> on List<E> {
  E? get firstOrNull => isEmpty ? null : first;
}
