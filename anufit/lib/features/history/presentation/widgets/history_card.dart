import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:anufit/app/theme/app_colors.dart';
import 'package:anufit/core/constants/app_spacing.dart';
import 'package:anufit/features/history/domain/entities/history_entity.dart';
import 'package:anufit/shared/widgets/design_system.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({required this.item, super.key});

  final DailySummaryEntity item;

  @override
  Widget build(BuildContext context) {
    final dateLabel = DateFormat('d MMM').format(item.date);

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(dateLabel, style: Theme.of(context).textTheme.titleMedium),
              const Spacer(),
              if (item.goalCompleted)
                const Row(
                  children: [
                    Icon(Icons.check_circle, color: AppColors.success, size: 16),
                    SizedBox(width: 4),
                    Text('Goal Completed'),
                  ],
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text('${NumberFormat.decimalPattern().format(item.steps)} Steps'),
          Text('${item.distanceKm.toStringAsFixed(1)} km • ${item.calories.round()} kcal'),
          Text(_formatDuration(item.walkingTime)),
        ],
      ),
    );
  }

  String _formatDuration(Duration d) {
    if (d.inHours > 0) return '${d.inHours}h ${d.inMinutes.remainder(60)}m';
    return '${d.inMinutes}m';
  }
}

class AggregatedHistoryCard extends StatelessWidget {
  const AggregatedHistoryCard({required this.item, super.key});

  final AggregatedHistoryEntity item;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.label, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          Text('${NumberFormat.decimalPattern().format(item.steps)} Steps'),
          Text('${item.distanceKm.toStringAsFixed(1)} km • ${item.calories.round()} kcal'),
          Text(_formatDuration(item.walkingTime)),
        ],
      ),
    );
  }

  String _formatDuration(Duration d) {
    if (d.inHours > 0) return '${d.inHours}h ${d.inMinutes.remainder(60)}m';
    return '${d.inMinutes}m';
  }
}
