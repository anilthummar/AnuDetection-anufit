import 'package:injectable/injectable.dart';

import 'package:anufit/core/services/permission_service.dart';
import 'package:anufit/features/health/domain/repository/health_repository.dart';
import 'package:anufit/features/onboarding/domain/repository/onboarding_repository.dart';

/// Checks activity recognition and Health Connect / Apple Health permission state.
@lazySingleton
class HealthPermissionCoordinator {
  HealthPermissionCoordinator(
    this._permissions,
    this._healthRepository,
    this._onboarding,
  );

  final PermissionService _permissions;
  final HealthRepository _healthRepository;
  final OnboardingRepository _onboarding;

  /// Called after onboarding completes and on each cold start for returning users.
  Future<HealthPermissionSnapshot> ensureOnAppLaunch() async {
    final settings = await _onboarding.getSettings();
    if (!settings.onboardingComplete) {
      return const HealthPermissionSnapshot();
    }
    return _snapshot();
  }

  /// Re-check on resume when the user may have changed permissions in system settings.
  Future<HealthPermissionSnapshot> onAppResume() async {
    final settings = await _onboarding.getSettings();
    if (!settings.onboardingComplete) {
      return const HealthPermissionSnapshot();
    }

    await _healthRepository.refreshConnectionState();
    return _snapshot();
  }

  Future<HealthPermissionSnapshot> _snapshot() async {
    final activity = await _permissions.checkPermission(AppPermissionType.activityRecognition);
    final health = await _healthRepository.checkPermissions();
    await _healthRepository.refreshConnectionState();
    final status = await _healthRepository.getSyncStatus();

    return HealthPermissionSnapshot(
      activityGranted: activity.isGranted,
      healthAuthorized: health.authorized,
      healthConnected: status.connected,
      activityPermanentlyDenied: activity.isPermanentlyDenied,
    );
  }
}

class HealthPermissionSnapshot {
  const HealthPermissionSnapshot({
    this.activityGranted = false,
    this.healthAuthorized = false,
    this.healthConnected = false,
    this.activityPermanentlyDenied = false,
  });

  final bool activityGranted;
  final bool healthAuthorized;
  final bool healthConnected;
  final bool activityPermanentlyDenied;

  bool get needsActivityPermission => !activityGranted;
}
