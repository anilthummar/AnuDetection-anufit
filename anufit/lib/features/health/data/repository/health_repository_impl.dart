import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import 'package:anufit/features/health/data/datasource/health_local_datasource.dart';
import 'package:anufit/features/health/data/datasource/health_platform_datasource.dart';
import 'package:anufit/features/health/domain/entities/health_entity.dart';
import 'package:anufit/features/health/domain/repository/health_repository.dart';
import 'package:anufit/features/health/sync/sync_engine.dart';
import 'package:anufit/features/onboarding/domain/repository/onboarding_repository.dart';

@LazySingleton(as: HealthRepository)
class HealthRepositoryImpl implements HealthRepository {
  HealthRepositoryImpl(
    this._platform,
    this._local,
    this._syncEngine,
    this._onboardingRepository,
  );

  final HealthPlatformDatasource _platform;
  final HealthLocalDatasource _local;
  final SyncEngine _syncEngine;
  final OnboardingRepository _onboardingRepository;

  final _statusSubject = BehaviorSubject<HealthSyncStateEntity>();

  bool _connected = false;

  @override
  Stream<HealthSyncStateEntity> watchHealthStatus() => _statusSubject.stream;

  @override
  Future<bool> isPlatformAvailable() async {
    if (!await _platform.isAvailable()) return false;
    return _platform.isHealthConnectInstalled();
  }

  @override
  Future<bool> connectHealth() async {
    final available = await isPlatformAvailable();
    if (!available) return false;

    final permissions = await requestPermissions();
    if (!permissions.authorized) return false;

    _connected = true;
    final settings = await _onboardingRepository.getSettings();
    await _onboardingRepository.saveSettings(settings.copyWith(healthConnected: true));

    try {
      await syncHealthData(initial: true);
    } catch (_) {
      // Permissions granted; sync can retry later.
    }
    await _emitStatus();
    return true;
  }

  @override
  Future<HealthPermissionEntity> requestPermissions() async {
    final permissions = await _platform.requestPermissions();
    await _local.savePermissions(permissions);
    await _emitStatus();
    return permissions;
  }

  @override
  Future<HealthPermissionEntity> checkPermissions() async {
    final permissions = await _platform.checkPermissions();
    await _local.savePermissions(permissions);
    return permissions;
  }

  @override
  Future<HealthDailyRecord?> readTodayHealth() => _platform.readTodayHealth();

  @override
  Future<List<HealthDailyRecord>> readHistoricalHealth({
    required DateTime start,
    required DateTime end,
  }) {
    return _platform.readDailyRecords(start: start, end: end);
  }

  @override
  Future<bool> writeDailySummary({required DateTime date, required int steps}) {
    return _platform.writeDailySummary(date: date, steps: steps);
  }

  @override
  Future<SyncResult> syncHealthData({bool initial = false}) async {
    if (!_connected) {
      final perms = await checkPermissions();
      _connected = perms.authorized;
    }
    if (!_connected) {
      return const SyncResult(
        status: SyncStatus.failed,
        recordsUpdated: 0,
        conflictsResolved: 0,
        errorMessage: 'Not connected',
      );
    }

    final result = initial
        ? await _syncEngine.performInitialSync()
        : await _syncEngine.performIncrementalSync();

    await _syncEngine.writeMissingToPlatform();
    await _emitStatus();
    return result;
  }

  @override
  Future<void> disconnectHealth() async {
    await _platform.disconnect();
    await _local.clearSyncMeta();
    _connected = false;
    final settings = await _onboardingRepository.getSettings();
    await _onboardingRepository.saveSettings(settings.copyWith(healthConnected: false));
    await _emitStatus();
  }

  @override
  Future<void> refreshConnectionState() async {
    final permissions = await checkPermissions();
    _connected = permissions.authorized;
    final settings = await _onboardingRepository.getSettings();
    if (settings.healthConnected != permissions.authorized) {
      await _onboardingRepository.saveSettings(
        settings.copyWith(healthConnected: permissions.authorized),
      );
    }
    await _emitStatus();
  }

  @override
  Future<HealthSyncStateEntity> getSyncStatus() async {
    final sync = await _local.getSyncMeta();
    final permissions = await _mapCachedPermissions();
    final connected = permissions.authorized && _connected;
    return _local.toSyncState(
      sync: sync,
      permissions: permissions,
      platform: _platform.currentPlatform,
      connected: connected,
    );
  }

  Future<void> _emitStatus() async {
    final status = await getSyncStatus();
    _statusSubject.add(status);
  }

  Future<HealthPermissionEntity> _mapCachedPermissions() async {
    final model = await _local.getPermissions();
    return HealthPermissionEntity(
      steps: model.steps,
      distance: model.distance,
      calories: model.calories,
      weight: model.weight,
      height: model.height,
      authorized: model.authorized,
      status: _parsePermissionStatus(model.status),
    );
  }
}

SyncStatus _parseSyncStatus(String value) {
  for (final s in SyncStatus.values) {
    if (s.name == value) return s;
  }
  return SyncStatus.idle;
}

HealthPermissionState _parsePermissionStatus(String value) {
  for (final s in HealthPermissionState.values) {
    if (s.name == value) return s;
  }
  return HealthPermissionState.unknown;
}
