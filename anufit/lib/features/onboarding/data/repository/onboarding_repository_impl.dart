import 'package:injectable/injectable.dart';
import 'package:isar_community/isar.dart';

import 'package:anufit/core/database/isar_service.dart';
import 'package:anufit/core/exceptions/app_exception.dart';
import 'package:anufit/features/onboarding/data/models/app_settings_model.dart';
import 'package:anufit/features/onboarding/data/models/user_model.dart';
import 'package:anufit/features/onboarding/domain/entities/app_settings_entity.dart';
import 'package:anufit/features/onboarding/domain/entities/user_entity.dart';
import 'package:anufit/features/onboarding/domain/repository/onboarding_repository.dart';

@LazySingleton(as: OnboardingRepository)
class OnboardingRepositoryImpl implements OnboardingRepository {
  OnboardingRepositoryImpl(this._isarService);

  final IsarService _isarService;

  @override
  Future<AppSettingsEntity> getSettings() async {
    try {
      final model = await _isarService.db.appSettingsModels.get(1);
      if (model == null) {
        throw const CacheException('App settings not initialized');
      }
      return model.toEntity();
    } catch (e) {
      throw CacheException('Failed to load settings: $e');
    }
  }

  @override
  Future<void> saveSettings(AppSettingsEntity settings) async {
    try {
      await _isarService.db.writeTxn(() async {
        await _isarService.db.appSettingsModels.put(AppSettingsModel.fromEntity(settings));
      });
    } catch (e) {
      throw CacheException('Failed to save settings: $e');
    }
  }

  @override
  Future<bool> isOnboardingComplete() async {
    final settings = await getSettings();
    return settings.onboardingComplete;
  }

  @override
  Future<UserEntity?> getUser() async {
    try {
      final models = await _isarService.db.userModels.where().findAll();
      return models.isEmpty ? null : models.first.toEntity();
    } catch (e) {
      throw CacheException('Failed to load user: $e');
    }
  }

  @override
  Future<void> saveUser(UserEntity user) async {
    try {
      await _isarService.db.writeTxn(() async {
        await _isarService.db.userModels.put(UserModel.fromEntity(user));
      });
    } catch (e) {
      throw CacheException('Failed to save user: $e');
    }
  }
}
