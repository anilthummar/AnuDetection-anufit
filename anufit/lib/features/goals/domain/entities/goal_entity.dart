import 'package:equatable/equatable.dart';

enum GoalStatus { notStarted, inProgress, completed, exceeded }

enum GoalType { steps, distance, calories, walkingTime }

class GoalEntity extends Equatable {
  const GoalEntity({
    required this.stepGoal,
    this.distanceGoalKm,
    this.calorieGoal,
    this.walkingTimeGoalMinutes,
    required this.updatedAt,
  });

  static const stepPresets = [3000, 5000, 8000, 10000, 12000, 15000];

  final int stepGoal;
  final double? distanceGoalKm;
  final double? calorieGoal;
  final int? walkingTimeGoalMinutes;
  final DateTime updatedAt;

  @override
  List<Object?> get props => [
        stepGoal,
        distanceGoalKm,
        calorieGoal,
        walkingTimeGoalMinutes,
        updatedAt,
      ];
}

class GoalProgressEntity extends Equatable {
  const GoalProgressEntity({
    required this.goal,
    required this.currentSteps,
    required this.currentDistanceKm,
    required this.currentCalories,
    required this.currentWalkingTime,
    required this.status,
    required this.completionPercentage,
    required this.remainingSteps,
    this.estimatedCompletion,
  });

  final GoalEntity goal;
  final int currentSteps;
  final double currentDistanceKm;
  final double currentCalories;
  final Duration currentWalkingTime;
  final GoalStatus status;
  final double completionPercentage;
  final int remainingSteps;
  final DateTime? estimatedCompletion;

  @override
  List<Object?> get props => [
        goal,
        currentSteps,
        currentDistanceKm,
        currentCalories,
        currentWalkingTime,
        status,
        completionPercentage,
        remainingSteps,
        estimatedCompletion,
      ];
}
