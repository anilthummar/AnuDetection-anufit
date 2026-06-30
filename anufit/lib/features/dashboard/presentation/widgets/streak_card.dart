import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:anufit/app/theme/app_colors.dart';
import 'package:anufit/core/entities/streak_info.dart';
import 'package:anufit/core/constants/app_spacing.dart';
import 'package:anufit/features/dashboard/domain/entities/dashboard_summary.dart';
import 'package:anufit/shared/widgets/design_system.dart';

class StreakCard extends StatelessWidget {
  const StreakCard({
    required this.streak,
    super.key,
  });

  final StreakInfo streak;

  @override
  Widget build(BuildContext context) {
    final lastGoal = streak.lastGoalCompletedDate;

    return AppCard(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.warning.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.local_fire_department_rounded, color: AppColors.warning, size: 32),
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Current Streak',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  '${streak.currentStreak} day${streak.currentStreak == 1 ? '' : 's'}',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.warning,
                      ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Longest: ${streak.longestStreak} days',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                if (lastGoal != null)
                  Text(
                    'Last goal: ${DateFormat.MMMd().format(lastGoal)}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.65),
                        ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
