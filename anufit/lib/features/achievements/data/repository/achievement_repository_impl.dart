import 'package:injectable/injectable.dart';

import 'package:anufit/core/enums/gender.dart';
import 'package:anufit/core/enums/unit_system.dart';
import 'package:anufit/core/services/activity_metrics_calculator.dart';
import 'package:anufit/core/services/streak_calculator.dart';
import 'package:anufit/features/achievements/data/datasource/achievement_local_datasource.dart';
import 'package:anufit/features/achievements/domain/entities/achievement_entity.dart';
import 'package:anufit/features/achievements/domain/repository/achievement_repository.dart';
import 'package:anufit/features/achievements/domain/services/achievement_engine.dart';
import 'package:anufit/features/activity/domain/services/timeline_aggregator.dart';
import 'package:anufit/features/goals/domain/repository/goal_repository.dart';
import 'package:anufit/features/onboarding/domain/entities/user_entity.dart';
import 'package:anufit/features/onboarding/domain/repository/onboarding_repository.dart';
import 'package:anufit/features/step_counter/domain/repository/step_repository.dart';

@LazySingleton(as: AchievementRepository)
class AchievementRepositoryImpl implements AchievementRepository {
  AchievementRepositoryImpl(
    this._local,
    this._stepRepository,
    this._goalRepository,
    this._onboardingRepository,
  );

  final AchievementLocalDatasource _local;
  final StepRepository _stepRepository;
  final GoalRepository _goalRepository;
  final OnboardingRepository _onboardingRepository;

  List<AchievementEntity>? _cache;

  @override
  Future<List<AchievementEntity>> getAchievements() async {
    _cache ??= await _local.getAll();
    if (_cache!.isNotEmpty) return _cache!;
    return evaluateAndSync();
  }

  @override
  Future<List<AchievementEntity>> evaluateAndSync() async {
    final stats = await buildUserStats();
    final stored = {for (final a in await _local.getAll()) a.ruleId: a};
    final evaluations = AchievementEngine.evaluate(stats: stats, stored: stored);
    final entities = evaluations.map((e) => e.entity).toList();
    await _local.saveAll(entities);
    _cache = entities;
    return entities;
  }

  @override
  Future<List<AchievementEntity>> getRecentlyUnlocked() async {
    final all = await getAchievements();
    final cutoff = DateTime.now().subtract(const Duration(days: 7));
    return all
        .where((a) => a.completed && a.completedAt != null && a.completedAt!.isAfter(cutoff))
        .toList();
  }

  @override
  Future<int> getTotalXp() async {
    final all = await getAchievements();
    return AchievementEngine.totalXp(all);
  }

  @override
  Future<UserStats> buildUserStats() async {
    final user = await _loadUser();
    final todaySteps = await _stepRepository.getTodaySteps();
    final lifetimeSteps = await _stepRepository.getLifetimeSteps();
    final goal = await _goalRepository.getGoal();
    final monthly = await _stepRepository.getMonthlySteps();
    final streak = StreakCalculator.calculate(
      dailyRecords: monthly.map((r) => (date: r.periodStart, steps: r.steps)).toList(),
      goal: goal.stepGoal,
      today: DateTime.now(),
    );
    final todayDistance = ActivityMetricsCalculator.distanceKm(steps: todaySteps, user: user);
    final lifetimeDistance = ActivityMetricsCalculator.distanceKm(steps: lifetimeSteps, user: user);
    final todayCalories = ActivityMetricsCalculator.calories(todaySteps);
    final lifetimeCalories = ActivityMetricsCalculator.calories(lifetimeSteps);
    final todayWalking = ActivityMetricsCalculator.walkingTime(steps: todaySteps, user: user);
    final lifetimeWalking = ActivityMetricsCalculator.walkingTime(steps: lifetimeSteps, user: user);
    final average = InsightGenerator.averageDailySteps(monthly);
    final completion = ActivityMetricsCalculator.completionPercentage(
      current: todaySteps,
      goal: goal.stepGoal,
    );

    return UserStats(
      todaySteps: todaySteps,
      lifetimeSteps: lifetimeSteps,
      currentStreak: streak.currentStreak,
      longestStreak: streak.longestStreak,
      todayDistanceKm: todayDistance,
      lifetimeDistanceKm: lifetimeDistance,
      todayCalories: todayCalories,
      lifetimeCalories: lifetimeCalories,
      todayWalkingTime: todayWalking,
      lifetimeWalkingTime: lifetimeWalking,
      averageDailySteps: average,
      goalCompletionRate: completion,
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
}
