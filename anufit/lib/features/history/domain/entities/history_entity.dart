import 'package:equatable/equatable.dart';

class DailySummaryEntity extends Equatable {
  const DailySummaryEntity({
    required this.date,
    required this.steps,
    required this.distanceKm,
    required this.calories,
    required this.walkingTime,
    required this.goalCompleted,
  });

  final DateTime date;
  final int steps;
  final double distanceKm;
  final double calories;
  final Duration walkingTime;
  final bool goalCompleted;

  @override
  List<Object?> get props =>
      [date, steps, distanceKm, calories, walkingTime, goalCompleted];
}

class WeeklySummaryEntity extends Equatable {
  const WeeklySummaryEntity({
    required this.week,
    required this.year,
    required this.steps,
    required this.distanceKm,
    required this.calories,
    required this.walkingTime,
  });

  final int week;
  final int year;
  final int steps;
  final double distanceKm;
  final double calories;
  final Duration walkingTime;

  @override
  List<Object?> get props => [week, year, steps, distanceKm, calories, walkingTime];
}

class MonthlySummaryEntity extends Equatable {
  const MonthlySummaryEntity({
    required this.month,
    required this.year,
    required this.steps,
    required this.distanceKm,
    required this.calories,
    required this.walkingTime,
    required this.activeDays,
  });

  final int month;
  final int year;
  final int steps;
  final double distanceKm;
  final double calories;
  final Duration walkingTime;
  final int activeDays;

  @override
  List<Object?> get props =>
      [month, year, steps, distanceKm, calories, walkingTime, activeDays];
}

class LifetimeSummaryEntity extends Equatable {
  const LifetimeSummaryEntity({
    required this.totalSteps,
    required this.totalDistanceKm,
    required this.totalCalories,
    required this.totalWalkingTime,
    required this.activeDays,
  });

  final int totalSteps;
  final double totalDistanceKm;
  final double totalCalories;
  final Duration totalWalkingTime;
  final int activeDays;

  @override
  List<Object?> get props =>
      [totalSteps, totalDistanceKm, totalCalories, totalWalkingTime, activeDays];
}

enum HistoryPeriod { daily, weekly, monthly, yearly }

enum HistoryFilter {
  today,
  yesterday,
  last7Days,
  last30Days,
  thisMonth,
  thisYear,
  custom,
}

class HistorySearchQuery extends Equatable {
  const HistorySearchQuery({
    this.date,
    this.goalCompleted,
    this.minSteps,
    this.maxSteps,
  });

  final DateTime? date;
  final bool? goalCompleted;
  final int? minSteps;
  final int? maxSteps;

  @override
  List<Object?> get props => [date, goalCompleted, minSteps, maxSteps];
}

class HistoryPageResult extends Equatable {
  const HistoryPageResult({
    required this.items,
    required this.hasMore,
    required this.page,
  });

  final List<DailySummaryEntity> items;
  final bool hasMore;
  final int page;

  @override
  List<Object?> get props => [items, hasMore, page];
}

class AggregatedHistoryEntity extends Equatable {
  const AggregatedHistoryEntity({
    required this.label,
    required this.steps,
    required this.distanceKm,
    required this.calories,
    required this.walkingTime,
    this.goalCompleted,
  });

  final String label;
  final int steps;
  final double distanceKm;
  final double calories;
  final Duration walkingTime;
  final bool? goalCompleted;

  @override
  List<Object?> get props =>
      [label, steps, distanceKm, calories, walkingTime, goalCompleted];
}
