import 'package:injectable/injectable.dart';
import 'package:isar_community/isar.dart';

import 'package:anufit/core/database/isar_service.dart';
import 'package:anufit/features/health/data/models/health_permission_model.dart';
import 'package:anufit/features/health/data/models/health_sync_model.dart';
import 'package:anufit/features/health/domain/entities/health_entity.dart';

@lazySingleton
class HealthLocalDatasource {
  HealthLocalDatasource(this._isarService);

  final IsarService _isarService;

  Future<HealthSyncModel> getSyncMeta() async {
    final existing = await _isarService.db.healthSyncModels.get(1);
    if (existing != null) return existing;
    final initial = HealthSyncModel();
    await _isarService.db.writeTxn(() async {
      await _isarService.db.healthSyncModels.put(initial);
    });
    return initial;
  }

  Future<void> saveSyncMeta({
    required DateTime lastSync,
    required SyncStatus status,
    required int recordsSynced,
    required String source,
    DateTime? lastIncrementalSync,
  }) async {
    await _isarService.db.writeTxn(() async {
      final model = await getSyncMeta();
      model
        ..lastSync = lastSync
        ..status = status.name
        ..recordsSynced = recordsSynced
        ..source = source
        ..errorMessage = null
        ..lastIncrementalSync = lastIncrementalSync ?? lastSync;
      await _isarService.db.healthSyncModels.put(model);
    });
  }

  Future<void> updateSyncStatus({
    required SyncStatus status,
    String? errorMessage,
  }) async {
    await _isarService.db.writeTxn(() async {
      final model = await getSyncMeta();
      model
        ..status = status.name
        ..errorMessage = errorMessage;
      await _isarService.db.healthSyncModels.put(model);
    });
  }

  Future<void> clearSyncMeta() async {
    await _isarService.db.writeTxn(() async {
      final model = await getSyncMeta();
      model
        ..lastSync = null
        ..status = SyncStatus.disconnected.name
        ..recordsSynced = 0
        ..source = 'none'
        ..errorMessage = null
        ..lastIncrementalSync = null;
      await _isarService.db.healthSyncModels.put(model);
    });
  }

  Future<HealthPermissionModel> getPermissions() async {
    final existing = await _isarService.db.healthPermissionModels.get(1);
    if (existing != null) return existing;
    final initial = HealthPermissionModel();
    await _isarService.db.writeTxn(() async {
      await _isarService.db.healthPermissionModels.put(initial);
    });
    return initial;
  }

  Future<void> savePermissions(HealthPermissionEntity entity) async {
    await _isarService.db.writeTxn(() async {
      final model = await getPermissions();
      model
        ..steps = entity.steps
        ..distance = entity.distance
        ..calories = entity.calories
        ..weight = entity.weight
        ..height = entity.height
        ..authorized = entity.authorized
        ..status = entity.status.name;
      await _isarService.db.healthPermissionModels.put(model);
    });
  }

  HealthSyncStateEntity toSyncState({
    required HealthSyncModel sync,
    required HealthPermissionEntity permissions,
    required HealthPlatform platform,
    required bool connected,
  }) {
    return HealthSyncStateEntity(
      connected: connected,
      platform: platform,
      lastSync: sync.lastSync,
      status: _parseSyncStatus(sync.status),
      recordsSynced: sync.recordsSynced,
      errorMessage: sync.errorMessage,
      permissions: permissions,
    );
  }
}

SyncStatus _parseSyncStatus(String value) {
  for (final s in SyncStatus.values) {
    if (s.name == value) return s;
  }
  return SyncStatus.idle;
}
