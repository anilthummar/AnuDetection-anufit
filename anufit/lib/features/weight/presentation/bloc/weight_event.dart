part of 'weight_bloc.dart';

sealed class WeightEvent extends Equatable {
  const WeightEvent();

  @override
  List<Object?> get props => [];
}

class WeightLoadRequested extends WeightEvent {
  const WeightLoadRequested();
}

class WeightLogRequested extends WeightEvent {
  const WeightLogRequested({required this.weightKg, this.note});

  final double weightKg;
  final String? note;

  @override
  List<Object?> get props => [weightKg, note];
}

class WeightGoalSetRequested extends WeightEvent {
  const WeightGoalSetRequested(this.goalKg);

  final double goalKg;

  @override
  List<Object?> get props => [goalKg];
}

class WeightChartPeriodChanged extends WeightEvent {
  const WeightChartPeriodChanged(this.period);

  final WeightChartPeriod period;

  @override
  List<Object?> get props => [period];
}
