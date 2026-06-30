import 'package:flutter/material.dart';

import 'package:anufit/core/constants/app_spacing.dart';
import 'package:anufit/features/activity/domain/entities/timeline_entity.dart';
import 'package:anufit/shared/widgets/design_system.dart';

class InsightCard extends StatelessWidget {
  const InsightCard({required this.insight, super.key});

  final ActivityInsight insight;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        children: [
          const Icon(Icons.insights_outlined),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(insight.title, style: Theme.of(context).textTheme.titleSmall),
                Text(insight.description),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
