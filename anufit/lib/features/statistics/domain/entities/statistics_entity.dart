import 'package:equatable/equatable.dart';

import 'package:anufit/core/enums/unit_system.dart';
import 'package:anufit/features/history/domain/entities/history_entity.dart';
import 'package:anufit/features/step_counter/domain/entities/hourly_step_point.dart';

enum StatisticsPeriod { daily, weekly, monthly, yearly, lifetime }

class PeriodMetrics extends Equatable {
  const PeriodMetrics({
    required this.steps,
    required this.calories,
    required this.distanceKm,
    required this.walkingTime,
    this.averageDailySteps,
    this.goalCompletionRate,
    this.activeHours,
    this.averageSpeedKmh,
    this.longestWalk,
    this.peakDay,
    this.restDay,
    this.activeDays,
    this.averagePaceMinPerKm,
    this.highestStepDay,
    this.lowestStepDay,
  });

  final int steps;
  final double calories;
  final double distanceKm;
  final Duration walkingTime;
  final int? averageDailySteps;
  final double? goalCompletionRate;
  final int? activeHours;
  final double? averageSpeedKmh;
  final Duration? longestWalk;
  final DateTime? peakDay;
  final DateTime? restDay;
  final int? activeDays;
  final double? averagePaceMinPerKm;
  final DateTime? highestStepDay;
  final DateTime? lowestStepDay;

  @override
  List<Object?> get props => [
        steps,
        calories,
        distanceKm,
        walkingTime,
        averageDailySteps,
        goalCompletionRate,
        activeHours,
        averageSpeedKmh,
        longestWalk,
        peakDay,
        restDay,
        activeDays,
        averagePaceMinPerKm,
        highestStepDay,
        lowestStepDay,
      ];
}

class StatisticsInsight extends Equatable {
  const StatisticsInsight({
    required this.title,
    required this.value,
    required this.iconName,
  });

  final String title;
  final String value;
  final String iconName;

  @override
  List<Object?> get props => [title, value, iconName];
}

class ChartDataPoint extends Equatable {
  const ChartDataPoint({required this.label, required this.value});

  final String label;
  final double value;

  @override
  List<Object?> get props => [label, value];
}

class StatisticsBundle extends Equatable {
  const StatisticsBundle({
    required this.period,
    required this.metrics,
    required this.insights,
    required this.lifetime,
    required this.heatmap,
    required this.hourlyPoints,
    required this.weeklyBars,
    required this.monthlyLine,
    required this.yearlyBars,
    required this.unit,
  });

  final StatisticsPeriod period;
  final PeriodMetrics metrics;
  final List<StatisticsInsight> insights;
  final LifetimeSummaryEntity lifetime;
  final List<({DateTime date, int steps})> heatmap;
  final List<HourlyStepPoint> hourlyPoints;
  final List<ChartDataPoint> weeklyBars;
  final List<ChartDataPoint> monthlyLine;
  final List<ChartDataPoint> yearlyBars;
  final UnitSystem unit;

  @override
  List<Object?> get props => [
        period,
        metrics,
        insights,
        lifetime,
        heatmap,
        hourlyPoints,
        weeklyBars,
        monthlyLine,
        yearlyBars,
        unit,
      ];
}

enum ChartType { daily, weekly, monthly, yearly }

class ChartState extends Equatable {
  const ChartState({
    required this.type,
    required this.points,
    this.isLoading = false,
  });

  final ChartType type;
  final List<ChartDataPoint> points;
  final bool isLoading;

  @override
  List<Object?> get props => [type, points, isLoading];
}
