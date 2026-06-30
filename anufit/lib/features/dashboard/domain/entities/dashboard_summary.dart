import 'package:equatable/equatable.dart';

import 'package:anufit/core/enums/unit_system.dart';
import 'package:anufit/core/entities/streak_info.dart';
import 'package:anufit/features/step_counter/domain/entities/hourly_step_point.dart';
import 'package:anufit/features/step_counter/domain/entities/step_data.dart';

class GoalProgress extends Equatable {
  const GoalProgress({
    required this.goal,
    required this.todaySteps,
    required this.remainingSteps,
    required this.completionPercentage,
    this.estimatedCompletion,
  });

  final int goal;
  final int todaySteps;
  final int remainingSteps;
  final double completionPercentage;
  final DateTime? estimatedCompletion;

  @override
  List<Object?> get props => [
        goal,
        todaySteps,
        remainingSteps,
        completionPercentage,
        estimatedCompletion,
      ];
}

class Achievement extends Equatable {
  const Achievement({
    required this.id,
    required this.title,
    required this.threshold,
    required this.isUnlocked,
    this.iconName,
  });

  final String id;
  final String title;
  final int threshold;
  final bool isUnlocked;
  final String? iconName;

  @override
  List<Object?> get props => [id, title, threshold, isUnlocked, iconName];
}

class DashboardSummary extends Equatable {
  const DashboardSummary({
    required this.userName,
    required this.todaySteps,
    required this.goal,
    required this.calories,
    required this.distanceKm,
    required this.walkingTime,
    required this.completionPercentage,
    required this.streak,
    required this.achievements,
    required this.hourlySteps,
    required this.trackingStatus,
    required this.lastUpdated,
    required this.unit,
    this.estimatedCompletion,
  });

  final String userName;
  final int todaySteps;
  final int goal;
  final double calories;
  final double distanceKm;
  final Duration walkingTime;
  final double completionPercentage;
  final StreakInfo streak;
  final List<Achievement> achievements;
  final List<HourlyStepPoint> hourlySteps;
  final TrackingStatus trackingStatus;
  final DateTime lastUpdated;
  final UnitSystem unit;
  final DateTime? estimatedCompletion;

  GoalProgress get goalProgress => GoalProgress(
        goal: goal,
        todaySteps: todaySteps,
        remainingSteps: (goal - todaySteps).clamp(0, goal),
        completionPercentage: completionPercentage,
        estimatedCompletion: estimatedCompletion,
      );

  DashboardSummary copyWith({
    String? userName,
    int? todaySteps,
    int? goal,
    double? calories,
    double? distanceKm,
    Duration? walkingTime,
    double? completionPercentage,
    StreakInfo? streak,
    List<Achievement>? achievements,
    List<HourlyStepPoint>? hourlySteps,
    TrackingStatus? trackingStatus,
    DateTime? lastUpdated,
    UnitSystem? unit,
    DateTime? estimatedCompletion,
  }) {
    return DashboardSummary(
      userName: userName ?? this.userName,
      todaySteps: todaySteps ?? this.todaySteps,
      goal: goal ?? this.goal,
      calories: calories ?? this.calories,
      distanceKm: distanceKm ?? this.distanceKm,
      walkingTime: walkingTime ?? this.walkingTime,
      completionPercentage: completionPercentage ?? this.completionPercentage,
      streak: streak ?? this.streak,
      achievements: achievements ?? this.achievements,
      hourlySteps: hourlySteps ?? this.hourlySteps,
      trackingStatus: trackingStatus ?? this.trackingStatus,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      unit: unit ?? this.unit,
      estimatedCompletion: estimatedCompletion ?? this.estimatedCompletion,
    );
  }

  @override
  List<Object?> get props => [
        userName,
        todaySteps,
        goal,
        calories,
        distanceKm,
        walkingTime,
        completionPercentage,
        streak,
        achievements,
        hourlySteps,
        trackingStatus,
        lastUpdated,
        unit,
        estimatedCompletion,
      ];
}
