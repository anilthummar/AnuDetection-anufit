import 'package:injectable/injectable.dart';
import 'package:isar_community/isar.dart';

import 'package:anufit/core/database/isar_service.dart';
import 'package:anufit/core/services/health_metrics_engine.dart';
import 'package:anufit/features/onboarding/domain/entities/user_entity.dart';
import 'package:anufit/features/onboarding/domain/repository/onboarding_repository.dart';
import 'package:anufit/features/weight/data/models/weight_entry_model.dart';
import 'package:anufit/features/weight/data/models/weight_goal_model.dart';

@lazySingleton
class WeightLocalDatasource {
  WeightLocalDatasource(this._isar, this._onboarding);

  final IsarService _isar;
  final OnboardingRepository _onboarding;

  Future<void> addEntry({
    required DateTime date,
    required double weightKg,
    String? note,
  }) async {
    final user = await _onboarding.getUser();
    final heightCm = user?.height ?? 170;
    final bmi = HealthMetricsEngine.bmi(weightKg: weightKg, heightCm: heightCm);

    await _isar.db.writeTxn(() async {
      await _isar.db.weightEntryModels.put(
        WeightEntryModel()
          ..date = DateTime(date.year, date.month, date.day)
          ..weightKg = weightKg
          ..bmi = bmi
          ..note = note,
      );
    });

    if (user != null) {
      await _onboarding.saveUser(_userWithWeight(user, weightKg));
    }
  }

  Future<List<WeightEntryModel>> getEntries({DateTime? start, DateTime? end}) async {
    if (start != null && end != null) {
      return _isar.db.weightEntryModels
          .filter()
          .dateBetween(start, end)
          .sortByDateDesc()
          .findAll();
    }
    return _isar.db.weightEntryModels.where().sortByDateDesc().findAll();
  }

  Future<WeightGoalModel> getGoal() async {
    final existing = await _isar.db.weightGoalModels.get(1);
    if (existing != null) return existing;
    final goal = WeightGoalModel()..updatedAt = DateTime.now();
    await _isar.db.writeTxn(() async {
      await _isar.db.weightGoalModels.put(goal);
    });
    return goal;
  }

  Future<void> setGoal(double goalWeightKg) async {
    await _isar.db.writeTxn(() async {
      final goal = await getGoal();
      goal
        ..goalWeightKg = goalWeightKg
        ..updatedAt = DateTime.now();
      await _isar.db.weightGoalModels.put(goal);
    });
  }

  UserEntity _userWithWeight(UserEntity user, double weightKg) {
    return UserEntity(
      id: user.id,
      name: user.name,
      age: user.age,
      gender: user.gender,
      height: user.height,
      weight: weightKg,
      dailyGoal: user.dailyGoal,
      strideLength: user.strideLength,
      unit: user.unit,
      autoStride: user.autoStride,
      walkingSpeed: user.walkingSpeed,
      createdAt: user.createdAt,
    );
  }
}
