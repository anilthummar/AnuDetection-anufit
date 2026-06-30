import 'package:flutter/material.dart';

import 'package:anufit/core/constants/app_spacing.dart';
import 'package:anufit/features/statistics/domain/entities/statistics_entity.dart';
import 'package:anufit/shared/widgets/design_system.dart';

class TrendCard extends StatelessWidget {
  const TrendCard({required this.insight, super.key});

  final StatisticsInsight insight;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        children: [
          Icon(_iconFor(insight.iconName)),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(insight.title, style: Theme.of(context).textTheme.labelLarge),
                Text(insight.value, style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _iconFor(String name) => switch (name) {
        'trending_up' => Icons.trending_up,
        'directions_walk' => Icons.directions_walk,
        'flag' => Icons.flag,
        'straighten' => Icons.straighten,
        'emoji_events' => Icons.emoji_events,
        'show_chart' => Icons.show_chart,
        _ => Icons.insights,
      };
}
