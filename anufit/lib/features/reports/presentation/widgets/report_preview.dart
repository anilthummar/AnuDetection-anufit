import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:anufit/core/constants/app_spacing.dart';
import 'package:anufit/features/reports/domain/entities/report_entity.dart';
import 'package:anufit/shared/widgets/design_system.dart';

class ReportPreview extends StatelessWidget {
  const ReportPreview({required this.data, super.key});

  final ReportData data;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(data.title, style: Theme.of(context).textTheme.titleLarge),
          Text(data.periodLabel),
          const Divider(),
          _row('Total Steps', NumberFormat.decimalPattern().format(data.totalSteps)),
          _row('Distance', '${data.distanceKm.toStringAsFixed(1)} km'),
          _row('Calories', '${data.calories.round()} kcal'),
          _row('Goal Completion', '${(data.goalCompletionRate * 100).round()}%'),
          _row('Best Day', data.bestDay),
          _row('Worst Day', data.worstDay),
          if (data.achievementsEarned.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            Text('Achievements', style: Theme.of(context).textTheme.titleSmall),
            for (final a in data.achievementsEarned) Text('• $a'),
          ],
        ],
      ),
    );
  }

  Widget _row(String label, String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(label), Text(value)],
        ),
      );
}
