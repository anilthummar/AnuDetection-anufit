import 'package:equatable/equatable.dart';

class StreakInfo extends Equatable {
  const StreakInfo({
    required this.currentStreak,
    required this.longestStreak,
    this.lastGoalCompletedDate,
  });

  final int currentStreak;
  final int longestStreak;
  final DateTime? lastGoalCompletedDate;

  @override
  List<Object?> get props => [currentStreak, longestStreak, lastGoalCompletedDate];
}
