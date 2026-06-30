part of 'timeline_bloc.dart';

sealed class TimelineEvent extends Equatable {
  const TimelineEvent();
  @override
  List<Object?> get props => [];
}

final class TimelineLoadRequested extends TimelineEvent {
  const TimelineLoadRequested({
    this.filter = TimelineFilter.today,
    this.customDate,
  });
  final TimelineFilter filter;
  final DateTime? customDate;
  @override
  List<Object?> get props => [filter, customDate];
}

final class TimelineFilterChanged extends TimelineEvent {
  const TimelineFilterChanged({required this.filter, this.customDate});
  final TimelineFilter filter;
  final DateTime? customDate;
  @override
  List<Object?> get props => [filter, customDate];
}
