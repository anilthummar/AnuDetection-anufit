import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:anufit/core/constants/app_spacing.dart';
import 'package:anufit/core/di/injection.dart';
import 'package:anufit/core/widgets/responsive_builder.dart';
import 'package:anufit/features/activity/presentation/bloc/insight_bloc.dart';
import 'package:anufit/features/activity/presentation/bloc/timeline_bloc.dart';
import 'package:anufit/features/activity/presentation/widgets/activity_filter.dart';
import 'package:anufit/features/activity/presentation/widgets/activity_heatmap.dart';
import 'package:anufit/features/activity/presentation/widgets/hourly_activity_list.dart';
import 'package:anufit/features/activity/presentation/widgets/insight_card.dart';
import 'package:anufit/features/activity/presentation/widgets/timeline_chart.dart';
import 'package:anufit/features/activity/presentation/widgets/weekly_summary.dart';
import 'package:anufit/features/goals/domain/repository/goal_repository.dart';

class TimelinePage extends StatelessWidget {
  const TimelinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Activity Timeline')),
      body: ResponsiveContainer(
        child: BlocBuilder<TimelineBloc, TimelineState>(
          builder: (context, state) {
            return switch (state) {
              TimelineInitial() || TimelineLoading() =>
                const Center(child: CircularProgressIndicator()),
              TimelineError(:final message) => Center(child: Text(message)),
              TimelineLoaded(:final summary, :final filter, :final weekly, :final heatmap) =>
                RefreshIndicator(
                  onRefresh: () async {
                    context.read<TimelineBloc>().add(TimelineLoadRequested(filter: filter));
                    context.read<InsightBloc>().add(const InsightLoadRequested());
                  },
                  child: FutureBuilder(
                    future: getIt<GoalRepository>().getGoal(),
                    builder: (context, snapshot) {
                      final goal = snapshot.data?.stepGoal ?? 10000;
                      return ListView(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        children: [
                          ActivityFilter(
                            selected: filter,
                            onChanged: (f, {customDate}) => context.read<TimelineBloc>().add(
                                  TimelineFilterChanged(filter: f, customDate: customDate),
                                ),
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          TimelineChart(summary: summary),
                          const SizedBox(height: AppSpacing.lg),
                          WeeklySummary(weekly: weekly, goal: goal),
                          const SizedBox(height: AppSpacing.lg),
                          ActivityHeatmap(dailySummaries: heatmap),
                          const SizedBox(height: AppSpacing.lg),
                          HourlyActivityList(entries: summary.entries),
                          const SizedBox(height: AppSpacing.lg),
                          BlocBuilder<InsightBloc, InsightState>(
                            builder: (context, insightState) {
                              if (insightState is! InsightLoaded) {
                                return const SizedBox.shrink();
                              }
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Insights', style: Theme.of(context).textTheme.titleMedium),
                                  const SizedBox(height: AppSpacing.md),
                                  for (final insight in insightState.insights)
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                                      child: InsightCard(insight: insight),
                                    ),
                                ],
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
            };
          },
        ),
      ),
    );
  }
}
