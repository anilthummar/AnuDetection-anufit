import 'package:flutter/material.dart';

import 'package:anufit/app/theme/app_colors.dart';
import 'package:anufit/core/constants/app_animations.dart';
import 'package:anufit/core/constants/app_spacing.dart';
import 'package:anufit/features/dashboard/domain/entities/dashboard_summary.dart';
import 'package:anufit/shared/widgets/design_system.dart';

class AchievementPreview extends StatelessWidget {
  const AchievementPreview({
    required this.achievements,
    super.key,
  });

  final List<Achievement> achievements;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Achievements',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: AppSpacing.lg),
          SizedBox(
            height: 96,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: achievements.length,
              separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.md),
              itemBuilder: (context, index) {
                final item = achievements[index];
                return AnimatedOpacity(
                  duration: AppAnimations.normal,
                  opacity: item.isUnlocked ? 1 : 0.45,
                  child: _AchievementChip(achievement: item),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _AchievementChip extends StatelessWidget {
  const _AchievementChip({required this.achievement});

  final Achievement achievement;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: achievement.isUnlocked
            ? AppColors.success.withValues(alpha: 0.12)
            : Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: achievement.isUnlocked ? AppColors.success : AppColors.border,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _iconFor(achievement.iconName),
            color: achievement.isUnlocked ? AppColors.success : AppColors.border,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            achievement.title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }

  IconData _iconFor(String? name) {
    return switch (name) {
      'hiking' => Icons.hiking,
      'emoji_events' => Icons.emoji_events,
      'military_tech' => Icons.military_tech,
      _ => Icons.directions_walk,
    };
  }
}
