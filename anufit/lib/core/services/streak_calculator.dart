import 'package:anufit/core/entities/streak_info.dart';

abstract final class StreakCalculator {
  static StreakInfo calculate({
    required List<({DateTime date, int steps})> dailyRecords,
    required int goal,
    required DateTime today,
  }) {
    if (dailyRecords.isEmpty) {
      return const StreakInfo(currentStreak: 0, longestStreak: 0);
    }

    final sorted = List.of(dailyRecords)
      ..sort((a, b) => b.date.compareTo(a.date));

    var longest = 0;
    var run = 0;

    for (final record in sorted) {
      if (record.steps >= goal) {
        run++;
      } else {
        longest = longest > run ? longest : run;
        run = 0;
      }
    }
    longest = longest > run ? longest : run;

    final current = _consecutiveStreakFromToday(sorted, goal, today);
    final lastGoalDate = _lastGoalDate(sorted, goal);

    return StreakInfo(
      currentStreak: current,
      longestStreak: longest,
      lastGoalCompletedDate: lastGoalDate,
    );
  }

  static DateTime? _lastGoalDate(
    List<({DateTime date, int steps})> sorted,
    int goal,
  ) {
    for (final record in sorted) {
      if (record.steps >= goal) return record.date;
    }
    return null;
  }

  static int _consecutiveStreakFromToday(
    List<({DateTime date, int steps})> sorted,
    int goal,
    DateTime today,
  ) {
    final todayDate = DateTime(today.year, today.month, today.day);
    var streak = 0;
    var checkDate = todayDate;
    final map = {for (final r in sorted) _dateKey(r.date): r.steps};

    final todaySteps = map[_dateKey(todayDate)] ?? 0;
    if (todaySteps < goal) {
      checkDate = todayDate.subtract(const Duration(days: 1));
    }

    while (true) {
      final steps = map[_dateKey(checkDate)];
      if (steps == null || steps < goal) break;
      streak++;
      checkDate = checkDate.subtract(const Duration(days: 1));
    }
    return streak;
  }

  static String _dateKey(DateTime date) =>
      '${date.year}-${date.month}-${date.day}';
}
