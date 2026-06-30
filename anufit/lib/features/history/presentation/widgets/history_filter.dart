import 'package:flutter/material.dart';

import 'package:anufit/core/constants/app_spacing.dart';
import 'package:anufit/features/history/domain/entities/history_entity.dart';

typedef HistoryFilterCallback = void Function(
  HistoryFilter filter, {
  DateTime? customStart,
  DateTime? customEnd,
});

class HistoryFilterBar extends StatelessWidget {
  const HistoryFilterBar({
    required this.selected,
    required this.onChanged,
    super.key,
  });

  final HistoryFilter selected;
  final HistoryFilterCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: HistoryFilter.values.map((filter) {
          return Padding(
            padding: const EdgeInsets.only(right: AppSpacing.sm),
            child: FilterChip(
              label: Text(_label(filter)),
              selected: selected == filter,
              onSelected: (_) async {
                if (filter == HistoryFilter.custom) {
                  final range = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now(),
                  );
                  if (range != null) {
                    onChanged(filter, customStart: range.start, customEnd: range.end);
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

  String _label(HistoryFilter filter) => switch (filter) {
        HistoryFilter.today => 'Today',
        HistoryFilter.yesterday => 'Yesterday',
        HistoryFilter.last7Days => 'Last 7 Days',
        HistoryFilter.last30Days => 'Last 30 Days',
        HistoryFilter.thisMonth => 'This Month',
        HistoryFilter.thisYear => 'This Year',
        HistoryFilter.custom => 'Custom',
      };
}
