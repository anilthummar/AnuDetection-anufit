import 'package:anufit/features/achievements/domain/entities/achievement_entity.dart';

abstract class AchievementRepository {
  Future<List<AchievementEntity>> getAchievements();

  Future<List<AchievementEntity>> evaluateAndSync();

  Future<List<AchievementEntity>> getRecentlyUnlocked();

  Future<int> getTotalXp();

  Future<UserStats> buildUserStats();
}
