import 'package:flutter/material.dart';

import 'package:anufit/core/constants/app_spacing.dart';
import 'package:anufit/features/activity/domain/entities/timeline_entity.dart';

typedef TimelineFilterCallback = void Function(TimelineFilter filter, {DateTime? customDate});

class ActivityFilter extends StatelessWidget {
  const ActivityFilter({
    required this.selected,
    required this.onChanged,
    super.key,
  });

  final TimelineFilter selected;
  final TimelineFilterCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: TimelineFilter.values.map((filter) {
          return Padding(
            padding: const EdgeInsets.only(right: AppSpacing.sm),
            child: FilterChip(
              label: Text(_label(filter)),
              selected: selected == filter,
              onSelected: (_) async {
                if (filter == TimelineFilter.custom) {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    onChanged(filter, customDate: picked);
                  }
                  return;
                }
                onChanged(filter);
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  String _label(TimelineFilter filter) => switch (filter) {
        TimelineFilter.today => 'Today',
        TimelineFilter.yesterday => 'Yesterday',
        TimelineFilter.thisWeek => 'This Week',
        TimelineFilter.thisMonth => 'This Month',
        TimelineFilter.custom => 'Custom',
      };
}
