import 'package:flutter/material.dart';

import 'package:anufit/app/theme/app_colors.dart';
import 'package:anufit/core/constants/app_spacing.dart';
import 'package:anufit/shared/widgets/design_system.dart';

class StatisticsHeatmap extends StatelessWidget {
  const StatisticsHeatmap({
    required this.data,
    super.key,
  });

  final List<({DateTime date, int steps})> data;

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const AppCard(child: Text('No heatmap data yet.'));
    }

    final maxSteps = data.fold<int>(0, (m, d) => d.steps > m ? d.steps : m);
    final weeks = <List<({DateTime date, int steps})>>[];
    var currentWeek = <({DateTime date, int steps})>[];

    for (var i = 0; i < data.length; i++) {
      currentWeek.add(data[i]);
      if (data[i].date.weekday == DateTime.sunday || i == data.length - 1) {
        weeks.add(currentWeek);
        currentWeek = [];
      }
    }

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Yearly Activity', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpacing.md),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final week in weeks)
                  Column(
                    children: [
                      for (final day in week)
                        Container(
                          width: 12,
                          height: 12,
                          margin: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: _colorFor(day.steps, maxSteps),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _colorFor(int steps, int max) {
    if (steps <= 0) return AppColors.border.withValues(alpha: 0.2);
    final intensity = max > 0 ? steps / max : 0.0;
    return Color.lerp(
      AppColors.warning.withValues(alpha: 0.3),
      AppColors.success,
      intensity,
    )!;
  }
}
