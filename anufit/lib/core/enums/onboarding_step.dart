enum OnboardingStep {
  welcome,
  features,
  permissions,
  profile,
  goal,
  walkingPreferences,
  healthIntegration,
  finish,
}

extension OnboardingStepX on OnboardingStep {
  String get routeSuffix => switch (this) {
        OnboardingStep.welcome => 'welcome',
        OnboardingStep.features => 'features',
        OnboardingStep.permissions => 'permissions',
        OnboardingStep.profile => 'profile',
        OnboardingStep.goal => 'goal',
        OnboardingStep.walkingPreferences => 'walking',
        OnboardingStep.healthIntegration => 'health',
        OnboardingStep.finish => 'finish',
      };

  OnboardingStep? get next => switch (this) {
        OnboardingStep.welcome => OnboardingStep.features,
        OnboardingStep.features => OnboardingStep.permissions,
        OnboardingStep.permissions => OnboardingStep.profile,
        OnboardingStep.profile => OnboardingStep.goal,
        OnboardingStep.goal => OnboardingStep.walkingPreferences,
        OnboardingStep.walkingPreferences => OnboardingStep.healthIntegration,
        OnboardingStep.healthIntegration => OnboardingStep.finish,
        OnboardingStep.finish => null,
      };
}
