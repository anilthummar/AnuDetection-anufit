part of 'chart_bloc.dart';

sealed class ChartBlocState extends Equatable {
  const ChartBlocState();
  @override
  List<Object?> get props => [];
}

final class ChartBlocInitial extends ChartBlocState {
  const ChartBlocInitial();
}

final class ChartBlocLoading extends ChartBlocState {
  const ChartBlocLoading({required this.type});
  final ChartType type;
  @override
  List<Object?> get props => [type];
}

final class ChartBlocLoaded extends ChartBlocState {
  const ChartBlocLoaded({required this.chart});
  final ChartState chart;
  @override
  List<Object?> get props => [chart];
}

final class ChartBlocError extends ChartBlocState {
  const ChartBlocError(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
