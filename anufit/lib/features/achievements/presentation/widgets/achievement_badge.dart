import 'package:flutter/material.dart';

import 'package:anufit/app/theme/app_colors.dart';

class AchievementBadge extends StatelessWidget {
  const AchievementBadge({
    required this.completed,
    this.size = 32,
    super.key,
  });

  final bool completed;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.emoji_events,
      size: size,
      color: completed ? AppColors.warning : AppColors.border,
    );
  }
}
