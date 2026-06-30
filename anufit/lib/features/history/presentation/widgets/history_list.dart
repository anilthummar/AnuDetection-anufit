import 'package:flutter/material.dart';

import 'package:anufit/core/constants/app_spacing.dart';
import 'package:anufit/features/history/domain/entities/history_entity.dart';
import 'package:anufit/features/history/presentation/widgets/history_card.dart';

class HistoryList extends StatelessWidget {
  const HistoryList({
    required this.items,
    required this.hasMore,
    required this.onLoadMore,
    super.key,
  });

  final List<DailySummaryEntity> items;
  final bool hasMore;
  final VoidCallback onLoadMore;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Center(child: Text('No history for this period.'));
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length + (hasMore ? 1 : 0),
      separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
      itemBuilder: (context, index) {
        if (index >= items.length) {
          return TextButton(onPressed: onLoadMore, child: const Text('Load more'));
        }
        return HistoryCard(item: items[index]);
      },
    );
  }
}
