import 'package:equatable/equatable.dart';

class WaterEntryEntity extends Equatable {
  const WaterEntryEntity({
    required this.id,
    required this.date,
    required this.time,
    required this.amountMl,
    this.source,
    this.note,
  });

  final int id;
  final DateTime date;
  final DateTime time;
  final int amountMl;
  final String? source;
  final String? note;

  @override
  List<Object?> get props => [id, date, time, amountMl, source, note];
}

class WaterDashboardEntity extends Equatable {
  const WaterDashboardEntity({
    required this.todayMl,
    required this.goalLiters,
    required this.history,
  });

  final int todayMl;
  final double goalLiters;
  final List<WaterEntryEntity> history;

  double get todayLiters => todayMl / 1000;
  double get progress => goalLiters <= 0 ? 0 : (todayLiters / goalLiters).clamp(0, 1);
  int get remainingMl => ((goalLiters * 1000) - todayMl).clamp(0, 999999).toInt();

  @override
  List<Object?> get props => [todayMl, goalLiters, history];
}
