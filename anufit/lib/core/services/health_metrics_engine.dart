import 'package:anufit/core/enums/gender.dart';
import 'package:anufit/core/enums/unit_system.dart';

enum BmiCategory { underweight, healthy, overweight, obese }

abstract final class HealthMetricsEngine {
  static double bmi({required double weightKg, required double heightCm}) {
    if (heightCm <= 0) return 0;
    final heightM = heightCm / 100;
    return weightKg / (heightM * heightM);
  }

  static BmiCategory bmiCategory(double bmi) {
    if (bmi < 18.5) return BmiCategory.underweight;
    if (bmi < 25) return BmiCategory.healthy;
    if (bmi < 30) return BmiCategory.overweight;
    return BmiCategory.obese;
  }

  static String bmiCategoryLabel(BmiCategory category) => switch (category) {
        BmiCategory.underweight => 'Underweight',
        BmiCategory.healthy => 'Healthy',
        BmiCategory.overweight => 'Overweight',
        BmiCategory.obese => 'Obese',
      };

  static ({double minKg, double maxKg}) healthyWeightRangeKg(double heightCm) {
    final heightM = heightCm / 100;
    return (minKg: 18.5 * heightM * heightM, maxKg: 24.9 * heightM * heightM);
  }

  static double recommendedWaterLiters({
    required double weightKg,
    int activityMinutes = 30,
  }) {
    final base = weightKg * 0.033;
    final activityBonus = activityMinutes > 60 ? 0.5 : 0.0;
    return (base + activityBonus).clamp(1.5, 4.0);
  }

  static double strideMeters({
    required double heightCm,
    required Gender gender,
    required bool autoStride,
    double? manualStride,
    UnitSystem unit = UnitSystem.metric,
  }) {
    if (!autoStride && manualStride != null && manualStride > 0) {
      // strideLength is persisted in meters for all unit systems.
      return manualStride;
    }
    final heightM = heightCm / 100;
    final factor = gender == Gender.female ? 0.413 : 0.415;
    return heightM * factor;
  }

  static int suggestedDailySteps({required int age, required Gender gender}) {
    if (age < 18) return 10000;
    if (age < 40) return 10000;
    if (age < 60) return 8000;
    return 7000;
  }

  static double walkingCalories({
    required int steps,
    required double weightKg,
    required double strideMeters,
  }) {
    final distanceKm = (steps * strideMeters) / 1000;
    return weightKg * distanceKm * 0.8;
  }
}
