import 'package:anufit/features/achievements/domain/entities/achievement_entity.dart';

abstract class AchievementRule {
  String get id;
  String get title;
  AchievementCategory get category;

  bool isUnlocked(UserStats stats);
  double progress(UserStats stats);
  int rewardXp();
}

final class First100StepsRule extends AchievementRule {
  @override
  String get id => 'steps_first_100';
  @override
  String get title => 'First 100';
  @override
  AchievementCategory get category => AchievementCategory.steps;
  @override
  bool isUnlocked(UserStats stats) => stats.lifetimeSteps >= 100;
  @override
  double progress(UserStats stats) => (stats.lifetimeSteps / 100).clamp(0, 1);
  @override
  int rewardXp() => 10;
}

final class First1000StepsRule extends AchievementRule {
  @override
  String get id => 'steps_first_1k';
  @override
  String get title => 'First 1K';
  @override
  AchievementCategory get category => AchievementCategory.steps;
  @override
  bool isUnlocked(UserStats stats) => stats.lifetimeSteps >= 1000;
  @override
  double progress(UserStats stats) => (stats.lifetimeSteps / 1000).clamp(0, 1);
  @override
  int rewardXp() => 25;
}

final class First5000StepsRule extends AchievementRule {
  @override
  String get id => 'steps_first_5k';
  @override
  String get title => 'First 5K';
  @override
  AchievementCategory get category => AchievementCategory.steps;
  @override
  bool isUnlocked(UserStats stats) => stats.lifetimeSteps >= 5000;
  @override
  double progress(UserStats stats) => (stats.lifetimeSteps / 5000).clamp(0, 1);
  @override
  int rewardXp() => 50;
}

final class First10000StepsRule extends AchievementRule {
  @override
  String get id => 'steps_first_10k';
  @override
  String get title => 'First 10K';
  @override
  AchievementCategory get category => AchievementCategory.steps;
  @override
  bool isUnlocked(UserStats stats) => stats.todaySteps >= 10000 || stats.lifetimeSteps >= 10000;
  @override
  double progress(UserStats stats) => (stats.todaySteps / 10000).clamp(0, 1);
  @override
  int rewardXp() => 100;
}

final class First20000StepsRule extends AchievementRule {
  @override
  String get id => 'steps_first_20k';
  @override
  String get title => 'First 20K';
  @override
  AchievementCategory get category => AchievementCategory.steps;
  @override
  bool isUnlocked(UserStats stats) => stats.todaySteps >= 20000;
  @override
  double progress(UserStats stats) => (stats.todaySteps / 20000).clamp(0, 1);
  @override
  int rewardXp() => 150;
}

final class Lifetime50kStepsRule extends AchievementRule {
  @override
  String get id => 'steps_lifetime_50k';
  @override
  String get title => '50K Lifetime';
  @override
  AchievementCategory get category => AchievementCategory.steps;
  @override
  bool isUnlocked(UserStats stats) => stats.lifetimeSteps >= 50000;
  @override
  double progress(UserStats stats) => (stats.lifetimeSteps / 50000).clamp(0, 1);
  @override
  int rewardXp() => 200;
}

final class Lifetime100kStepsRule extends AchievementRule {
  @override
  String get id => 'steps_lifetime_100k';
  @override
  String get title => '100K Lifetime';
  @override
  AchievementCategory get category => AchievementCategory.steps;
  @override
  bool isUnlocked(UserStats stats) => stats.lifetimeSteps >= 100000;
  @override
  double progress(UserStats stats) => (stats.lifetimeSteps / 100000).clamp(0, 1);
  @override
  int rewardXp() => 300;
}

final class Lifetime500kStepsRule extends AchievementRule {
  @override
  String get id => 'steps_lifetime_500k';
  @override
  String get title => '500K Lifetime';
  @override
  AchievementCategory get category => AchievementCategory.steps;
  @override
  bool isUnlocked(UserStats stats) => stats.lifetimeSteps >= 500000;
  @override
  double progress(UserStats stats) => (stats.lifetimeSteps / 500000).clamp(0, 1);
  @override
  int rewardXp() => 500;
}

final class Lifetime1mStepsRule extends AchievementRule {
  @override
  String get id => 'steps_lifetime_1m';
  @override
  String get title => '1M Lifetime';
  @override
  AchievementCategory get category => AchievementCategory.steps;
  @override
  bool isUnlocked(UserStats stats) => stats.lifetimeSteps >= 1000000;
  @override
  double progress(UserStats stats) => (stats.lifetimeSteps / 1000000).clamp(0, 1);
  @override
  int rewardXp() => 1000;
}

