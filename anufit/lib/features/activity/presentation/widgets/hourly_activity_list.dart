import 'package:flutter/material.dart';

import 'package:anufit/core/constants/app_spacing.dart';
import 'package:anufit/features/activity/domain/entities/timeline_entity.dart';
import 'package:anufit/features/activity/presentation/widgets/timeline_card.dart';
import 'package:anufit/shared/widgets/design_system.dart';

class HourlyActivityList extends StatelessWidget {
  const HourlyActivityList({required this.entries, super.key});

  final List<TimelineEntry> entries;

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return const AppCard(child: Text('No hourly activity yet.'));
    }

    return Column(
      children: entries
          .map(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: TimelineCard(entry: e),
            ),
          )
          .toList(),
    );
  }
}
