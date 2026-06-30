import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:anufit/app/theme/app_colors.dart';
import 'package:anufit/core/constants/app_spacing.dart';
import 'package:anufit/features/activity/domain/entities/timeline_entity.dart';
import 'package:anufit/shared/widgets/design_system.dart';

class ActivityHeatmap extends StatelessWidget {
  const ActivityHeatmap({
    required this.dailySummaries,
    super.key,
  });

  /// Map of date (midnight local) to hourly timeline entries.
  final Map<DateTime, List<TimelineEntry>> dailySummaries;

  @override
  Widget build(BuildContext context) {
    if (dailySummaries.isEmpty) {
      return const AppCard(child: Text('No activity heatmap data yet.'));
    }

    final maxSteps = dailySummaries.values
        .expand((entries) => entries)
        .fold<int>(0, (max, e) => e.steps > max ? e.steps : max);

    final sortedDays = dailySummaries.keys.toList()..sort();

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Activity Heatmap', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpacing.md),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final day in sortedDays) ...[
                  Column(
                    children: [
                      Text(
                        DateFormat('E').format(day),
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      for (var hour = 6; hour <= 22; hour += 2)
                        _HeatCell(
                          steps: _stepsForHour(dailySummaries[day] ?? [], hour),
                          maxSteps: maxSteps,
                        ),
                    ],
                  ),
                  const SizedBox(width: AppSpacing.xs),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  int _stepsForHour(List<TimelineEntry> entries, int hour) {
    return entries.where((e) => e.hour == hour).fold<int>(0, (sum, e) => sum + e.steps);
  }
}

class _HeatCell extends StatelessWidget {
  const _HeatCell({required this.steps, required this.maxSteps});

  final int steps;
  final int maxSteps;

  @override
  Widget build(BuildContext context) {
    final intensity = maxSteps > 0 ? steps / maxSteps : 0.0;
    final color = Color.lerp(
      AppColors.border.withValues(alpha: 0.3),
      AppColors.secondary,
      intensity,
    );

    return Container(
      width: 14,
      height: 14,
      margin: const EdgeInsets.only(bottom: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
