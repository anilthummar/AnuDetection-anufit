import 'package:anufit/features/water/domain/entities/water_entity.dart';

abstract class WaterRepository {
  Future<WaterDashboardEntity> getDashboard();
  Future<void> addWater({required int amountMl, String? source, String? note});
  Future<void> setDailyGoalLiters(double liters);
}
