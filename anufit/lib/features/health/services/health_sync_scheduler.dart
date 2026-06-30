import 'package:injectable/injectable.dart';

import 'package:anufit/core/di/injection.dart';
import 'package:anufit/core/usecase/usecase.dart';
import 'package:anufit/features/health/domain/usecases/health_usecases.dart';
import 'package:anufit/features/onboarding/domain/repository/onboarding_repository.dart';

/// Schedules health sync on app launch and resume.
@lazySingleton
class HealthSyncScheduler {
  HealthSyncScheduler(this._sync, this._onboarding);

  final SyncHealthDataUseCase _sync;
  final OnboardingRepository _onboarding;

  Future<void> syncIfConnected() async {
    try {
      final settings = await _onboarding.getSettings();
      if (!settings.healthConnected) return;
      await _sync(const SyncHealthParams());
    } catch (_) {
      // Non-fatal on background sync.
    }
  }
}

Future<void> triggerHealthSyncOnResume() => getIt<HealthSyncScheduler>().syncIfConnected();
