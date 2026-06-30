import 'package:flutter/material.dart';

import 'package:anufit/app/theme/app_colors.dart';
import 'package:anufit/core/constants/app_spacing.dart';
import 'package:anufit/shared/widgets/design_system.dart';

class XpProgressBar extends StatelessWidget {
  const XpProgressBar({required this.totalXp, super.key});

  final int totalXp;

  @override
  Widget build(BuildContext context) {
    final level = (totalXp / 500).floor() + 1;
    final progress = (totalXp % 500) / 500;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Level $level', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          LinearProgressIndicator(
            value: progress,
            minHeight: 8,
            backgroundColor: AppColors.border,
            borderRadius: BorderRadius.circular(8),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text('$totalXp XP total'),
        ],
      ),
    );
  }
}
