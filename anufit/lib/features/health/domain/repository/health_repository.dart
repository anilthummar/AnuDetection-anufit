import 'package:anufit/features/health/domain/entities/health_entity.dart';

abstract class HealthRepository {
  Future<HealthPermissionEntity> requestPermissions();
  Future<HealthPermissionEntity> checkPermissions();
  Future<HealthDailyRecord?> readTodayHealth();
  Future<List<HealthDailyRecord>> readHistoricalHealth({
    required DateTime start,
    required DateTime end,
  });
  Future<bool> writeDailySummary({required DateTime date, required int steps});
  Future<SyncResult> syncHealthData({bool initial = false});
  Future<void> disconnectHealth();
  Future<HealthSyncStateEntity> getSyncStatus();
  Stream<HealthSyncStateEntity> watchHealthStatus();
  Future<bool> connectHealth();
  Future<bool> isPlatformAvailable();
  Future<void> refreshConnectionState();
}