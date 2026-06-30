import 'package:injectable/injectable.dart';

import 'package:anufit/core/services/permission_service.dart';
import 'package:anufit/features/health/domain/entities/health_entity.dart';
import 'package:anufit/features/health/domain/repository/health_repository.dart';
import 'package:anufit/features/onboarding/domain/repository/onboarding_repository.dart';

/// Orchestrates activity recognition and Health Connect / Apple Health permissions.
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

  bool _promptedThisSession = false;

  /// Called after onboarding completes and on each cold start for returning users.
  Future<HealthPermissionSnapshot> ensureOnAppLaunch({bool forcePrompt = false}) async {
    final settings = await _onboarding.getSettings();
    if (!settings.onboardingComplete) {
      return const HealthPermissionSnapshot();
    }
    return _ensureAll(requestIfMissing: forcePrompt || !_promptedThisSession);
  }

  /// Re-check on resume; re-prompt if the user revoked permissions in system settings.
  Future<HealthPermissionSnapshot> onAppResume() async {
    final settings = await _onboarding.getSettings();
    if (!settings.onboardingComplete) {
      return const HealthPermissionSnapshot();
    }

    await _healthRepository.refreshConnectionState();
    final health = await _healthRepository.checkPermissions();
    final activity = await _permissions.checkPermission(AppPermissionType.activityRecognition);

    final needsPrompt = !activity.isGranted || !health.authorized;
    if (needsPrompt) {
      return _ensureAll(requestIfMissing: true);
    }

    return HealthPermissionSnapshot(
      activityGranted: activity.isGranted,
      healthAuthorized: health.authorized,
      healthConnected: health.authorized,
    );
  }

  Future<HealthPermissionSnapshot> _ensureAll({required bool requestIfMissing}) async {
    if (requestIfMissing) {
      _promptedThisSession = true;
    }

    var activity = await _permissions.checkPermission(AppPermissionType.activityRecognition);
    if (!activity.isGranted && requestIfMissing && !activity.isPermanentlyDenied) {
      activity = await _permissions.requestPermission(AppPermissionType.activityRecognition);
    }

    HealthPermissionEntity health = await _healthRepository.checkPermissions();
    await _healthRepository.refreshConnectionState();

    final platformAvailable = await _healthRepository.isPlatformAvailable();
    if (platformAvailable && !health.authorized && requestIfMissing) {
      await _healthRepository.connectHealth();
      health = await _healthRepository.checkPermissions();
      await _healthRepository.refreshConnectionState();
    } else {
      await _healthRepository.refreshConnectionState();
    }

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

  bool get allGranted => activityGranted && healthAuthorized;
}
