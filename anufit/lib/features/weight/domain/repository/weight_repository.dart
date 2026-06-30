import 'package:anufit/features/weight/domain/entities/weight_entity.dart';

abstract class WeightRepository {
  Future<WeightDashboardEntity> getDashboard();
  Future<void> logWeight({required double weightKg, String? note});
  Future<void> setGoalWeight(double goalKg);
  Future<List<WeightEntryEntity>> getHistory({DateTime? start, DateTime? end});
}
