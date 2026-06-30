import 'package:flutter/material.dart';

import 'package:anufit/core/constants/app_spacing.dart';
import 'package:anufit/features/achievements/domain/entities/achievement_entity.dart';
import 'package:anufit/features/achievements/presentation/widgets/achievement_badge.dart';

class AchievementDialog extends StatelessWidget {
  const AchievementDialog({required this.achievement, super.key});

  final AchievementEntity achievement;

  static Future<void> show(BuildContext context, AchievementEntity achievement) {
    return showDialog<void>(
      context: context,
      builder: (_) => AchievementDialog(achievement: achievement),
    );
  }

  @override
  Widget build(BuildContext context) {
    final completed = achievement.completed;

    return AlertDialog(
      title: Row(
        children: [
          AchievementBadge(completed: completed, size: 28),
          const SizedBox(width: AppSpacing.sm),
          Expanded(child: Text(achievement.title)),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            completed ? 'Unlocked' : 'In progress',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: AppSpacing.sm),
          LinearProgressIndicator(value: achievement.progress.clamp(0, 1)),
          const SizedBox(height: AppSpacing.sm),
          Text('${(achievement.progress * 100).round()}% complete'),
          if (completed) ...[
            const SizedBox(height: AppSpacing.sm),
            Text('Reward: +${achievement.xp} XP'),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }
}
