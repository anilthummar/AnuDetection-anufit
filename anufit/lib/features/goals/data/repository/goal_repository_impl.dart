import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import 'package:anufit/core/enums/gender.dart';
import 'package:anufit/core/enums/unit_system.dart';
import 'package:anufit/core/services/activity_metrics_calculator.dart';
import 'package:anufit/features/goals/data/datasource/goal_local_datasource.dart';
import 'package:anufit/features/goals/data/models/goal_model.dart';
import 'package:anufit/features/goals/domain/entities/goal_entity.dart';
import 'package:anufit/features/goals/domain/repository/goal_repository.dart';
import 'package:anufit/features/goals/domain/services/goal_engine.dart';
import 'package:anufit/features/onboarding/domain/entities/user_entity.dart';
import 'package:anufit/features/onboarding/domain/repository/onboarding_repository.dart';
import 'package:anufit/features/step_counter/domain/repository/step_repository.dart';

@LazySingleton(as: GoalRepository)
class GoalRepositoryImpl implements GoalRepository {
  GoalRepositoryImpl(
    this._local,
    this._stepRepository,
    this._onboardingRepository,
  ) {
    _stepSubscription = _stepRepository.watchLiveSteps().listen((_) async {
      final progress = await getGoalProgress();
      _progressSubject.add(progress);
    });
  }

  final GoalLocalDatasource _local;
  final StepRepository _stepRepository;
  final OnboardingRepository _onboardingRepository;

  final _progressSubject = BehaviorSubject<GoalProgressEntity>();
  StreamSubscription<dynamic>? _stepSubscription;

  @override
  Future<GoalEntity> getGoal() async {
    final model = await _local.getOrCreateGoal();
    return _toEntity(model);
  }

  @override
  Future<GoalProgressEntity> getGoalProgress() async {
    final goal = await getGoal();
    final user = await _loadUser();
    final steps = await _stepRepository.getTodaySteps();
    return GoalEngine.buildProgress(
      goal: goal,
      currentSteps: steps,
      user: user,
      now: DateTime.now(),
    );
  }

  @override
  Stream<GoalProgressEntity> watchGoalProgress() async* {
    yield await getGoalProgress();
    yield* _progressSubject.stream;
  }

  @override
  Future<void> updateGoal(GoalEntity goal) async {
    await _local.saveGoal(
      GoalModel()
        ..goalId = 1
        ..stepGoal = goal.stepGoal
        ..distanceGoalKm = goal.distanceGoalKm
        ..calorieGoal = goal.calorieGoal
        ..walkingTimeGoalMinutes = goal.walkingTimeGoalMinutes
        ..updatedAt = DateTime.now(),
    );
    final user = await _onboardingRepository.getUser();
    if (user != null) {
      await _onboardingRepository.saveUser(
        UserEntity(
          id: user.id,
          name: user.name,
          age: user.age,
          gender: user.gender,
          height: user.height,
          weight: user.weight,
          dailyGoal: goal.stepGoal,
          strideLength: user.strideLength,
          unit: user.unit,
          autoStride: user.autoStride,
          walkingSpeed: user.walkingSpeed,
          createdAt: user.createdAt,
        ),
      );
    }
    _progressSubject.add(await getGoalProgress());
  }

  @override
  Future<void> resetGoal() async {
    await updateGoal(
      GoalEntity(
        stepGoal: 10000,
        updatedAt: DateTime.now(),
      ),
    );
  }

  @override
  Future<double> calculateCompletion({int? currentSteps}) async {
    final goal = await getGoal();
    final steps = currentSteps ?? await _stepRepository.getTodaySteps();
    return ActivityMetricsCalculator.completionPercentage(
      current: steps,
      goal: goal.stepGoal,
    );
  }

  @override
  Future<DateTime?> estimateCompletionTime({int? currentSteps}) async {
    final goal = await getGoal();
    final steps = currentSteps ?? await _stepRepository.getTodaySteps();
    return ActivityMetricsCalculator.estimatedCompletion(
      todaySteps: steps,
      goal: goal.stepGoal,
      now: DateTime.now(),
    );
  }

  Future<UserEntity> _loadUser() async {
    final user = await _onboardingRepository.getUser();
    return user ??
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

  GoalEntity _toEntity(GoalModel model) {
    return GoalEntity(
      stepGoal: model.stepGoal,
      distanceGoalKm: model.distanceGoalKm,
      calorieGoal: model.calorieGoal,
      walkingTimeGoalMinutes: model.walkingTimeGoalMinutes,
      updatedAt: model.updatedAt,
    );
  }

  @override
  @disposeMethod
  void dispose() {
    _stepSubscription?.cancel();
    _progressSubject.close();
  }
}
