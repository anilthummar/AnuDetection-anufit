import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:anufit/core/constants/app_spacing.dart';
import 'package:anufit/features/dashboard/domain/services/dashboard_calculators.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({
    required this.userName,
    super.key,
  });

  final String userName;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final greeting = greetingForHour(now.hour);
    final dateLabel = DateFormat('EEEE, MMMM d').format(now);

    return Semantics(
      header: true,
      label: '$greeting, $userName. $dateLabel',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            greeting,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '$userName 👋',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            dateLabel,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                ),
          ),
        ],
      ),
    );
  }
}
