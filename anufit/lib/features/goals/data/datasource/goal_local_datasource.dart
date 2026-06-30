import 'package:injectable/injectable.dart';

import 'package:anufit/core/database/isar_service.dart';
import 'package:anufit/features/goals/data/models/goal_model.dart';
import 'package:anufit/features/onboarding/domain/repository/onboarding_repository.dart';

@lazySingleton
class GoalLocalDatasource {
  GoalLocalDatasource(this._isarService, this._onboardingRepository);

  final IsarService _isarService;
  final OnboardingRepository _onboardingRepository;

  Future<GoalModel> getOrCreateGoal() async {
    final existing = await _isarService.db.goalModels.get(1);
    if (existing != null) return existing;

    final user = await _onboardingRepository.getUser();
    final initial = GoalModel()
      ..goalId = 1
      ..stepGoal = user?.dailyGoal ?? 10000
      ..updatedAt = DateTime.now();

    await _isarService.db.writeTxn(() async {
      await _isarService.db.goalModels.put(initial);
    });
    return initial;
  }

  Future<void> saveGoal(GoalModel goal) async {
    await _isarService.db.writeTxn(() async {
      await _isarService.db.goalModels.put(goal);
    });
  }
}
