import 'package:flutter/material.dart';

import 'package:anufit/core/constants/app_spacing.dart';
import 'package:anufit/features/achievements/domain/entities/achievement_entity.dart';
import 'package:anufit/features/achievements/presentation/widgets/achievement_card.dart';

class AchievementGrid extends StatelessWidget {
  const AchievementGrid({
    required this.achievements,
    required this.onTap,
    super.key,
  });

  final List<AchievementEntity> achievements;
  final ValueChanged<AchievementEntity> onTap;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: AppSpacing.md,
        crossAxisSpacing: AppSpacing.md,
        childAspectRatio: 1.1,
      ),
      itemCount: achievements.length,
      itemBuilder: (context, index) {
        final item = achievements[index];
        return GestureDetector(
          onTap: () => onTap(item),
          child: AchievementCard(achievement: item),
        );
      },
    );
  }
}
