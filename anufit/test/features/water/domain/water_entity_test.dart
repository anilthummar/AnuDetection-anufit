import 'package:anufit/features/water/domain/entities/water_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('WaterDashboardEntity', () {
    test('computes progress and remaining', () {
      const dashboard = WaterDashboardEntity(
        todayMl: 1750,
        goalLiters: 2.5,
        history: [],
      );
      expect(dashboard.todayLiters, 1.75);
      expect(dashboard.progress, closeTo(0.7, 0.01));
      expect(dashboard.remainingMl, 750);
    });

    test('clamps progress at 100%', () {
      const dashboard = WaterDashboardEntity(
        todayMl: 3000,
        goalLiters: 2.0,
        history: [],
      );
      expect(dashboard.progress, 1.0);
      expect(dashboard.remainingMl, 0);
    });
  });
}
