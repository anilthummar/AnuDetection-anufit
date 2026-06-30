import 'package:anufit/core/services/health_metrics_engine.dart';
import 'package:anufit/core/utils/unit_format.dart';
import 'package:anufit/core/enums/unit_system.dart';
import 'package:anufit/shared/widgets/design_system.dart';
import 'package:flutter/material.dart';

class WeightCard extends StatelessWidget {
  const WeightCard({
    required this.weightKg,
    required this.unit,
    super.key,
  });

  final double weightKg;
  final UnitSystem unit;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Current Weight', style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 8),
          Text(
            UnitFormat.weightLabel(weightKg, unit),
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class BmiCard extends StatelessWidget {
  const BmiCard({required this.bmi, required this.category, super.key});

  final double bmi;
  final BmiCategory category;

  @override
  Widget build(BuildContext context) {
    final color = switch (category) {
      BmiCategory.healthy => Colors.green,
      BmiCategory.underweight => Colors.blue,
      BmiCategory.overweight => Colors.orange,
      BmiCategory.obese => Colors.red,
    };
    return AppCard(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('BMI', style: Theme.of(context).textTheme.labelLarge),
                Text(bmi.toStringAsFixed(1), style: Theme.of(context).textTheme.headlineSmall),
              ],
            ),
          ),
          Chip(
            label: Text(HealthMetricsEngine.bmiCategoryLabel(category)),
            backgroundColor: color.withValues(alpha: 0.15),
            labelStyle: TextStyle(color: color, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class GoalWeightCard extends StatelessWidget {
  const GoalWeightCard({
    required this.goalKg,
    required this.remainingKg,
    required this.unit,
    super.key,
  });

  final double goalKg;
  final double remainingKg;
  final UnitSystem unit;

  @override
  Widget build(BuildContext context) {
    final sign = remainingKg > 0 ? '-' : '+';
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Goal Weight', style: Theme.of(context).textTheme.labelLarge),
          Text(UnitFormat.weightLabel(goalKg, unit), style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(
            '$sign${UnitFormat.weightLabel(remainingKg.abs(), unit)} remaining',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
