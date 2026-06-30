part of 'statistics_bloc.dart';

sealed class StatisticsState extends Equatable {
  const StatisticsState();
  @override
  List<Object?> get props => [];
}

final class StatisticsInitial extends StatisticsState {
  const StatisticsInitial();
}

final class StatisticsLoading extends StatisticsState {
  const StatisticsLoading();
}

final class StatisticsLoaded extends StatisticsState {
  const StatisticsLoaded({required this.bundle});
  final StatisticsBundle bundle;
  @override
  List<Object?> get props => [bundle];
}

final class StatisticsError extends StatisticsState {
  const StatisticsError(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
