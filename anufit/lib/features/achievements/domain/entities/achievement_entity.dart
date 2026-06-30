import 'package:equatable/equatable.dart';

enum AchievementCategory { steps, streak, distance, calories, walkingTime }

class UserStats extends Equatable {
  const UserStats({
    required this.todaySteps,
    required this.lifetimeSteps,
    required this.currentStreak,
    required this.longestStreak,
    required this.todayDistanceKm,
    required this.lifetimeDistanceKm,
    required this.todayCalories,
    required this.lifetimeCalories,
    required this.todayWalkingTime,
    required this.lifetimeWalkingTime,
    required this.averageDailySteps,
    required this.goalCompletionRate,
  });

  final int todaySteps;
  final int lifetimeSteps;
  final int currentStreak;
  final int longestStreak;
  final double todayDistanceKm;
  final double lifetimeDistanceKm;
  final double todayCalories;
  final double lifetimeCalories;
  final Duration todayWalkingTime;
  final Duration lifetimeWalkingTime;
  final int averageDailySteps;
  final double goalCompletionRate;

  @override
  List<Object?> get props => [
        todaySteps,
        lifetimeSteps,
        currentStreak,
        longestStreak,
        todayDistanceKm,
        lifetimeDistanceKm,
        todayCalories,
        lifetimeCalories,
        todayWalkingTime,
        lifetimeWalkingTime,
        averageDailySteps,
        goalCompletionRate,
      ];
}

class AchievementEntity extends Equatable {
  const AchievementEntity({
    required this.ruleId,
    required this.title,
    required this.category,
    required this.completed,
    required this.progress,
    required this.xp,
    this.completedAt,
  });

  final String ruleId;
  final String title;
  final AchievementCategory category;
  final bool completed;
  final double progress;
  final int xp;
  final DateTime? completedAt;

  @override
  List<Object?> get props => [ruleId, title, category, completed, progress, xp, completedAt];
}
