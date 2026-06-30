import 'package:equatable/equatable.dart';

import 'package:anufit/core/services/health_metrics_engine.dart';

class WeightEntryEntity extends Equatable {
  const WeightEntryEntity({
    required this.id,
    required this.date,
    required this.weightKg,
    required this.bmi,
    this.note,
  });

  final int id;
  final DateTime date;
  final double weightKg;
  final double bmi;
  final String? note;

  BmiCategory get category => HealthMetricsEngine.bmiCategory(bmi);

  @override
  List<Object?> get props => [id, date, weightKg, bmi, note];
}

class WeightDashboardEntity extends Equatable {
  const WeightDashboardEntity({
    required this.currentWeightKg,
    required this.goalWeightKg,
    required this.bmi,
    required this.category,
    required this.remainingKg,
    required this.history,
  });

  final double currentWeightKg;
  final double goalWeightKg;
  final double bmi;
  final BmiCategory category;
  final double remainingKg;
  final List<WeightEntryEntity> history;

  @override
  List<Object?> get props =>
      [currentWeightKg, goalWeightKg, bmi, category, remainingKg, history];
}

enum WeightChartPeriod { weekly, monthly, yearly }
