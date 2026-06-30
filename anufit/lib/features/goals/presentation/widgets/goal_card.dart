import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:anufit/core/constants/app_spacing.dart';
import 'package:anufit/features/goals/domain/entities/goal_entity.dart';
import 'package:anufit/shared/widgets/design_system.dart';

class GoalCard extends StatelessWidget {
  const GoalCard({required this.progress, super.key});

  final GoalProgressEntity progress;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Today's Goal", style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpacing.md),
          Text('${progress.currentSteps} / ${progress.goal.stepGoal}'),
          Text('${(progress.completionPercentage * 100).round()}% complete'),
          const SizedBox(height: AppSpacing.sm),
          Text('Remaining: ${progress.remainingSteps} steps'),
          if (progress.estimatedCompletion != null)
            Text('ETA: ${DateFormat.jm().format(progress.estimatedCompletion!)}'),
        ],
      ),
    );
  }
}
