import 'package:anufit/core/utils/unit_format.dart';
import 'package:anufit/shared/widgets/design_system.dart';
import 'package:flutter/material.dart';

class WaterProgress extends StatelessWidget {
  const WaterProgress({
    required this.todayMl,
    required this.goalLiters,
    super.key,
  });

  final int todayMl;
  final double goalLiters;

  @override
  Widget build(BuildContext context) {
    final progress = goalLiters <= 0 ? 0.0 : (todayMl / 1000 / goalLiters).clamp(0.0, 1.0);
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Today's Intake", style: Theme.of(context).textTheme.labelLarge),
          Text(
            '${UnitFormat.waterLiters(todayMl / 1000)} / ${UnitFormat.waterLiters(goalLiters)}',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(value: progress, minHeight: 10, borderRadius: BorderRadius.circular(8)),
          const SizedBox(height: 8),
          Text(
            '${(progress * 100).round()}% · ${UnitFormat.waterMl(((goalLiters * 1000) - todayMl).clamp(0, 999999).toInt())} remaining',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class WaterQuickAdd extends StatelessWidget {
  const WaterQuickAdd({required this.onAdd, super.key});

  final ValueChanged<int> onAdd;

  static const _amounts = [250, 500, 750, 1000];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _amounts
          .map(
            (ml) => ActionChip(
              label: Text(UnitFormat.waterMl(ml)),
              onPressed: () => onAdd(ml),
            ),
          )
          .toList(),
    );
  }
}

class WaterHistoryList extends StatelessWidget {
  const WaterHistoryList({required this.entries, super.key});

  final List<({DateTime time, int amountMl})> entries;

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) return const Text('No water logged today.');
    return Column(
      children: entries
          .map(
            (e) => ListTile(
              leading: const Icon(Icons.water_drop_outlined),
              title: Text(UnitFormat.waterMl(e.amountMl)),
              subtitle: Text(
                '${e.time.hour.toString().padLeft(2, '0')}:${e.time.minute.toString().padLeft(2, '0')}',
              ),
            ),
          )
          .toList(),
    );
  }
}
