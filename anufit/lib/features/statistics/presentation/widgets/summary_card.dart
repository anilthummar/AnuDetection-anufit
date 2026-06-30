import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:anufit/core/constants/app_spacing.dart';
import 'package:anufit/features/history/domain/entities/history_entity.dart';
import 'package:anufit/shared/widgets/design_system.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({required this.lifetime, super.key});

  final LifetimeSummaryEntity lifetime;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Lifetime', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpacing.md),
          _row('Steps', NumberFormat.decimalPattern().format(lifetime.totalSteps)),
          _row('Distance', '${lifetime.totalDistanceKm.toStringAsFixed(0)} km'),
          _row('Calories', NumberFormat.decimalPattern().format(lifetime.totalCalories.round())),
          _row('Walking Time', '${lifetime.totalWalkingTime.inHours} hours'),
          _row('Active Days', '${lifetime.activeDays}'),
        ],
      ),
    );
  }

  Widget _row(String label, String value) => Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.xs),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(label), Text(value, style: const TextStyle(fontWeight: FontWeight.w600))],
        ),
      );
}
