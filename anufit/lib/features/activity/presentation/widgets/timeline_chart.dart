import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:anufit/app/theme/app_colors.dart';
import 'package:anufit/core/constants/app_spacing.dart';
import 'package:anufit/features/activity/domain/entities/timeline_entity.dart';
import 'package:anufit/shared/widgets/design_system.dart';

class TimelineChart extends StatelessWidget {
  const TimelineChart({required this.summary, super.key});

  final TimelineSummary summary;

  @override
  Widget build(BuildContext context) {
    final maxY = summary.entries.fold<double>(
      0,
      (m, e) => e.steps > m ? e.steps.toDouble() : m,
    );

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Activity Intensity', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          Text('Peak: ${_formatHour(summary.peakHour)} • Least active: ${_formatHour(summary.leastActiveHour)}'),
          const SizedBox(height: AppSpacing.lg),
          SizedBox(
            height: 180,
            child: BarChart(
              BarChartData(
                maxY: maxY > 0 ? maxY * 1.2 : 100,
                borderData: FlBorderData(show: false),
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(
                  leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                barGroups: [
                  for (final entry in summary.entries)
                    BarChartGroupData(
                      x: entry.hour,
                      barRods: [
                        BarChartRodData(
                          toY: entry.steps.toDouble(),
                          color: entry.hour == summary.peakHour
                              ? AppColors.secondary
                              : AppColors.primary,
                          width: 10,
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatHour(int hour) {
    final period = hour >= 12 ? 'PM' : 'AM';
    final display = hour % 12 == 0 ? 12 : hour % 12;
    return '$display $period';
  }
}
