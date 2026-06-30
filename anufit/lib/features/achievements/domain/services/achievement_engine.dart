import 'package:anufit/features/achievements/domain/entities/achievement_entity.dart';
import 'package:anufit/features/achievements/domain/rules/achievement_rules.dart';

class AchievementEvaluation {
  const AchievementEvaluation({
    required this.entity,
    required this.newlyUnlocked,
  });

  final AchievementEntity entity;
  final bool newlyUnlocked;
}

abstract final class AchievementEngine {
  static List<AchievementEvaluation> evaluate({
    required UserStats stats,
    required Map<String, AchievementEntity> stored,
  }) {
    return allAchievementRules().map((rule) {
      final unlocked = rule.isUnlocked(stats);
      final previous = stored[rule.id];
      final wasCompleted = previous?.completed ?? false;
      final entity = AchievementEntity(
        ruleId: rule.id,
        title: rule.title,
        category: rule.category,
        completed: unlocked,
        progress: rule.progress(stats),
        xp: rule.rewardXp(),
        completedAt: unlocked ? (previous?.completedAt ?? DateTime.now()) : null,
      );
      return AchievementEvaluation(
        entity: entity,
        newlyUnlocked: unlocked && !wasCompleted,
      );
    }).toList();
  }

  static int totalXp(List<AchievementEntity> achievements) {
    return achievements.where((a) => a.completed).fold<int>(0, (sum, a) => sum + a.xp);
  }
}
