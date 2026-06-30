part of 'history_bloc.dart';

sealed class HistoryState extends Equatable {
  const HistoryState();
  @override
  List<Object?> get props => [];
}

final class HistoryInitial extends HistoryState {
  const HistoryInitial();
}

final class HistoryLoading extends HistoryState {
  const HistoryLoading();
}

final class HistoryLoaded extends HistoryState {
  const HistoryLoaded({
    required this.period,
    required this.filter,
    required this.dailyItems,
    required this.hasMore,
    required this.page,
    required this.weekly,
    required this.monthly,
    required this.yearly,
    required this.activeDates,
    this.search,
  });

  final HistoryPeriod period;
  final HistoryFilter filter;
  final List<DailySummaryEntity> dailyItems;
  final bool hasMore;
  final int page;
  final AggregatedHistoryEntity weekly;
  final AggregatedHistoryEntity monthly;
  final AggregatedHistoryEntity yearly;
  final List<DateTime> activeDates;
  final HistorySearchQuery? search;

  HistoryLoaded copyWith({
    HistoryPeriod? period,
    HistoryFilter? filter,
    List<DailySummaryEntity>? dailyItems,
    bool? hasMore,
    int? page,
    AggregatedHistoryEntity? weekly,
    AggregatedHistoryEntity? monthly,
    AggregatedHistoryEntity? yearly,
    List<DateTime>? activeDates,
    HistorySearchQuery? search,
  }) {
    return HistoryLoaded(
      period: period ?? this.period,
      filter: filter ?? this.filter,
      dailyItems: dailyItems ?? this.dailyItems,
      hasMore: hasMore ?? this.hasMore,
      page: page ?? this.page,
      weekly: weekly ?? this.weekly,
      monthly: monthly ?? this.monthly,
      yearly: yearly ?? this.yearly,
      activeDates: activeDates ?? this.activeDates,
      search: search ?? this.search,
    );
  }

  @override
  List<Object?> get props =>
      [period, filter, dailyItems, hasMore, page, weekly, monthly, yearly, activeDates, search];
}

final class HistoryError extends HistoryState {
  const HistoryError(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
