import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:anufit/app/theme/app_colors.dart';
import 'package:anufit/core/constants/app_spacing.dart';
import 'package:anufit/features/statistics/domain/entities/statistics_entity.dart';
import 'package:anufit/shared/widgets/design_system.dart';

class DailyChart extends StatelessWidget {
  const DailyChart({required this.points, super.key});
  final List<ChartDataPoint> points;

  @override
  Widget build(BuildContext context) => _LineChart(title: 'Hourly Steps', points: points);
}

class WeeklyChart extends StatelessWidget {
  const WeeklyChart({required this.points, super.key});
  final List<ChartDataPoint> points;

  @override
  Widget build(BuildContext context) => _BarChart(title: 'Weekly Steps', points: points);
}

class MonthlyChart extends StatelessWidget {
  const MonthlyChart({required this.points, super.key});
  final List<ChartDataPoint> points;

  @override
  Widget build(BuildContext context) => _LineChart(title: 'Daily Steps', points: points);
}

class YearlyChart extends StatelessWidget {
  const YearlyChart({required this.points, super.key});
  final List<ChartDataPoint> points;

  @override
  Widget build(BuildContext context) => _BarChart(title: 'Monthly Steps', points: points);
}

class _BarChart extends StatelessWidget {
  const _BarChart({required this.title, required this.points});
  final String title;
  final List<ChartDataPoint> points;

  @override
  Widget build(BuildContext context) {
    final maxY = points.fold<double>(0, (m, p) => p.value > m ? p.value : m);
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpacing.lg),
          SizedBox(
            height: 160,
            child: BarChart(
              BarChartData(
                maxY: maxY > 0 ? maxY * 1.2 : 100,
                borderData: FlBorderData(show: false),
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(
                  leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                barGroups: [
                  for (var i = 0; i < points.length; i++)
                    BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(
                          toY: points[i].value,
                          color: AppColors.primary,
                          width: 12,
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LineChart extends StatelessWidget {
  const _LineChart({required this.title, required this.points});
  final String title;
  final List<ChartDataPoint> points;

  @override
  Widget build(BuildContext context) {
    if (points.isEmpty) return AppCard(child: Text(title));
    final maxY = points.fold<double>(0, (m, p) => p.value > m ? p.value : m);
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpacing.lg),
          SizedBox(
            height: 160,
            child: LineChart(
              LineChartData(
                maxY: maxY > 0 ? maxY * 1.2 : 100,
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(
                  leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      for (var i = 0; i < points.length; i++)
                        FlSpot(i.toDouble(), points[i].value),
                    ],
                    isCurved: true,
                    color: AppColors.secondary,
                    barWidth: 3,
                    dotData: const FlDotData(show: false),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
