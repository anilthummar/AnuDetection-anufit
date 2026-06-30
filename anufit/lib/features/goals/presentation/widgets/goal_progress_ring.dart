import 'package:flutter/material.dart';

import 'package:anufit/app/theme/app_colors.dart';
import 'package:anufit/core/constants/app_spacing.dart';
import 'package:anufit/features/goals/domain/entities/goal_entity.dart';
import 'package:anufit/shared/widgets/design_system.dart';

class GoalProgressRing extends StatelessWidget {
  const GoalProgressRing({required this.progress, super.key});

  final GoalProgressEntity progress;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        children: [
          SizedBox(
            height: 160,
            width: 160,
            child: CircularProgressIndicator(
              value: progress.completionPercentage,
              strokeWidth: 12,
              backgroundColor: AppColors.border,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            '${progress.currentSteps} / ${progress.goal.stepGoal}',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Text('${(progress.completionPercentage * 100).round()}%'),
        ],
      ),
    );
  }
}
