import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:anufit/core/constants/app_spacing.dart';
import 'package:anufit/features/step_counter/domain/entities/step_data.dart';
import 'package:anufit/shared/widgets/design_system.dart';

class WeeklySummary extends StatelessWidget {
  const WeeklySummary({
    required this.weekly,
    required this.goal,
    super.key,
  });

  final List<StepPeriodSummary> weekly;
  final int goal;

  @override
  Widget build(BuildContext context) {
    if (weekly.isEmpty) {
      return const AppCard(child: Text('No weekly data yet.'));
    }

    final met = weekly.where((d) => d.steps >= goal).length;
    final total = weekly.fold<int>(0, (sum, d) => sum + d.steps);
    final maxSteps = weekly.fold<int>(0, (max, d) => d.steps > max ? d.steps : max);

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Weekly Summary', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          Text('$met / ${weekly.length} days on goal • $total total steps'),
          const SizedBox(height: AppSpacing.md),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (final day in weekly)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Column(
                      children: [
                        Container(
                          height: maxSteps > 0 ? (day.steps / maxSteps) * 80 : 0,
                          decoration: BoxDecoration(
                            color: day.steps >= goal
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.primary.withValues(alpha: 0.35),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          DateFormat('E').format(day.periodStart),
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
