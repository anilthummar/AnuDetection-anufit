import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:anufit/app/theme/app_colors.dart';
import 'package:anufit/core/constants/app_spacing.dart';
import 'package:anufit/features/step_counter/domain/entities/hourly_step_point.dart';
import 'package:anufit/shared/widgets/design_system.dart';

class HourlyActivityChart extends StatefulWidget {
  const HourlyActivityChart({
    required this.hourlySteps,
    required this.totalSteps,
    super.key,
  });

  final List<HourlyStepPoint> hourlySteps;
  final int totalSteps;

  @override
  State<HourlyActivityChart> createState() => _HourlyActivityChartState();
}

class _HourlyActivityChartState extends State<HourlyActivityChart>
    with AutomaticKeepAliveClientMixin {
  late List<double> _barData;
  late int _currentHour;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _barData = _buildBarData(widget.hourlySteps);
    _currentHour = DateTime.now().hour;
  }

  @override
  void didUpdateWidget(covariant HourlyActivityChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.hourlySteps != widget.hourlySteps) {
      _barData = _buildBarData(widget.hourlySteps);
      _currentHour = DateTime.now().hour;
    }
  }

  List<double> _buildBarData(List<HourlyStepPoint> hourlySteps) {
    return List.generate(24, (hour) {
      final match = hourlySteps.where((p) => p.hour == hour);
      return match.isEmpty ? 0.0 : match.first.steps.toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final maxY = _barData.fold<double>(0, (m, v) => v > m ? v : m);

    return RepaintBoundary(
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    'Hourly Activity',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                Text(
                  '${_formatSteps(widget.totalSteps)} total',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            SizedBox(
              height: 180,
              child: BarChart(
                BarChartData(
                  maxY: maxY > 0 ? maxY * 1.2 : 100,
                  barTouchData: BarTouchData(enabled: false),
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final hour = value.toInt();
                          if (hour % 4 != 0) return const SizedBox.shrink();
                          return Padding(
                            padding: const EdgeInsets.only(top: AppSpacing.xs),
                            child: Text(
                              '${hour}h',
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  barGroups: List.generate(24, (hour) {
                    final isCurrent = hour == _currentHour;
                    return BarChartGroupData(
                      x: hour,
                      barRods: [
                        BarChartRodData(
                          toY: _barData[hour],
                          width: 8,
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                          color: isCurrent ? AppColors.secondary : AppColors.primary,
                          gradient: isCurrent
                              ? const LinearGradient(
                                  colors: [AppColors.secondary, AppColors.primary],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                )
                              : null,
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatSteps(int value) => value.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (m) => '${m[1]},',
      );
}
