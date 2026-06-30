import 'package:isar_community/isar.dart';

import 'package:anufit/core/enums/onboarding_step.dart';
import 'package:anufit/features/onboarding/domain/entities/app_settings_entity.dart';

part 'app_settings_model.g.dart';

@collection
class AppSettingsModel {
  Id id = 1;

  String theme = 'system';

  String language = 'en';

  bool notificationsEnabled = true;

  bool onboardingComplete = false;

  bool healthConnected = false;

  @Enumerated(EnumType.name)
  OnboardingStep currentOnboardingStep = OnboardingStep.welcome;

  String appVersion = '';

  AppSettingsEntity toEntity() {
    return AppSettingsEntity(
      id: id,
      theme: theme,
      language: language,
      notificationsEnabled: notificationsEnabled,
      onboardingComplete: onboardingComplete,
      healthConnected: healthConnected,
      currentOnboardingStep: currentOnboardingStep,
      appVersion: appVersion,
    );
  }

  static AppSettingsModel fromEntity(AppSettingsEntity entity) {
    return AppSettingsModel()
      ..id = entity.id
      ..theme = entity.theme
      ..language = entity.language
      ..notificationsEnabled = entity.notificationsEnabled
      ..onboardingComplete = entity.onboardingComplete
      ..healthConnected = entity.healthConnected
      ..currentOnboardingStep = entity.currentOnboardingStep
      ..appVersion = entity.appVersion;
  }

  static AppSettingsModel initial({required String appVersion}) {
    return AppSettingsModel()..appVersion = appVersion;
  }
}
