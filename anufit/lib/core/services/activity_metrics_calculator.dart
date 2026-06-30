import 'package:anufit/core/enums/gender.dart';
import 'package:anufit/core/enums/unit_system.dart';
import 'package:anufit/core/services/health_metrics_engine.dart';
import 'package:anufit/features/onboarding/domain/entities/user_entity.dart';

/// Pure activity metric calculations derived from steps and user profile.
abstract final class ActivityMetricsCalculator {
  static const double caloriesPerStep = 0.04;
  static const double defaultStrideMeters = 0.78;
  static const double defaultWalkingSpeedKmh = 4.8;

  static double calories(int steps) => steps * caloriesPerStep;

  static double distanceKm({
    required int steps,
    required UserEntity user,
  }) {
    final strideMeters = _strideMeters(user);
    return (steps * strideMeters) / 1000;
  }

  static Duration walkingTime({
    required int steps,
    required UserEntity user,
  }) {
    if (steps <= 0) return Duration.zero;

    final km = distanceKm(steps: steps, user: user);
    final speedKmh = (user.walkingSpeed != null && user.walkingSpeed! > 0)
        ? user.walkingSpeed!
        : defaultWalkingSpeedKmh;
    final totalMinutes = (km / speedKmh) * 60;
    final minutes = totalMinutes.round();
    if (minutes <= 0) {
      return Duration(seconds: (totalMinutes * 60).round().clamp(1, 59));
    }
    return Duration(minutes: minutes);
  }

  static double completionPercentage({
    required num current,
    required num goal,
  }) {
    if (goal <= 0) return 0;
    return (current / goal).clamp(0.0, 1.0);
  }

  static DateTime? estimatedCompletion({
    required int todaySteps,
    required int goal,
    required DateTime now,
  }) {
    if (todaySteps >= goal) return now;
    final hoursElapsed = now.hour + (now.minute / 60);
    if (hoursElapsed <= 0 || todaySteps <= 0) return null;
    final stepsPerHour = todaySteps / hoursElapsed;
    if (stepsPerHour <= 0) return null;
    final remaining = goal - todaySteps;
    final hoursRemaining = remaining / stepsPerHour;
    return now.add(Duration(minutes: (hoursRemaining * 60).round()));
  }

  static double _strideMeters(UserEntity user) {
    return HealthMetricsEngine.strideMeters(
      heightCm: user.height,
      gender: user.gender,
      autoStride: user.autoStride,
      manualStride: user.strideLength,
      unit: user.unit,
    );
  }
}
