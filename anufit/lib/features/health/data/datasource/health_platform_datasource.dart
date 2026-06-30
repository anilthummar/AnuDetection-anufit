import 'dart:io';

import 'package:health/health.dart';
import 'package:injectable/injectable.dart';

import 'package:anufit/features/health/domain/entities/health_entity.dart';

@lazySingleton
class HealthPlatformDatasource {
  HealthPlatformDatasource() : _health = Health();

  final Health _health;

  static const _readTypes = [
    HealthDataType.STEPS,
    HealthDataType.DISTANCE_WALKING_RUNNING,
    HealthDataType.ACTIVE_ENERGY_BURNED,
    HealthDataType.WEIGHT,
    HealthDataType.HEIGHT,
  ];

  static const _writeTypes = [
    HealthDataType.STEPS,
    HealthDataType.DISTANCE_WALKING_RUNNING,
    HealthDataType.ACTIVE_ENERGY_BURNED,
    HealthDataType.WEIGHT,
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
    final granted = await _health.hasPermissions(_readTypes) ?? false;
    return HealthPermissionEntity(
      steps: granted,
      distance: granted,
      calories: granted,
      weight: granted,
      height: granted,
      authorized: granted,
      status: granted ? HealthPermissionState.granted : HealthPermissionState.denied,
    );
  }

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
    final permissions = _readTypes
        .map((_) => HealthDataAccess.READ)
        .toList();
    final granted = await _health.requestAuthorization(_readTypes, permissions: permissions);
    if (!granted && Platform.isAndroid) {
      final writePermissions = _readTypes
          .map(
            (type) => _writeTypes.contains(type)
                ? HealthDataAccess.READ_WRITE
                : HealthDataAccess.READ,
          )
          .toList();
      final retry = await _health.requestAuthorization(_readTypes, permissions: writePermissions);
      return HealthPermissionEntity(
        steps: retry,
        distance: retry,
        calories: retry,
        weight: retry,
        height: retry,
        authorized: retry,
        status: retry ? HealthPermissionState.granted : HealthPermissionState.denied,
      );
    }
    return HealthPermissionEntity(
      steps: granted,
      distance: granted,
      calories: granted,
      weight: granted,
      height: granted,
      authorized: granted,
      status: granted ? HealthPermissionState.granted : HealthPermissionState.denied,
    );
  }

  Future<List<HealthDailyRecord>> readDailyRecords({
    required DateTime start,
    required DateTime end,
  }) async {
    await _health.configure();
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
    try {
      await _health.configure();
      final granted = await _health.hasPermissions(_writeTypes) ?? false;
      if (!granted) return false;
      return await _health.writeHealthData(
        value: weightKg,
        type: HealthDataType.WEIGHT,
        startTime: date,
        endTime: date,
      );
    } catch (_) {
      return false;
    }
  }

  Future<void> disconnect() async {
    // Platform SDKs do not support programmatic disconnect; no-op.
  }
}

extension _FirstOrNull<E> on List<E> {
  E? get firstOrNull => isEmpty ? null : first;
}
