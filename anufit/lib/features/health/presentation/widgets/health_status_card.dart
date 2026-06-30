import 'package:flutter/material.dart';

import 'package:anufit/app/theme/app_colors.dart';
import 'package:anufit/core/constants/app_spacing.dart';
import 'package:anufit/features/health/domain/entities/health_entity.dart';
import 'package:anufit/shared/widgets/design_system.dart';

class HealthStatusCard extends StatelessWidget {
  const HealthStatusCard({
    required this.connected,
    required this.platform,
    super.key,
  });

  final bool connected;
  final HealthPlatform platform;

  @override
  Widget build(BuildContext context) {
    final label = switch (platform) {
      HealthPlatform.appleHealth => 'Apple Health',
      HealthPlatform.healthConnect => 'Health Connect',
      HealthPlatform.unavailable => 'Unavailable',
    };

    return AppCard(
      child: Row(
        children: [
          Icon(
            connected ? Icons.check_circle : Icons.link_off,
            color: connected ? AppColors.success : AppColors.border,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  connected ? 'Health Connected' : 'Health Not Connected',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(connected ? '✓ $label' : 'Tap Connect to enable $label'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
