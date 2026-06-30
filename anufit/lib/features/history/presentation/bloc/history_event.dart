part of 'history_bloc.dart';

sealed class HistoryEvent extends Equatable {
  const HistoryEvent();
  @override
  List<Object?> get props => [];
}

final class HistoryLoadRequested extends HistoryEvent {
  const HistoryLoadRequested({
    this.period = HistoryPeriod.daily,
    this.filter = HistoryFilter.last30Days,
    this.customStart,
    this.customEnd,
    this.search,
  });
  final HistoryPeriod period;
  final HistoryFilter filter;
  final DateTime? customStart;
  final DateTime? customEnd;
  final HistorySearchQuery? search;
  @override
  List<Object?> get props => [period, filter, customStart, customEnd, search];
}

final class HistoryFilterChanged extends HistoryEvent {
  const HistoryFilterChanged({
    required this.period,
    required this.filter,
    this.customStart,
    this.customEnd,
    this.search,
  });
  final HistoryPeriod period;
  final HistoryFilter filter;
  final DateTime? customStart;
  final DateTime? customEnd;
  final HistorySearchQuery? search;
  @override
  List<Object?> get props => [period, filter, customStart, customEnd, search];
}

final class HistorySearchChanged extends HistoryEvent {
  const HistorySearchChanged(this.search);
  final HistorySearchQuery? search;
  @override
  List<Object?> get props => [search];
}

final class HistoryLoadMoreRequested extends HistoryEvent {
  const HistoryLoadMoreRequested();
}

final class HistoryPeriodChanged extends HistoryEvent {
  const HistoryPeriodChanged(this.period);
  final HistoryPeriod period;
  @override
  List<Object?> get props => [period];
}
