part of 'insight_bloc.dart';

sealed class InsightState extends Equatable {
  const InsightState();
  @override
  List<Object?> get props => [];
}

final class InsightInitial extends InsightState {
  const InsightInitial();
}

final class InsightLoading extends InsightState {
  const InsightLoading();
}

final class InsightLoaded extends InsightState {
  const InsightLoaded({required this.insights});
  final List<ActivityInsight> insights;
  @override
  List<Object?> get props => [insights];
}

final class InsightError extends InsightState {
  const InsightError(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
