part of 'water_bloc.dart';

sealed class WaterEvent extends Equatable {
  const WaterEvent();

  @override
  List<Object?> get props => [];
}

class WaterLoadRequested extends WaterEvent {
  const WaterLoadRequested();
}

class WaterAddRequested extends WaterEvent {
  const WaterAddRequested(this.amountMl);

  final int amountMl;

  @override
  List<Object?> get props => [amountMl];
}

class WaterGoalSetRequested extends WaterEvent {
  const WaterGoalSetRequested(this.liters);

  final double liters;

  @override
  List<Object?> get props => [liters];
}
