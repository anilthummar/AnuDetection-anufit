import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:anufit/core/constants/app_spacing.dart';
import 'package:anufit/features/activity/domain/entities/timeline_entity.dart';
import 'package:anufit/shared/widgets/design_system.dart';

class TimelineCard extends StatelessWidget {
  const TimelineCard({required this.entry, super.key});

  final TimelineEntry entry;

  @override
  Widget build(BuildContext context) {
    final time = DateFormat('HH:mm').format(
      DateTime(2026, 1, 1, entry.hour),
    );

    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        children: [
          SizedBox(
            width: 56,
            child: Text(time, style: Theme.of(context).textTheme.titleSmall),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${entry.steps} steps'),
                Text(
                  '${entry.distanceKm.toStringAsFixed(2)} km • ${entry.calories.round()} kcal',
                ),
                Text(_formatDuration(entry.walkingTime)),
              ],
            ),
          ),
          if (entry.goalReached)
            const Icon(Icons.check_circle, color: Colors.green, size: 18),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    if (duration.inHours > 0) {
      return '${duration.inHours}h ${duration.inMinutes.remainder(60)}m';
    }
    return '${duration.inMinutes}m';
  }
}
