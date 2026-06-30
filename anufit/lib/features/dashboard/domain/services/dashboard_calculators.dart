import 'package:anufit/features/dashboard/domain/entities/dashboard_summary.dart';

export 'package:anufit/core/entities/streak_info.dart';
export 'package:anufit/core/services/activity_metrics_calculator.dart';
export 'package:anufit/core/services/streak_calculator.dart';

abstract final class AchievementCalculator {
  static const List<({String id, String title, int threshold, String icon})> _definitions = [
    (id: 'steps_1k', title: '1,000 Steps', threshold: 1000, icon: 'directions_walk'),
    (id: 'steps_5k', title: '5,000 Steps', threshold: 5000, icon: 'hiking'),
    (id: 'steps_10k', title: '10,000 Steps', threshold: 10000, icon: 'emoji_events'),
    (id: 'marathon', title: 'Marathon Badge', threshold: 26200, icon: 'military_tech'),
  ];

  static List<Achievement> preview({
    required int todaySteps,
    required List<int> historicalDailySteps,
  }) {
    final maxSteps = [
      todaySteps,
      ...historicalDailySteps,
    ].fold<int>(0, (max, value) => value > max ? value : max);

    final unlocked = _definitions
        .map(
          (def) => Achievement(
            id: def.id,
            title: def.title,
            threshold: def.threshold,
            isUnlocked: maxSteps >= def.threshold,
            iconName: def.icon,
          ),
        )
        .where((a) => a.isUnlocked)
        .toList();

    if (unlocked.isEmpty) {
      return _definitions
          .take(2)
          .map(
            (def) => Achievement(
              id: def.id,
              title: def.title,
              threshold: def.threshold,
              isUnlocked: false,
              iconName: def.icon,
            ),
          )
          .toList();
    }

    return unlocked.take(4).toList();
  }
}

String greetingForHour(int hour) {
  if (hour < 12) return 'Good Morning';
  if (hour < 17) return 'Good Afternoon';
  return 'Good Evening';
}
