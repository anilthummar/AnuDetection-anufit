import 'package:injectable/injectable.dart';

import 'package:anufit/core/services/health_metrics_engine.dart';
import 'package:anufit/features/health/data/datasource/health_platform_datasource.dart';
import 'package:anufit/features/onboarding/domain/repository/onboarding_repository.dart';
import 'package:anufit/features/weight/data/datasource/weight_local_datasource.dart';
import 'package:anufit/features/weight/data/models/weight_entry_model.dart';
import 'package:anufit/features/weight/domain/entities/weight_entity.dart';
import 'package:anufit/features/weight/domain/repository/weight_repository.dart';

@LazySingleton(as: WeightRepository)
class WeightRepositoryImpl implements WeightRepository {
  WeightRepositoryImpl(
    this._local,
    this._onboarding,
    this._health,
  );

  final WeightLocalDatasource _local;
  final OnboardingRepository _onboarding;
  final HealthPlatformDatasource _health;

  @override
  Future<WeightDashboardEntity> getDashboard() async {
    final user = await _onboarding.getUser();
    final entries = await _local.getEntries();
    final goal = await _local.getGoal();
    final current = entries.isNotEmpty
        ? entries.first.weightKg
        : (user?.weight ?? 0);
    final height = user?.height ?? 170;
    final bmi = HealthMetricsEngine.bmi(weightKg: current, heightCm: height);
    final goalKg = goal.goalWeightKg > 0 ? goal.goalWeightKg : current;

    return WeightDashboardEntity(
      currentWeightKg: current,
      goalWeightKg: goalKg,
      bmi: bmi,
      category: HealthMetricsEngine.bmiCategory(bmi),
      remainingKg: current - goalKg,
      history: entries.map(_toEntity).toList(),
    );
  }

  @override
  Future<void> logWeight({required double weightKg, String? note}) async {
    await _local.addEntry(date: DateTime.now(), weightKg: weightKg, note: note);
    await _health.writeWeight(weightKg: weightKg, date: DateTime.now());
  }

  @override
  Future<void> setGoalWeight(double goalKg) => _local.setGoal(goalKg);

  @override
  Future<List<WeightEntryEntity>> getHistory({
    DateTime? start,
    DateTime? end,
  }) async {
    final entries = await _local.getEntries(start: start, end: end);
    return entries.map(_toEntity).toList();
  }

  WeightEntryEntity _toEntity(WeightEntryModel m) => WeightEntryEntity(
        id: m.id,
        date: m.date,
        weightKg: m.weightKg,
        bmi: m.bmi,
        note: m.note,
      );
}
