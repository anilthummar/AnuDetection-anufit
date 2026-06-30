part of 'statistics_bloc.dart';

sealed class StatisticsEvent extends Equatable {
  const StatisticsEvent();
  @override
  List<Object?> get props => [];
}

final class StatisticsLoadRequested extends StatisticsEvent {
  const StatisticsLoadRequested({this.period = StatisticsPeriod.weekly});
  final StatisticsPeriod period;
  @override
  List<Object?> get props => [period];
}

final class StatisticsPeriodChanged extends StatisticsEvent {
  const StatisticsPeriodChanged(this.period);
  final StatisticsPeriod period;
  @override
  List<Object?> get props => [period];
}
