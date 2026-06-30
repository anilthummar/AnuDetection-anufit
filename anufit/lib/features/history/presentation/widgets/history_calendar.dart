import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:anufit/app/theme/app_colors.dart';
import 'package:anufit/core/constants/app_spacing.dart';
import 'package:anufit/shared/widgets/design_system.dart';

class HistoryCalendar extends StatelessWidget {
  const HistoryCalendar({
    required this.activeDates,
    required this.onDateSelected,
    super.key,
  });

  final List<DateTime> activeDates;
  final ValueChanged<DateTime> onDateSelected;

  @override
  Widget build(BuildContext context) {
    final sorted = [...activeDates]..sort((a, b) => b.compareTo(a));

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Active Days', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: AppSpacing.sm),
          if (sorted.isEmpty)
            const Text('No active days in this period.')
          else
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: sorted.take(20).map((date) {
                return ActionChip(
                  label: Text(DateFormat('d MMM').format(date)),
                  backgroundColor: AppColors.primary.withValues(alpha: 0.12),
                  onPressed: () => onDateSelected(date),
                );
              }).toList(),
            ),
          const SizedBox(height: AppSpacing.sm),
          TextButton.icon(
            onPressed: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2020),
                lastDate: DateTime.now(),
              );
              if (picked != null) onDateSelected(picked);
            },
            icon: const Icon(Icons.calendar_month),
            label: const Text('Pick a date'),
          ),
        ],
      ),
    );
  }
}
