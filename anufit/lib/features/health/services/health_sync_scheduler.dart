import 'package:injectable/injectable.dart';

import 'package:anufit/core/di/injection.dart';
import 'package:anufit/features/health/domain/repository/health_repository.dart';
import 'package:anufit/features/health/domain/usecases/health_usecases.dart';
import 'package:anufit/features/health/services/health_permission_coordinator.dart';
import 'package:anufit/features/onboarding/domain/repository/onboarding_repository.dart';

/// Schedules health sync on app launch and resume.
@lazySingleton
class HealthSyncScheduler {
  HealthSyncScheduler(
    this._sync,
    this._onboarding,
    this._coordinator,
    this._healthRepository,
  );

  final SyncHealthDataUseCase _sync;
  final OnboardingRepository _onboarding;
  final HealthPermissionCoordinator _coordinator;
  final HealthRepository _healthRepository;

  Future<void> syncIfConnected() async {
    try {
      final settings = await _onboarding.getSettings();
      if (!settings.onboardingComplete) return;

      await _coordinator.ensureOnAppLaunch();
      await _healthRepository.refreshConnectionState();
      final status = await _healthRepository.getSyncStatus();
      if (!status.connected) return;
      await _sync(const SyncHealthParams());
    } catch (_) {
      // Non-fatal on background sync.
    }
  }

  Future<void> onAppResume() async {
    try {
      await _coordinator.onAppResume();
      await syncIfConnected();
    } catch (_) {}
  }
}

Future<void> triggerHealthSyncOnResume() => getIt<HealthSyncScheduler>().onAppResume();
