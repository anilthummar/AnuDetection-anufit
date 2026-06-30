import 'package:flutter/material.dart';

import 'package:anufit/core/constants/app_spacing.dart';
import 'package:anufit/features/statistics/domain/entities/statistics_entity.dart';

class StatisticsHeader extends StatelessWidget {
  const StatisticsHeader({required this.period, super.key});

  final StatisticsPeriod period;

  @override
  Widget build(BuildContext context) {
    return Text(
      switch (period) {
        StatisticsPeriod.daily => 'Daily Statistics',
        StatisticsPeriod.weekly => 'Weekly Statistics',
        StatisticsPeriod.monthly => 'Monthly Statistics',
        StatisticsPeriod.yearly => 'Yearly Statistics',
        StatisticsPeriod.lifetime => 'Lifetime Statistics',
      },
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }
}
