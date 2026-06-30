import 'package:flutter/material.dart';

import 'package:anufit/core/constants/app_spacing.dart';
import 'package:anufit/features/achievements/domain/entities/achievement_entity.dart';
import 'package:anufit/features/achievements/presentation/widgets/achievement_badge.dart';
import 'package:anufit/shared/widgets/design_system.dart';

class AchievementCard extends StatelessWidget {
  const AchievementCard({required this.achievement, super.key});

  final AchievementEntity achievement;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AchievementBadge(completed: achievement.completed),
          const SizedBox(height: AppSpacing.sm),
          Text(
            achievement.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          Text(achievement.completed ? 'Unlocked' : '${(achievement.progress * 100).round()}%'),
          if (achievement.completed) Text('+${achievement.xp} XP'),
        ],
      ),
    );
  }
}
