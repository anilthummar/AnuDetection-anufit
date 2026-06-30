import 'package:injectable/injectable.dart';
import 'package:isar_community/isar.dart';

import 'package:anufit/core/database/isar_service.dart';
import 'package:anufit/features/achievements/data/models/achievement_model.dart';
import 'package:anufit/features/achievements/domain/entities/achievement_entity.dart';

@lazySingleton
class AchievementLocalDatasource {
  AchievementLocalDatasource(this._isarService);

  final IsarService _isarService;

  Future<List<AchievementEntity>> getAll() async {
    final models = await _isarService.db.achievementModels.where().findAll();
    return models.map(_toEntity).toList();
  }

  Future<void> saveAll(List<AchievementEntity> achievements) async {
    await _isarService.db.writeTxn(() async {
      for (final entity in achievements) {
        final existing = await _isarService.db.achievementModels
            .filter()
            .ruleIdEqualTo(entity.ruleId)
            .findFirst();
        final model = existing ?? AchievementModel()..ruleId = entity.ruleId;
        model
          ..title = entity.title
          ..category = entity.category.name
          ..completed = entity.completed
          ..completedAt = entity.completedAt
          ..progress = entity.progress
          ..xp = entity.xp;
        await _isarService.db.achievementModels.put(model);
      }
    });
  }

  AchievementEntity _toEntity(AchievementModel model) {
    return AchievementEntity(
      ruleId: model.ruleId,
      title: model.title,
      category: AchievementCategory.values.firstWhere(
        (c) => c.name == model.category,
        orElse: () => AchievementCategory.steps,
      ),
      completed: model.completed,
      progress: model.progress,
      xp: model.xp,
      completedAt: model.completedAt,
    );
  }
}
