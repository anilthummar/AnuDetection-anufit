import 'package:injectable/injectable.dart';

import 'package:anufit/core/logger/app_logger.dart';
import 'package:anufit/features/health/data/datasource/health_local_datasource.dart';
import 'package:anufit/features/health/data/datasource/health_platform_datasource.dart';
import 'package:anufit/features/health/domain/entities/health_entity.dart';
import 'package:anufit/features/health/services/conflict_resolver.dart';
import 'package:anufit/features/health/services/data_source_priority_manager.dart';
import 'package:anufit/features/history/domain/services/analytics_engine.dart';
import 'package:anufit/features/step_counter/data/datasource/step_local_datasource.dart';
import 'package:anufit/features/step_counter/domain/services/step_baseline_calculator.dart';

@lazySingleton
class SyncEngine {
  SyncEngine(
    this._platform,
    this._local,
    this._stepLocal,
    this._analytics,
    this._logger,
  );

  final HealthPlatformDatasource _platform;
  final HealthLocalDatasource _local;
  final StepLocalDatasource _stepLocal;
  final AnalyticsEngine _analytics;
  final AppLogger _logger;

  static const initialSyncDays = 30;

  Future<SyncResult> performInitialSync() async {
    final end = DateTime.now();
    final start = end.subtract(const Duration(days: initialSyncDays));
    return _syncRange(start: start, end: end, isInitial: true);
  }

  Future<SyncResult> performIncrementalSync() async {
    final meta = await _local.getSyncMeta();
    final start = meta.lastIncrementalSync ??
        DateTime.now().subtract(const Duration(days: initialSyncDays));
    return _syncRange(start: start, end: DateTime.now(), isInitial: false);
  }

  Future<SyncResult> _syncRange({
    required DateTime start,
    required DateTime end,
    required bool isInitial,
  }) async {
    if (!await _platform.isAvailable()) {
      return const SyncResult(
        status: SyncStatus.failed,
        recordsUpdated: 0,
        conflictsResolved: 0,
        errorMessage: 'Health service unavailable',
      );
    }

    await _local.updateSyncStatus(status: SyncStatus.syncing);

    try {
      final remoteRecords = await _platform.readDailyRecords(start: start, end: end);
      var updated = 0;
      var conflicts = 0;

      for (final remote in remoteRecords) {
        final day = StepBaselineCalculator.localDate(remote.date);
        final localSummaries =
            await _stepLocal.getDailySummaries(start: day, end: day);
        final localSteps = localSummaries.firstOrNull?.steps ?? 0;

        if (localSteps == remote.steps) continue;

        final resolution = ConflictResolver.resolveSteps(
          date: day,
          localSteps: localSteps,
          remoteSteps: remote.steps,
        );

        if (resolution.resolvedSteps != localSteps) {
          final shouldImport = DataSourcePriorityManager.shouldImportFromHealth(
            localSteps: localSteps,
            healthSteps: remote.steps,
            localSource: DataSourceType.nativeStepCounter,
          );

          if (shouldImport || resolution.resolvedSteps > localSteps) {
            await _stepLocal.upsertDailySteps(
              date: day,
              steps: resolution.resolvedSteps,
              hardwareBaseline: 0,
              hardwareTotalEnd: resolution.resolvedSteps,
            );
            await _analytics.syncForDate(day);
            updated++;
            if (resolution.localSteps != resolution.remoteSteps) {
              conflicts++;
              _logger.i(
                'Health sync conflict ${day.toIso8601String()}: '
                'local=${resolution.localSteps} remote=${resolution.remoteSteps} '
                '→ ${resolution.resolvedSteps} (${resolution.reason})',
              );
            }
          }
        }
      }

      await _local.saveSyncMeta(
        lastSync: DateTime.now(),
        status: SyncStatus.success,
        recordsSynced: updated,
        source: _platform.platformName,
        lastIncrementalSync: end,
      );

      return SyncResult(
        status: SyncStatus.success,
        recordsUpdated: updated,
        conflictsResolved: conflicts,
      );
    } catch (error, stack) {
      _logger.e('Health sync failed', error, stack);
      await _local.updateSyncStatus(
        status: SyncStatus.failed,
        errorMessage: error.toString(),
      );
      return SyncResult(
        status: SyncStatus.failed,
        recordsUpdated: 0,
        conflictsResolved: 0,
        errorMessage: error.toString(),
      );
    }
  }

  Future<void> writeMissingToPlatform() async {
    final today = StepBaselineCalculator.localDate(DateTime.now());
    final summaries = await _stepLocal.getDailySummaries(start: today, end: today);
    final steps = summaries.firstOrNull?.steps ?? 0;
    if (steps > 0) {
      await _platform.writeDailySummary(date: today, steps: steps);
    }
  }
}

extension _FirstOrNull<E> on List<E> {
  E? get firstOrNull => isEmpty ? null : first;
}
