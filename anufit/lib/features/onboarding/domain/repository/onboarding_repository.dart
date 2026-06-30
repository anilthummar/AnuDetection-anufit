import 'package:anufit/features/onboarding/domain/entities/app_settings_entity.dart';
import 'package:anufit/features/onboarding/domain/entities/user_entity.dart';

abstract class OnboardingRepository {
  Future<AppSettingsEntity> getSettings();

  Future<void> saveSettings(AppSettingsEntity settings);

  Future<bool> isOnboardingComplete();

  Future<UserEntity?> getUser();

  Future<void> saveUser(UserEntity user);
}
