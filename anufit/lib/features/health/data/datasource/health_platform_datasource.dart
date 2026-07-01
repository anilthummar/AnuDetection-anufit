import 'dart:io';

import 'package:health/health.dart';
import 'package:injectable/injectable.dart';

import 'package:anufit/features/health/domain/entities/health_entity.dart';

@lazySingleton
class HealthPlatformDatasource {
  HealthPlatformDatasource() : _health = Health();

  final Health _health;

  /// iOS uses walking/running distance; Health Connect uses [DISTANCE_DELTA].
  HealthDataType get _distanceType => Platform.isIOS
      ? HealthDataType.DISTANCE_WALKING_RUNNING
      : HealthDataType.DISTANCE_DELTA;

  List<HealthDataType> get _essentialTypes => [
        HealthDataType.STEPS,
        _distanceType,
        HealthDataType.ACTIVE_ENERGY_BURNED,
      ];

  HealthPlatform get currentPlatform {
    if (Platform.isIOS) return HealthPlatform.appleHealth;
    if (Platform.isAndroid) return HealthPlatform.healthConnect;
    return HealthPlatform.unavailable;
  }

  String get platformName => switch (currentPlatform) {
        HealthPlatform.appleHealth => 'Apple Health',
        HealthPlatform.healthConnect => 'Health Connect',
        HealthPlatform.unavailable => 'Unavailable',
      };

  Future<bool> isAvailable() async {
    if (currentPlatform == HealthPlatform.unavailable) return false;
    try {
      await _health.configure();
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> isHealthConnectInstalled() async {
    if (!Platform.isAndroid) return true;
    try {
      return await _health.isHealthConnectAvailable();
    } catch (_) {
      return false;
    }
  }

  Future<HealthPermissionEntity> checkPermissions() async {
    await _health.configure();
    final access = await _resolveEssentialAccess();
    return _toPermissionEntity(access);
  }

  /// Opens the Health Connect / Apple Health permission UI.
  Future<HealthPermissionEntity> requestPermissions() async {
    await _health.configure();
    if (Platform.isAndroid) {
      final available = await _health.isHealthConnectAvailable();
      if (!available) {
        try {
          await _health.installHealthConnect();
        } catch (_) {}
      }
    }

    final types = _essentialTypes;
    final readAccess = types.map((_) => HealthDataAccess.READ).toList();
    await _health.requestAuthorization(types, permissions: readAccess);

    var access = await _resolveEssentialAccess(probeIfStale: true);
    if (!access.isFullyGranted && Platform.isAndroid) {
      final writeAccess = types.map((_) => HealthDataAccess.READ_WRITE).toList();
      await _health.requestAuthorization(types, permissions: writeAccess);
      access = await _resolveEssentialAccess(probeIfStale: true);
    }

    return _toPermissionEntity(access);
  }

  /// Checks read access for steps, distance, and active calories only.
  Future<_EssentialAccess> _getEssentialAccess() async {
    return _EssentialAccess(
      steps: await _hasAccess(HealthDataType.STEPS),
      distance: await _hasAccess(_distanceType),
      calories: await _hasAccess(HealthDataType.ACTIVE_ENERGY_BURNED),
    );
  }

  /// Resolves essential access; optional probe only after an authorization request.
  Future<_EssentialAccess> _resolveEssentialAccess({bool probeIfStale = false}) async {
    final access = await _getEssentialAccess();
    if (access.isFullyGranted) return access;
    if (!probeIfStale || !Platform.isAndroid || !access.steps) return access;

    if (!await _canReadStepsProbe()) return access;

    return _getEssentialAccess();
  }

  Future<bool> _hasAccess(HealthDataType type) async {
    final read = await _health.hasPermissions([type]);
    if (read == true) return true;

    final readWrite = await _health.hasPermissions(
      [type],
      permissions: [HealthDataAccess.READ_WRITE],
    );
    return readWrite == true;
  }

  /// Fallback when [hasPermissions] is stale right after granting in Health Connect.
  Future<bool> _canReadStepsProbe() async {
    try {
      final now = DateTime.now();
      final start = DateTime(now.year, now.month, now.day);
      await _health.getHealthDataFromTypes(
        types: [HealthDataType.STEPS],
        startTime: start,
        endTime: now,
      );
      return true;
    } catch (_) {
      return false;
    }
  }

  HealthPermissionEntity _toPermissionEntity(_EssentialAccess access) {
    return HealthPermissionEntity(
      steps: access.steps,
      distance: access.distance,
      calories: access.calories,
      weight: false,
      height: false,
      authorized: access.isFullyGranted,
      status: access.isFullyGranted
          ? HealthPermissionState.granted
          : HealthPermissionState.denied,
    );
  }

  Future<List<HealthDailyRecord>> readDailyRecords({
    required DateTime start,
    required DateTime end,
  }) async {
    await _health.configure();
    final access = await _getEssentialAccess();
    if (!access.steps) return [];

    final stepsData = await _health.getHealthDataFromTypes(
      types: [HealthDataType.STEPS],
      startTime: start,
      endTime: end,
    );

    final byDay = <DateTime, int>{};
    for (final point in stepsData) {
      final day = DateTime(
        point.dateFrom.year,
        point.dateFrom.month,
        point.dateFrom.day,
      );
      final value = (point.value as NumericHealthValue).numericValue.round();
      byDay[day] = (byDay[day] ?? 0) + value;
    }

    return byDay.entries
        .map(
          (e) => HealthDailyRecord(
            date: e.key,
            steps: e.value,
            source: currentPlatform,
          ),
        )
        .toList();
  }

  Future<HealthDailyRecord?> readTodayHealth() async {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    final records = await readDailyRecords(start: start, end: now);
    return records.firstOrNull;
  }

  Future<bool> writeDailySummary({
    required DateTime date,
    required int steps,
    double? distanceMeters,
    double? calories,
  }) async {
    await _health.configure();
    final access = await _getEssentialAccess();
    if (!access.steps) return false;

    final end = date.add(const Duration(days: 1)).subtract(const Duration(seconds: 1));
    final success = await _health.writeHealthData(
      value: steps.toDouble(),
      type: HealthDataType.STEPS,
      startTime: date,
      endTime: end,
    );
    return success;
  }

  Future<bool> writeWeight({
    required double weightKg,
    required DateTime date,
  }) async {
    // Weight sync via Health Connect / Apple Health is not requested in v1.
    return false;
  }

  Future<void> disconnect() async {
    // Platform SDKs do not support programmatic disconnect; no-op.
  }
}

extension _FirstOrNull<E> on List<E> {
  E? get firstOrNull => isEmpty ? null : first;
}

class _EssentialAccess {
  const _EssentialAccess({
    required this.steps,
    required this.distance,
    required this.calories,
  });

  final bool steps;
  final bool distance;
  final bool calories;

  bool get isFullyGranted => steps && distance && calories;
}
