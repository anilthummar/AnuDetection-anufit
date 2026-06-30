import 'package:flutter/material.dart';

import 'package:anufit/app/theme/app_colors.dart';
import 'package:anufit/core/constants/app_animations.dart';
import 'package:anufit/core/constants/app_spacing.dart';
import 'package:anufit/shared/widgets/design_system.dart';

class MetricCard extends StatelessWidget {
  const MetricCard({
    required this.label,
    required this.value,
    required this.icon,
    this.unit,
    super.key,
  });

  final String label;
  final String value;
  final IconData icon;
  final String? unit;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Semantics(
        label: '$label: $value${unit ?? ''}',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppColors.primary, size: 22),
            const SizedBox(height: AppSpacing.md),
            AnimatedSwitcher(
              duration: AppAnimations.normal,
              child: Text(
                value,
                key: ValueKey<String>(value),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
            if (unit != null) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(unit!, style: Theme.of(context).textTheme.bodySmall),
            ],
            const SizedBox(height: AppSpacing.xs),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
