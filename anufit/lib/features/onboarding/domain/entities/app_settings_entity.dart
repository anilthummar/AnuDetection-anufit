import 'package:equatable/equatable.dart';

import 'package:anufit/core/enums/onboarding_step.dart';

class AppSettingsEntity extends Equatable {
  const AppSettingsEntity({
    required this.id,
    required this.theme,
    required this.language,
    required this.notificationsEnabled,
    required this.onboardingComplete,
    required this.healthConnected,
    required this.currentOnboardingStep,
    required this.appVersion,
  });

  final int id;
  final String theme;
  final String language;
  final bool notificationsEnabled;
  final bool onboardingComplete;
  final bool healthConnected;
  final OnboardingStep currentOnboardingStep;
  final String appVersion;

  AppSettingsEntity copyWith({
    String? theme,
    String? language,
    bool? notificationsEnabled,
    bool? onboardingComplete,
    bool? healthConnected,
    OnboardingStep? currentOnboardingStep,
    String? appVersion,
  }) {
    return AppSettingsEntity(
      id: id,
      theme: theme ?? this.theme,
      language: language ?? this.language,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      onboardingComplete: onboardingComplete ?? this.onboardingComplete,
      healthConnected: healthConnected ?? this.healthConnected,
      currentOnboardingStep: currentOnboardingStep ?? this.currentOnboardingStep,
      appVersion: appVersion ?? this.appVersion,
    );
  }

  @override
  List<Object?> get props => [
        id,
        theme,
        language,
        notificationsEnabled,
        onboardingComplete,
        healthConnected,
        currentOnboardingStep,
        appVersion,
      ];
}
