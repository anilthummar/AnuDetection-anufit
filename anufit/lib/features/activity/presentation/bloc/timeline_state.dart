part of 'timeline_bloc.dart';

sealed class TimelineState extends Equatable {
  const TimelineState();
  @override
  List<Object?> get props => [];
}

final class TimelineInitial extends TimelineState {
  const TimelineInitial();
}

final class TimelineLoading extends TimelineState {
  const TimelineLoading();
}

final class TimelineLoaded extends TimelineState {
  const TimelineLoaded({
    required this.summary,
    required this.filter,
    required this.weekly,
    required this.heatmap,
    this.customDate,
  });

  final TimelineSummary summary;
  final TimelineFilter filter;
  final List<StepPeriodSummary> weekly;
  final Map<DateTime, List<TimelineEntry>> heatmap;
  final DateTime? customDate;

  @override
  List<Object?> get props => [summary, filter, weekly, heatmap, customDate];
}

final class TimelineError extends TimelineState {
  const TimelineError(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
