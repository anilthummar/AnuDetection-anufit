import 'package:equatable/equatable.dart';

/// Steps recorded for a single hour of the current day.
class HourlyStepPoint extends Equatable {
  const HourlyStepPoint({
    required this.hour,
    required this.steps,
  });

  final int hour;
  final int steps;

  @override
  List<Object?> get props => [hour, steps];
}