final class ThreeDayStreakRule extends AchievementRule {
  @override
  String get id => 'streak_3';
  @override
  String get title => '3 Days';
  @override
  AchievementCategory get category => AchievementCategory.streak;
  @override
  bool isUnlocked(UserStats stats) => stats.currentStreak >= 3;
  @override
  double progress(UserStats stats) => (stats.currentStreak / 3).clamp(0, 1);
  @override
  int rewardXp() => 30;
}

final class SevenDayStreakRule extends AchievementRule {
  @override
  String get id => 'streak_7';
  @override
  String get title => '7 Days';
  @override
  AchievementCategory get category => AchievementCategory.streak;
  @override
  bool isUnlocked(UserStats stats) => stats.currentStreak >= 7;
  @override
  double progress(UserStats stats) => (stats.currentStreak / 7).clamp(0, 1);
  @override
  int rewardXp() => 70;
}

final class FourteenDayStreakRule extends AchievementRule {
  @override
  String get id => 'streak_14';
  @override
  String get title => '14 Days';
  @override
  AchievementCategory get category => AchievementCategory.streak;
  @override
  bool isUnlocked(UserStats stats) => stats.currentStreak >= 14;
  @override
  double progress(UserStats stats) => (stats.currentStreak / 14).clamp(0, 1);
  @override
  int rewardXp() => 140;
}

final class ThirtyDayStreakRule extends AchievementRule {
  @override
  String get id => 'streak_30';
  @override
  String get title => '30 Days';
  @override
  AchievementCategory get category => AchievementCategory.streak;
  @override
  bool isUnlocked(UserStats stats) => stats.currentStreak >= 30;
  @override
  double progress(UserStats stats) => (stats.currentStreak / 30).clamp(0, 1);
  @override
  int rewardXp() => 300;
}

final class HundredDayStreakRule extends AchievementRule {
  @override
  String get id => 'streak_100';
  @override
  String get title => '100 Days';
  @override
  AchievementCategory get category => AchievementCategory.streak;
  @override
  bool isUnlocked(UserStats stats) => stats.longestStreak >= 100;
  @override
  double progress(UserStats stats) => (stats.longestStreak / 100).clamp(0, 1);
  @override
  int rewardXp() => 1000;
}

final class ThreeSixtyFiveDayStreakRule extends AchievementRule {
  @override
  String get id => 'streak_365';
  @override
  String get title => '365 Days';
  @override
  AchievementCategory get category => AchievementCategory.streak;
  @override
  bool isUnlocked(UserStats stats) => stats.longestStreak >= 365;
  @override
  double progress(UserStats stats) => (stats.longestStreak / 365).clamp(0, 1);
  @override
  int rewardXp() => 3650;
}

final class Distance10kmRule extends AchievementRule {
  @override
  String get id => 'distance_10k';
  @override
  String get title => '10 km';
  @override
  AchievementCategory get category => AchievementCategory.distance;
  @override
  bool isUnlocked(UserStats stats) => stats.lifetimeDistanceKm >= 10;
  @override
  double progress(UserStats stats) => (stats.lifetimeDistanceKm / 10).clamp(0, 1);
  @override
  int rewardXp() => 40;
}

final class Distance50kmRule extends AchievementRule {
  @override
  String get id => 'distance_50k';
  @override
  String get title => '50 km';
  @override
  AchievementCategory get category => AchievementCategory.distance;
  @override
  bool isUnlocked(UserStats stats) => stats.lifetimeDistanceKm >= 50;
  @override
  double progress(UserStats stats) => (stats.lifetimeDistanceKm / 50).clamp(0, 1);
  @override
  int rewardXp() => 80;
}

final class Distance100kmRule extends AchievementRule {
  @override
  String get id => 'distance_100k';
  @override
  String get title => '100 km';
  @override
  AchievementCategory get category => AchievementCategory.distance;
  @override
  bool isUnlocked(UserStats stats) => stats.lifetimeDistanceKm >= 100;
  @override
  double progress(UserStats stats) => (stats.lifetimeDistanceKm / 100).clamp(0, 1);
  @override
  int rewardXp() => 150;
}

final class Distance500kmRule extends AchievementRule {
  @override
  String get id => 'distance_500k';
  @override
  String get title => '500 km';
  @override
  AchievementCategory get category => AchievementCategory.distance;
  @override
  bool isUnlocked(UserStats stats) => stats.lifetimeDistanceKm >= 500;
  @override
  double progress(UserStats stats) => (stats.lifetimeDistanceKm / 500).clamp(0, 1);
  @override
  int rewardXp() => 500;
}

