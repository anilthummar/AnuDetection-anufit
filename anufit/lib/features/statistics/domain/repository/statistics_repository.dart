import 'package:anufit/features/statistics/domain/entities/statistics_entity.dart';

abstract class StatisticsRepository {
  Future<StatisticsBundle> getStatistics({StatisticsPeriod period = StatisticsPeriod.weekly});

  Future<ChartState> getChartData(ChartType type);
}
