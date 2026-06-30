import 'package:anufit/core/enums/gender.dart';
import 'package:anufit/core/services/health_metrics_engine.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HealthMetricsEngine', () {
    test('calculates BMI correctly', () {
      final bmi = HealthMetricsEngine.bmi(weightKg: 72.5, heightCm: 175);
      expect(bmi, closeTo(23.67, 0.01));
    });

    test('categorizes BMI', () {
      expect(HealthMetricsEngine.bmiCategory(22), BmiCategory.healthy);
      expect(HealthMetricsEngine.bmiCategory(27), BmiCategory.overweight);
      expect(HealthMetricsEngine.bmiCategory(31), BmiCategory.obese);
      expect(HealthMetricsEngine.bmiCategory(17), BmiCategory.underweight);
    });

    test('healthy weight range from height', () {
      final range = HealthMetricsEngine.healthyWeightRangeKg(175);
      expect(range.minKg, greaterThan(50));
      expect(range.maxKg, lessThan(90));
      expect(range.minKg, lessThan(range.maxKg));
    });

    test('recommended water scales with weight', () {
      final light = HealthMetricsEngine.recommendedWaterLiters(weightKg: 55);
      final heavy = HealthMetricsEngine.recommendedWaterLiters(weightKg: 90);
      expect(heavy, greaterThan(light));
    });

    test('stride length uses gender factor when auto', () {
      final male = HealthMetricsEngine.strideMeters(
        heightCm: 180,
        gender: Gender.male,
        autoStride: true,
        manualStride: null,
      );
      final female = HealthMetricsEngine.strideMeters(
        heightCm: 180,
        gender: Gender.female,
        autoStride: true,
        manualStride: null,
      );
      expect(male, closeTo(0.747, 0.01));
      expect(female, closeTo(0.743, 0.01));
    });

    test('walking calories increase with steps', () {
      final low = HealthMetricsEngine.walkingCalories(
        steps: 1000,
        weightKg: 70,
        strideMeters: 0.75,
      );
      final high = HealthMetricsEngine.walkingCalories(
        steps: 5000,
        weightKg: 70,
        strideMeters: 0.75,
      );
      expect(high, greaterThan(low));
    });
  });
}
