import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:anufit/app/theme/app_colors.dart';
import 'package:anufit/core/constants/app_spacing.dart';
import 'package:anufit/features/dashboard/domain/entities/dashboard_summary.dart';
import 'package:anufit/shared/widgets/design_system.dart';

class GoalCard extends StatelessWidget {
  const GoalCard({
    required this.progress,
    super.key,
  });

  final GoalProgress progress;

  @override
  Widget build(BuildContext context) {
    final eta = progress.estimatedCompletion;
    final etaLabel = eta == null
        ? 'Keep moving to estimate completion'
        : 'Est. goal by ${DateFormat.jm().format(eta)}';

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.flag_rounded, color: AppColors.success),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'Daily Goal',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          LinearProgressIndicator(
            value: progress.completionPercentage,
            minHeight: 8,
            borderRadius: BorderRadius.circular(8),
            backgroundColor: AppColors.border,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            '${_format(progress.todaySteps)} / ${_format(progress.goal)} steps',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '${_format(progress.remainingSteps)} steps remaining',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            etaLabel,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.65),
                ),
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
