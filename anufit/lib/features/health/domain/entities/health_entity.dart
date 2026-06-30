import 'package:equatable/equatable.dart';

enum HealthPlatform { healthConnect, appleHealth, unavailable }

enum HealthPermissionState { granted, denied, permanentlyDenied, limited, unknown }

enum SyncStatus { idle, syncing, success, partial, failed, disconnected }

class HealthPermissionEntity extends Equatable {
  const HealthPermissionEntity({
    required this.steps,
    required this.distance,
    required this.calories,
    required this.weight,
    required this.height,
    required this.authorized,
    required this.status,
  });

  final bool steps;
  final bool distance;
  final bool calories;
  final bool weight;
  final bool height;
  final bool authorized;
  final HealthPermissionState status;

  @override
  List<Object?> get props => [steps, distance, calories, weight, height, authorized, status];
}

class HealthDailyRecord extends Equatable {
  const HealthDailyRecord({
    required this.date,
    required this.steps,
    this.distanceMeters,
    this.calories,
    this.walkingMinutes,
    required this.source,
  });

  final DateTime date;
  final int steps;
  final double? distanceMeters;
  final double? calories;
  final int? walkingMinutes;
  final HealthPlatform source;

  @override
  List<Object?> get props => [date, steps, distanceMeters, calories, walkingMinutes, source];
}

class HealthSyncStateEntity extends Equatable {
  const HealthSyncStateEntity({
    required this.connected,
    required this.platform,
    required this.lastSync,
    required this.status,
    required this.recordsSynced,
    required this.errorMessage,
    required this.permissions,
  });

  final bool connected;
  final HealthPlatform platform;
  final DateTime? lastSync;
  final SyncStatus status;
  final int recordsSynced;
  final String? errorMessage;
  final HealthPermissionEntity permissions;

  @override
  List<Object?> get props =>
      [connected, platform, lastSync, status, recordsSynced, errorMessage, permissions];
}

class SyncResult extends Equatable {
  const SyncResult({
    required this.status,
    required this.recordsUpdated,
    required this.conflictsResolved,
    this.errorMessage,
  });

  final SyncStatus status;
  final int recordsUpdated;
  final int conflictsResolved;
  final String? errorMessage;

  @override
  List<Object?> get props => [status, recordsUpdated, conflictsResolved, errorMessage];
}

class ConflictResolution extends Equatable {
  const ConflictResolution({
    required this.date,
    required this.localSteps,
    required this.remoteSteps,
    required this.resolvedSteps,
    required this.reason,
  });

  final DateTime date;
  final int localSteps;
  final int remoteSteps;
  final int resolvedSteps;
  final String reason;

  @override
  List<Object?> get props => [date, localSteps, remoteSteps, resolvedSteps, reason];
}
