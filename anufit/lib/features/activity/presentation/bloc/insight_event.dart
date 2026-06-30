part of 'insight_bloc.dart';

sealed class InsightEvent extends Equatable {
  const InsightEvent();
  @override
  List<Object?> get props => [];
}

final class InsightLoadRequested extends InsightEvent {
  const InsightLoadRequested();
}
