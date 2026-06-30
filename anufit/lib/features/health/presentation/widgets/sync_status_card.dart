import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:anufit/core/constants/app_spacing.dart';
import 'package:anufit/features/health/domain/entities/health_entity.dart';
import 'package:anufit/shared/widgets/design_system.dart';

class SyncStatusCard extends StatelessWidget {
  const SyncStatusCard({required this.status, super.key});

  final HealthSyncStateEntity status;

  @override
  Widget build(BuildContext context) {
    final lastSync = status.lastSync != null
        ? DateFormat('Today HH:mm').format(status.lastSync!)
        : 'Never';

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Last Sync', style: Theme.of(context).textTheme.titleSmall),
          Text(lastSync, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          _row('Status', status.status.name),
          _row('Records Synced', '${status.recordsSynced}'),
          _row('Next Sync', 'Automatic'),
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