final class Calories1000Rule extends AchievementRule {
  @override
  String get id => 'calories_1k';
  @override
  String get title => '1,000';
  @override
  AchievementCategory get category => AchievementCategory.calories;
  @override
  bool isUnlocked(UserStats stats) => stats.lifetimeCalories >= 1000;
  @override
  double progress(UserStats stats) => (stats.lifetimeCalories / 1000).clamp(0, 1);
  @override
  int rewardXp() => 25;
}

final class Calories5000Rule extends AchievementRule {
  @override
  String get id => 'calories_5k';
  @override
  String get title => '5,000';
  @override
  AchievementCategory get category => AchievementCategory.calories;
  @override
  bool isUnlocked(UserStats stats) => stats.lifetimeCalories >= 5000;
  @override
  double progress(UserStats stats) => (stats.lifetimeCalories / 5000).clamp(0, 1);
  @override
  int rewardXp() => 75;
}

final class Calories10000Rule extends AchievementRule {
  @override
  String get id => 'calories_10k';
  @override
  String get title => '10,000';
  @override
  AchievementCategory get category => AchievementCategory.calories;
  @override
  bool isUnlocked(UserStats stats) => stats.lifetimeCalories >= 10000;
  @override
  double progress(UserStats stats) => (stats.lifetimeCalories / 10000).clamp(0, 1);
  @override
  int rewardXp() => 150;
}

final class Calories50000Rule extends AchievementRule {
  @override
  String get id => 'calories_50k';
  @override
  String get title => '50,000';
  @override
  AchievementCategory get category => AchievementCategory.calories;
  @override
  bool isUnlocked(UserStats stats) => stats.lifetimeCalories >= 50000;
  @override
  double progress(UserStats stats) => (stats.lifetimeCalories / 50000).clamp(0, 1);
  @override
  int rewardXp() => 500;
}

final class WalkingTime1HourRule extends AchievementRule {
  @override
  String get id => 'walking_1h';
  @override
  String get title => '1 Hour';
  @override
  AchievementCategory get category => AchievementCategory.walkingTime;
  @override
  bool isUnlocked(UserStats stats) => stats.lifetimeWalkingTime.inHours >= 1;
  @override
  double progress(UserStats stats) => (stats.lifetimeWalkingTime.inMinutes / 60).clamp(0, 1);
  @override
  int rewardXp() => 20;
}

final class WalkingTime10HoursRule extends AchievementRule {
  @override
  String get id => 'walking_10h';
  @override
  String get title => '10 Hours';
  @override
  AchievementCategory get category => AchievementCategory.walkingTime;
  @override
  bool isUnlocked(UserStats stats) => stats.lifetimeWalkingTime.inHours >= 10;
  @override
  double progress(UserStats stats) => (stats.lifetimeWalkingTime.inHours / 10).clamp(0, 1);
  @override
  int rewardXp() => 100;
}

final class WalkingTime100HoursRule extends AchievementRule {
  @override
  String get id => 'walking_100h';
  @override
  String get title => '100 Hours';
  @override
  AchievementCategory get category => AchievementCategory.walkingTime;
  @override
  bool isUnlocked(UserStats stats) => stats.lifetimeWalkingTime.inHours >= 100;
  @override
  double progress(UserStats stats) => (stats.lifetimeWalkingTime.inHours / 100).clamp(0, 1);
  @override
  int rewardXp() => 500;
}

List<AchievementRule> allAchievementRules() => [
      First100StepsRule(),
      First1000StepsRule(),
      First5000StepsRule(),
      First10000StepsRule(),
      First20000StepsRule(),
      Lifetime50kStepsRule(),
      Lifetime100kStepsRule(),
      Lifetime500kStepsRule(),
      Lifetime1mStepsRule(),
      ThreeDayStreakRule(),
      SevenDayStreakRule(),
      FourteenDayStreakRule(),
      ThirtyDayStreakRule(),
      HundredDayStreakRule(),
      ThreeSixtyFiveDayStreakRule(),
      Distance10kmRule(),
      Distance50kmRule(),
      Distance100kmRule(),
      Distance500kmRule(),
      Calories1000Rule(),
      Calories5000Rule(),
      Calories10000Rule(),
      Calories50000Rule(),
      WalkingTime1HourRule(),
      WalkingTime10HoursRule(),
      WalkingTime100HoursRule(),
    ];
