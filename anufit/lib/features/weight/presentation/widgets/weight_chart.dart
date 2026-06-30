import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:anufit/core/utils/unit_format.dart';
import 'package:anufit/core/enums/unit_system.dart';
import 'package:anufit/features/weight/domain/entities/weight_entity.dart';
import 'package:anufit/shared/widgets/design_system.dart';

class WeightChart extends StatelessWidget {
  const WeightChart({
    required this.history,
    required this.period,
    required this.unit,
    super.key,
  });

  final List<WeightEntryEntity> history;
  final WeightChartPeriod period;
  final UnitSystem unit;

  List<WeightEntryEntity> get _filtered {
    final now = DateTime.now();
    final start = switch (period) {
      WeightChartPeriod.weekly => now.subtract(const Duration(days: 7)),
      WeightChartPeriod.monthly => now.subtract(const Duration(days: 30)),
      WeightChartPeriod.yearly => now.subtract(const Duration(days: 365)),
    };
    return history.where((e) => !e.date.isBefore(start)).toList().reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    final points = _filtered;
    if (points.isEmpty) {
      return const AppCard(child: Text('No weight history yet.'));
    }

    final spots = points
        .asMap()
        .entries
        .map((e) => FlSpot(
              e.key.toDouble(),
              UnitFormat.displayWeight(e.value.weightKg, unit),
            ))
        .toList();

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Weight Trend', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 16),
          SizedBox(
            height: 180,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    dotData: const FlDotData(show: true),
                    color: Theme.of(context).colorScheme.primary,
                    barWidth: 3,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
