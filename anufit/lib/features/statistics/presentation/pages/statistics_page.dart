import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'package:anufit/app/router/app_routes.dart';

import 'package:anufit/core/constants/app_spacing.dart';
import 'package:anufit/core/widgets/responsive_builder.dart';
import 'package:anufit/core/utils/unit_format.dart';
import 'package:anufit/features/statistics/domain/entities/statistics_entity.dart';
import 'package:anufit/features/statistics/presentation/bloc/chart_bloc.dart';
import 'package:anufit/features/statistics/presentation/bloc/statistics_bloc.dart';
import 'package:anufit/features/statistics/presentation/widgets/charts/daily_chart.dart';
import 'package:anufit/features/statistics/presentation/widgets/heatmap.dart';
import 'package:anufit/features/statistics/presentation/widgets/metric_tile.dart';
import 'package:anufit/features/statistics/presentation/widgets/statistics_header.dart';
import 'package:anufit/features/statistics/presentation/widgets/summary_card.dart';
import 'package:anufit/features/statistics/presentation/widgets/trend_card.dart';
import 'package:anufit/shared/widgets/fit_segmented_control.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
        actions: [
          IconButton(
            tooltip: 'Reports',
            onPressed: () => context.push(AppRoutes.reports),
            icon: const Icon(Icons.description_outlined),
          ),
        ],
      ),
      body: ResponsiveContainer(
        child: BlocBuilder<StatisticsBloc, StatisticsState>(
          builder: (context, state) {
            return switch (state) {
              StatisticsInitial() || StatisticsLoading() =>
                const Center(child: CircularProgressIndicator()),
              StatisticsError(:final message) => Center(child: Text(message)),
              StatisticsLoaded(:final bundle) => RefreshIndicator(
                  onRefresh: () async {
                    context.read<StatisticsBloc>().add(
                          StatisticsLoadRequested(period: bundle.period),
                        );
                  },
                  child: ListView(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    children: [
                      StatisticsHeader(period: bundle.period),
                      const SizedBox(height: AppSpacing.md),
                      FitSegmentedControl<StatisticsPeriod>(
                        selected: bundle.period,
                        onChanged: (period) => context
                            .read<StatisticsBloc>()
                            .add(StatisticsPeriodChanged(period)),
                        segments: const [
                          (value: StatisticsPeriod.daily, label: 'Day'),
                          (value: StatisticsPeriod.weekly, label: 'Week'),
                          (value: StatisticsPeriod.monthly, label: 'Month'),
                          (value: StatisticsPeriod.lifetime, label: 'Life'),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      SummaryCard(lifetime: bundle.lifetime, unit: bundle.unit),
                      const SizedBox(height: AppSpacing.lg),
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: AppSpacing.sm,
                        crossAxisSpacing: AppSpacing.sm,
                        childAspectRatio: 1.35,
                        children: [
                          MetricTile(
                            label: 'Steps',
                            value: NumberFormat.decimalPattern().format(bundle.metrics.steps),
                            icon: Icons.directions_walk,
                          ),
                          MetricTile(
                            label: 'Distance',
                            value: UnitFormat.distanceLabel(bundle.metrics.distanceKm, bundle.unit, decimals: 1),
                            icon: Icons.straighten,
                          ),
                          MetricTile(
                            label: 'Calories',
                            value: '${bundle.metrics.calories.round()}',
                            icon: Icons.local_fire_department,
                          ),
                          MetricTile(
                            label: 'Walking Time',
                            value: '${bundle.metrics.walkingTime.inHours}h ${bundle.metrics.walkingTime.inMinutes.remainder(60)}m',
                            icon: Icons.timer,
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      _ChartsSection(bundle: bundle),
                      const SizedBox(height: AppSpacing.lg),
                      StatisticsHeatmap(data: bundle.heatmap),
                      const SizedBox(height: AppSpacing.lg),
                      Text('Insights', style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: AppSpacing.sm),
                      for (final insight in bundle.insights)
                        Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                          child: TrendCard(insight: insight),
                        ),
                    ],
                  ),
                ),
            };
          },
        ),
      ),
    );
  }
}

class _ChartsSection extends StatelessWidget {
  const _ChartsSection({required this.bundle});
  final StatisticsBundle bundle;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChartBloc, ChartBlocState>(
      builder: (context, chartState) {
        final type = chartState is ChartBlocLoaded
            ? chartState.chart.type
            : ChartType.weekly;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FitSegmentedControl<ChartType>(
              selected: type,
              onChanged: (chartType) =>
                  context.read<ChartBloc>().add(ChartTypeChanged(chartType)),
              segments: const [
                (value: ChartType.daily, label: 'Day'),
                (value: ChartType.weekly, label: 'Week'),
                (value: ChartType.monthly, label: 'Month'),
                (value: ChartType.yearly, label: 'Year'),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            switch (type) {
              ChartType.daily => DailyChart(
                  points: bundle.hourlyPoints
                      .map((h) => ChartDataPoint(label: '${h.hour}', value: h.steps.toDouble()))
                      .toList(),
                ),
              ChartType.weekly => WeeklyChart(points: bundle.weeklyBars),
              ChartType.monthly => MonthlyChart(points: bundle.monthlyLine),
              ChartType.yearly => YearlyChart(points: bundle.yearlyBars),
            },
          ],
        );
      },
    );
  }
}
