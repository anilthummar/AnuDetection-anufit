import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:anufit/core/enums/onboarding_step.dart';
import 'package:anufit/core/exceptions/app_exception.dart';
import 'package:anufit/features/onboarding/data/models/app_settings_model.dart';
import 'package:anufit/features/onboarding/domain/entities/app_settings_entity.dart';
import 'package:anufit/features/onboarding/domain/entities/user_entity.dart';
import 'package:anufit/features/onboarding/domain/repository/onboarding_repository.dart';

@injectable
class InitializeAppSettingsUseCase {
  const InitializeAppSettingsUseCase(this._repository);

  final OnboardingRepository _repository;

  Future<AppSettingsEntity> call() async {
    try {
      return await _repository.getSettings();
    } on CacheException {
      final info = await PackageInfo.fromPlatform();
      final initial = AppSettingsModel.initial(appVersion: info.version).toEntity();
      await _repository.saveSettings(initial);
      return initial;
    }
  }
}

@injectable
class GetOnboardingStatusUseCase {
  const GetOnboardingStatusUseCase(this._repository);

  final OnboardingRepository _repository;

  Future<bool> call() => _repository.isOnboardingComplete();
}

@injectable
class SaveOnboardingStepUseCase {
  const SaveOnboardingStepUseCase(this._repository);

  final OnboardingRepository _repository;

  Future<void> call(OnboardingStep step) async {
    final settings = await _repository.getSettings();
    await _repository.saveSettings(
      settings.copyWith(currentOnboardingStep: step),
    );
  }
}

@injectable
class CompleteOnboardingUseCase {
  const CompleteOnboardingUseCase(this._repository);

  final OnboardingRepository _repository;

  Future<void> call() async {
    final settings = await _repository.getSettings();
    await _repository.saveSettings(
      settings.copyWith(
        onboardingComplete: true,
        currentOnboardingStep: OnboardingStep.finish,
      ),
    );
  }
}

@injectable
class SaveUserProfileUseCase {
  const SaveUserProfileUseCase(this._repository);

  final OnboardingRepository _repository;

  Future<void> call(UserEntity user) => _repository.saveUser(user);
}

@injectable
class GetUserProfileUseCase {
  const GetUserProfileUseCase(this._repository);

  final OnboardingRepository _repository;

  Future<UserEntity?> call() => _repository.getUser();
}

@injectable
class SaveAppSettingsUseCase {
  const SaveAppSettingsUseCase(this._repository);

  final OnboardingRepository _repository;

  Future<void> call(AppSettingsEntity settings) => _repository.saveSettings(settings);
}

@injectable
class GetAppSettingsUseCase {
  const GetAppSettingsUseCase(this._repository);

  final OnboardingRepository _repository;

  Future<AppSettingsEntity> call() => _repository.getSettings();
}
