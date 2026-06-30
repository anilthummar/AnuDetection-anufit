import 'package:flutter/material.dart';

import 'package:anufit/app/theme/app_colors.dart';
import 'package:anufit/core/constants/app_spacing.dart';
import 'package:anufit/features/goals/domain/entities/goal_entity.dart';
import 'package:anufit/shared/widgets/design_system.dart';

class GoalCompletionBanner extends StatelessWidget {
  const GoalCompletionBanner({required this.progress, super.key});

  final GoalProgressEntity progress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: AppCard(
        child: Row(
          children: [
            const Icon(Icons.celebration, color: AppColors.success),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                progress.status == GoalStatus.exceeded
                    ? 'Goal exceeded! ${progress.currentSteps} steps'
                    : 'Daily goal completed!',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
