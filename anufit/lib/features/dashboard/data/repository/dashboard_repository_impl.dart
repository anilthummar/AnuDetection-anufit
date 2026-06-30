import 'package:injectable/injectable.dart';

import 'package:anufit/core/enums/gender.dart';
import 'package:anufit/core/enums/unit_system.dart';
import 'package:anufit/features/dashboard/domain/entities/dashboard_summary.dart';
import 'package:anufit/features/dashboard/domain/repository/dashboard_repository.dart';
import 'package:anufit/features/dashboard/domain/services/dashboard_calculators.dart';
import 'package:anufit/features/onboarding/domain/entities/user_entity.dart';
import 'package:anufit/features/onboarding/domain/repository/onboarding_repository.dart';
import 'package:anufit/features/step_counter/domain/entities/hourly_step_point.dart';
import 'package:anufit/features/step_counter/domain/entities/step_data.dart';
import 'package:anufit/features/step_counter/domain/repository/step_repository.dart';

@LazySingleton(as: DashboardRepository)
class DashboardRepositoryImpl implements DashboardRepository {
  DashboardRepositoryImpl(
    this._stepRepository,
    this._onboardingRepository,
  );

  final StepRepository _stepRepository;
  final OnboardingRepository _onboardingRepository;

  UserEntity? _cachedUser;

  @override
  Stream<StepData> watchLiveSteps() => _stepRepository.watchLiveSteps();

  @override
  Future<DashboardSummary> getTodaySummary() async {
    final user = await _loadUser();
    final now = DateTime.now();
    final steps = await _stepRepository.getTodaySteps();
    final hourly = await _stepRepository.getTodayHourlySteps();
    final streak = await getCurrentStreak();
    final achievements = await getAchievementsPreview(todaySteps: steps);
    final liveData = await _stepRepository.watchLiveSteps().first;

    return _buildSummary(
      user: user,
      steps: steps,
      hourly: hourly,
      streak: streak,
      achievements: achievements,
      trackingStatus: liveData.status,
      now: now,
    );
  }

  @override
  Future<GoalProgress> getGoalProgress({int? todaySteps}) async {
    final user = await _loadUser();
    final steps = todaySteps ?? await _stepRepository.getTodaySteps();
    final now = DateTime.now();
    return GoalProgress(
      goal: user.dailyGoal,
      todaySteps: steps,
      remainingSteps: (user.dailyGoal - steps).clamp(0, user.dailyGoal),
      completionPercentage: ActivityMetricsCalculator.completionPercentage(
        current: steps,
        goal: user.dailyGoal,
      ),
      estimatedCompletion: ActivityMetricsCalculator.estimatedCompletion(
        todaySteps: steps,
        goal: user.dailyGoal,
        now: now,
      ),
    );
  }

  @override
  Future<double> getCalories({int? steps}) async {
    final stepCount = steps ?? await _stepRepository.getTodaySteps();
    return ActivityMetricsCalculator.calories(stepCount);
  }

  @override
  Future<double> getDistance({int? steps}) async {
    final user = await _loadUser();
    final stepCount = steps ?? await _stepRepository.getTodaySteps();
    return ActivityMetricsCalculator.distanceKm(steps: stepCount, user: user);
  }

  @override
  Future<Duration> getWalkingTime({int? steps}) async {
    final user = await _loadUser();
    final stepCount = steps ?? await _stepRepository.getTodaySteps();
    return ActivityMetricsCalculator.walkingTime(steps: stepCount, user: user);
  }

  @override
  Future<StreakInfo> getCurrentStreak() async {
    final user = await _loadUser();
    final monthly = await _stepRepository.getMonthlySteps();
    final records = monthly
        .map((r) => (date: r.periodStart, steps: r.steps))
        .toList();
    return StreakCalculator.calculate(
      dailyRecords: records,
      goal: user.dailyGoal,
      today: DateTime.now(),
    );
  }

  @override
  Future<List<Achievement>> getAchievementsPreview({int? todaySteps}) async {
    final steps = todaySteps ?? await _stepRepository.getTodaySteps();
    final monthly = await _stepRepository.getMonthlySteps();
    return AchievementCalculator.preview(
      todaySteps: steps,
      historicalDailySteps: monthly.map((r) => r.steps).toList(),
    );
  }

  @override
  Future<List<HourlyStepPoint>> getHourlySteps() {
    return _stepRepository.getTodayHourlySteps();
  }

  @override
  Future<void> startTracking() => _stepRepository.startTracking();

  @override
  Future<void> pauseTracking() => _stepRepository.pauseTracking();

  @override
  Future<void> resumeTracking() => _stepRepository.resumeTracking();

  Future<UserEntity> _loadUser() async {
    _cachedUser ??= await _onboardingRepository.getUser();
    return _cachedUser ?? _defaultUser();
  }

  UserEntity _defaultUser() {
    return UserEntity(
      id: 0,
      name: 'Walker',
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

  DashboardSummary _buildSummary({
    required UserEntity user,
    required int steps,
    required List<HourlyStepPoint> hourly,
    required StreakInfo streak,
    required List<Achievement> achievements,
    required TrackingStatus trackingStatus,
    required DateTime now,
  }) {
    final completion = ActivityMetricsCalculator.completionPercentage(
      current: steps,
      goal: user.dailyGoal,
    );
    return DashboardSummary(
      userName: user.name?.trim().isNotEmpty == true ? user.name! : 'Walker',
      todaySteps: steps,
      goal: user.dailyGoal,
      calories: ActivityMetricsCalculator.calories(steps),
      distanceKm: ActivityMetricsCalculator.distanceKm(steps: steps, user: user),
      walkingTime: ActivityMetricsCalculator.walkingTime(steps: steps, user: user),
      completionPercentage: completion,
      streak: streak,
      achievements: achievements,
      hourlySteps: hourly,
      trackingStatus: trackingStatus,
      lastUpdated: now,
      unit: user.unit,
      estimatedCompletion: ActivityMetricsCalculator.estimatedCompletion(
        todaySteps: steps,
        goal: user.dailyGoal,
        now: now,
      ),
    );
  }
}
