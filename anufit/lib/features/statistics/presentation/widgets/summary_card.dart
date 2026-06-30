import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:anufit/core/constants/app_spacing.dart';
import 'package:anufit/core/enums/unit_system.dart';
import 'package:anufit/core/utils/unit_format.dart';
import 'package:anufit/features/history/domain/entities/history_entity.dart';
import 'package:anufit/shared/widgets/design_system.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({
    required this.lifetime,
    this.unit = UnitSystem.metric,
    super.key,
  });

  final LifetimeSummaryEntity lifetime;
  final UnitSystem unit;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Lifetime', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpacing.md),
          _row('Steps', NumberFormat.decimalPattern().format(lifetime.totalSteps)),
          _row(
            'Distance',
            UnitFormat.distanceLabel(lifetime.totalDistanceKm, unit, decimals: 1),
          ),
          _row('Calories', NumberFormat.decimalPattern().format(lifetime.totalCalories.round())),
          _row('Walking Time', _formatDuration(lifetime.totalWalkingTime)),
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

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    if (hours > 0) return '${hours}h ${minutes}m';
    if (minutes > 0) return '${minutes}m';
    if (duration.inSeconds > 0) return '${duration.inSeconds}s';
    return '0m';
  }
}
