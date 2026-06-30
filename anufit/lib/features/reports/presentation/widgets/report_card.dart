import 'package:flutter/material.dart';

import 'package:anufit/core/constants/app_spacing.dart';
import 'package:anufit/features/reports/domain/entities/report_entity.dart';
import 'package:anufit/shared/widgets/design_system.dart';

class ReportCard extends StatelessWidget {
  const ReportCard({
    required this.period,
    required this.onTap,
    super.key,
  });

  final ReportPeriod period;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      child: Row(
        children: [
          const Icon(Icons.description_outlined),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              _label(period),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }

  String _label(ReportPeriod period) => switch (period) {
        ReportPeriod.daily => 'Daily Report',
        ReportPeriod.weekly => 'Weekly Report',
        ReportPeriod.monthly => 'Monthly Report',
        ReportPeriod.yearly => 'Yearly Report',
        ReportPeriod.custom => 'Custom Range Report',
      };
}
