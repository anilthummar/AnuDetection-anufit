import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:anufit/core/constants/app_spacing.dart';
import 'package:anufit/features/history/domain/entities/history_entity.dart';
import 'package:anufit/features/history/presentation/bloc/history_bloc.dart';
import 'package:anufit/features/history/presentation/widgets/history_calendar.dart';
import 'package:anufit/features/history/presentation/widgets/history_card.dart';
import 'package:anufit/features/history/presentation/widgets/history_filter.dart';
import 'package:anufit/features/history/presentation/widgets/history_list.dart';
import 'package:anufit/core/widgets/responsive_builder.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('History')),
      body: ResponsiveContainer(
        child: BlocBuilder<HistoryBloc, HistoryState>(
          builder: (context, state) {
            return switch (state) {
              HistoryInitial() || HistoryLoading() =>
                const Center(child: CircularProgressIndicator()),
              HistoryError(:final message) => Center(child: Text(message)),
              HistoryLoaded() => _HistoryBody(state: state),
            };
          },
        ),
      ),
    );
  }
}

class _HistoryBody extends StatelessWidget {
  const _HistoryBody({required this.state});

  final HistoryLoaded state;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<HistoryBloc>().add(HistoryLoadRequested(
              period: state.period,
              filter: state.filter,
              search: state.search,
            ));
      },
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SegmentedButton<HistoryPeriod>(
              segments: const [
                ButtonSegment(value: HistoryPeriod.daily, label: Text('Daily')),
                ButtonSegment(value: HistoryPeriod.weekly, label: Text('Weekly')),
                ButtonSegment(value: HistoryPeriod.monthly, label: Text('Month')),
                ButtonSegment(value: HistoryPeriod.yearly, label: Text('Year')),
              ],
              selected: {state.period},
              onSelectionChanged: (s) =>
                  context.read<HistoryBloc>().add(HistoryPeriodChanged(s.first)),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          if (state.period == HistoryPeriod.daily) ...[
            HistoryFilterBar(
              selected: state.filter,
              onChanged: (f, {customStart, customEnd}) => context
                  .read<HistoryBloc>()
                  .add(HistoryFilterChanged(
                    period: state.period,
                    filter: f,
                    customStart: customStart,
                    customEnd: customEnd,
                  )),
            ),
            const SizedBox(height: AppSpacing.md),
            HistoryCalendar(
              activeDates: state.activeDates,
              onDateSelected: (date) => context.read<HistoryBloc>().add(
                    HistorySearchChanged(HistorySearchQuery(date: date)),
                  ),
            ),
            const SizedBox(height: AppSpacing.lg),
            HistoryList(
              items: state.dailyItems,
              hasMore: state.hasMore,
              onLoadMore: () =>
                  context.read<HistoryBloc>().add(const HistoryLoadMoreRequested()),
            ),
          ] else ...[
            AggregatedHistoryCard(
              item: switch (state.period) {
                HistoryPeriod.weekly => state.weekly,
                HistoryPeriod.monthly => state.monthly,
                HistoryPeriod.yearly => state.yearly,
                HistoryPeriod.daily => state.weekly,
              },
            ),
          ],
        ],
      ),
    );
  }
}
