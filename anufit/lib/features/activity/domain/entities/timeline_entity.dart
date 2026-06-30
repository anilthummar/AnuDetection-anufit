import 'package:equatable/equatable.dart';

enum TimelineFilter { today, yesterday, thisWeek, thisMonth, custom }

class TimelineEntry extends Equatable {
  const TimelineEntry({
    required this.hour,
    required this.steps,
    required this.distanceKm,
    required this.calories,
    required this.walkingTime,
    required this.goalReached,
  });

  final int hour;
  final int steps;
  final double distanceKm;
  final double calories;
  final Duration walkingTime;
  final bool goalReached;

  @override
  List<Object?> get props => [hour, steps, distanceKm, calories, walkingTime, goalReached];
}

class TimelineSummary extends Equatable {
  const TimelineSummary({
    required this.entries,
    required this.peakHour,
    required this.leastActiveHour,
    required this.totalSteps,
    required this.averageIntensity,
  });

  final List<TimelineEntry> entries;
  final int peakHour;
  final int leastActiveHour;
  final int totalSteps;
  final double averageIntensity;

  @override
  List<Object?> get props => [entries, peakHour, leastActiveHour, totalSteps, averageIntensity];
}

class ActivityInsight extends Equatable {
  const ActivityInsight({
    required this.title,
    required this.description,
    required this.iconName,
  });

  final String title;
  final String description;
  final String iconName;

  @override
  List<Object?> get props => [title, description, iconName];
}
