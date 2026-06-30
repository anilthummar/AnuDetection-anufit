part of 'chart_bloc.dart';

sealed class ChartEvent extends Equatable {
  const ChartEvent();
  @override
  List<Object?> get props => [];
}

final class ChartLoadRequested extends ChartEvent {
  const ChartLoadRequested({this.type = ChartType.weekly});
  final ChartType type;
  @override
  List<Object?> get props => [type];
}

final class ChartTypeChanged extends ChartEvent {
  const ChartTypeChanged(this.type);
  final ChartType type;
  @override
  List<Object?> get props => [type];
}
