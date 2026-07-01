import 'package:flutter/material.dart';

import 'package:anufit/app/theme/app_colors.dart';
import 'package:anufit/core/constants/app_spacing.dart';
import 'package:anufit/shared/widgets/design_system.dart';

/// Prominent today's step total — always visible near the top of the dashboard.
class TodayStepsSummary extends StatelessWidget {
  const TodayStepsSummary({
    required this.steps,
    required this.goal,
    super.key,
  });

  final int steps;
  final int goal;

  @override
  Widget build(BuildContext context) {
    final goalReached = goal > 0 && steps >= goal;
    final progressLabel = goal > 0
        ? goalReached
            ? 'Goal reached'
            : '${_format(steps)} / ${_format(goal)} goal'
        : '${_format(steps)} steps';

    return AppCard(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.xl,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Today',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withValues(alpha: 0.65),
                      ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  _format(steps),
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        height: 1.05,
                      ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'steps',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                goalReached ? Icons.emoji_events_outlined : Icons.flag_outlined,
                color: goalReached ? AppColors.success : AppColors.primary,
                size: 28,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                progressLabel,
                textAlign: TextAlign.end,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: goalReached
                          ? AppColors.success
                          : Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withValues(alpha: 0.75),
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _format(int value) => value.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (m) => '${m[1]},',
      );
}
