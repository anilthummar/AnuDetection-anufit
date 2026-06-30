import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:anufit/core/enums/onboarding_step.dart';
import 'package:anufit/features/onboarding/domain/entities/app_settings_entity.dart';
import 'package:anufit/features/onboarding/domain/usecases/onboarding_usecases.dart';

class SplashResult extends Equatable {
  const SplashResult._({
    required this.isOnboardingComplete,
    this.resumeStep,
  });

  const SplashResult.dashboard() : this._(isOnboardingComplete: true);

  const SplashResult.onboarding(OnboardingStep step)
      : this._(isOnboardingComplete: false, resumeStep: step);

  final bool isOnboardingComplete;
  final OnboardingStep? resumeStep;

  @override
  List<Object?> get props => [isOnboardingComplete, resumeStep];
}

@injectable
class InitializeSplashUseCase {
  const InitializeSplashUseCase(
    this._initializeAppSettings,
    this._getOnboardingStatus,
  );

  final InitializeAppSettingsUseCase _initializeAppSettings;
  final GetOnboardingStatusUseCase _getOnboardingStatus;

  Future<SplashResult> call() async {
    final AppSettingsEntity settings = await _initializeAppSettings();
    final complete = await _getOnboardingStatus();
    if (complete) {
      return const SplashResult.dashboard();
    }
    return SplashResult.onboarding(settings.currentOnboardingStep);
  }
}
