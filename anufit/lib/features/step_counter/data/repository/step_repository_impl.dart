import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import 'package:anufit/core/exceptions/app_exception.dart';
import 'package:anufit/core/logger/app_logger.dart';
import 'package:anufit/features/step_counter/data/datasource/step_counter_pigeon_datasource.dart';
import 'package:anufit/features/step_counter/data/datasource/step_local_datasource.dart';
import 'package:anufit/features/step_counter/data/models/step_tracking_state_model.dart';
import 'package:anufit/features/step_counter/data/pigeon/step_counter_api.g.dart';
import 'package:anufit/features/step_counter/domain/entities/hourly_step_point.dart';
import 'package:anufit/features/step_counter/domain/entities/step_data.dart';
import 'package:anufit/features/step_counter/domain/repository/step_repository.dart';
import 'package:anufit/features/step_counter/domain/services/step_baseline_calculator.dart';

@LazySingleton(as: StepRepository)
class StepRepositoryImpl implements StepRepository {
  StepRepositoryImpl(
    this._native,
    this._local,
    this._logger,
  ) {
    _nativeSubscription = _native.events.listen(
      _onNativeEvent,
      onError: (Object error, StackTrace stack) {
        _logger.e('Step stream error', error, stack);
      },
    );
    _errorSubscription = _native.errors.listen((StepCounterNativeError error) {
      _logger.e('Step native error: ${error.code}');
    });
  }

  final StepCounterPigeonDatasource _native;
  final StepLocalDatasource _local;
  final AppLogger _logger;

  late final StreamSubscription<StepCounterNativeEvent> _nativeSubscription;
  late final StreamSubscription<StepCounterNativeError> _errorSubscription;

  final BehaviorSubject<StepData> _liveSteps = BehaviorSubject<StepData>.seeded(
    StepData.initial(),
  );

  StepTrackingStateModel? _cachedState;

  @override
  Stream<StepData> watchLiveSteps() => _liveSteps.stream;

  @override
  Future<void> startTracking() async {
    final available = await _native.isSensorAvailable();
    if (!available) {
      throw const CacheException('Step sensor unavailable on this device');
    }
    await _ensureBaselineForNow();
    final started = await _native.startTracking();
    if (!started) {
      throw const CacheException('Failed to start native step tracking');
    }
    final state = await _loadState();
    state.isTracking = true;
    state.isPaused = false;
    await _local.saveState(state);
    _cachedState = state;
    await _emitFromHardware(await _native.getHardwareTotal(), StepSource.unknown);
    _logger.i('Step tracking started');
  }

  @override
  Future<void> stopTracking() async {
    await _native.stopTracking();
    final state = await _loadState();
    state.isTracking = false;
    state.isPaused = false;
    await _local.saveState(state);
    _cachedState = state;
    _liveSteps.add(
      _liveSteps.value.copyWith(status: TrackingStatus.stopped),
    );
    _logger.i('Step tracking stopped');
  }

  @override
  Future<void> pauseTracking() async {
    await _native.pauseTracking();
    final state = await _loadState();
    state.isPaused = true;
    await _local.saveState(state);
    _cachedState = state;
    _liveSteps.add(_liveSteps.value.copyWith(status: TrackingStatus.paused));
  }

  @override
  Future<void> resumeTracking() async {
    await _native.resumeTracking();
    final state = await _loadState();
    state.isPaused = false;
    state.isTracking = true;
    await _local.saveState(state);
    _cachedState = state;
    _liveSteps.add(_liveSteps.value.copyWith(status: TrackingStatus.tracking));
  }

  @override
  Future<void> resetTodaySteps() async {
    final now = DateTime.now();
    final hardware = await _native.getHardwareTotal();
    final state = await _loadState();
    state
      ..dailyBaseline = StepBaselineCalculator.newDayBaseline(hardware)
      ..lastHardwareTotal = hardware
      ..baselineDate = StepBaselineCalculator.localDate(now)
      ..timezoneId = now.timeZoneName
      ..manualAdjustment = 0;
    await _local.saveState(state);
    _cachedState = state;
    await _local.clearTodayRecords(now);
    await _emitFromHardware(hardware, StepSource.manual);
    _logger.i('Today steps reset');
  }

  @override
  Future<void> adjustSteps(int adjustment) async {
    final state = await _loadState();
    state.manualAdjustment += adjustment;
    await _local.saveState(state);
    _cachedState = state;
    await _emitFromHardware(state.lastHardwareTotal, StepSource.manual);
  }

  @override
  Future<int> getTodaySteps() async {
    return _liveSteps.valueOrNull?.todaySteps ??
        await _local.getTodayStepsFromDailyRecord(DateTime.now());
  }

  @override
  Future<List<StepPeriodSummary>> getWeeklySteps() async {
    final end = StepBaselineCalculator.localDate(DateTime.now());
    final start = end.subtract(const Duration(days: 6));
    return _local.getDailySummaries(start: start, end: end);
  }

  @override
  Future<List<StepPeriodSummary>> getMonthlySteps() async {
    final now = DateTime.now();
    final end = StepBaselineCalculator.localDate(now);
    final start = DateTime(now.year, now.month, 1);
    return _local.getDailySummaries(start: start, end: end);
  }

  @override
  Future<List<HourlyStepPoint>> getTodayHourlySteps() {
    return _local.getTodayHourlySteps(DateTime.now());
  }

  @override
  Future<List<HourlyStepPoint>> getHourlyStepsForDate(DateTime date) {
    return _local.getHourlyStepsForDate(date);
  }

  @override
  Future<List<StepPeriodSummary>> getDailySummaries({
    required DateTime start,
    required DateTime end,
  }) {
    return _local.getDailySummaries(start: start, end: end);
  }

  @override
  Future<int> getLifetimeSteps() async {
    final start = DateTime(2000);
    final end = DateTime.now();
    final records = await _local.getDailySummaries(start: start, end: end);
    return records.fold<int>(0, (sum, r) => sum + r.steps);
  }

  Future<void> _onNativeEvent(StepCounterNativeEvent event) async {
    if (_cachedState?.isPaused ?? false) return;
    await _processHardwareReading(
      event.hardwareTotal,
      StepSource.fromNative(event.source),
      DateTime.fromMillisecondsSinceEpoch(event.timestampMs),
    );
  }

  Future<void> _processHardwareReading(
    int hardwareTotal,
    StepSource source,
    DateTime timestamp,
  ) async {
    final state = await _ensureBaselineForMoment(timestamp, hardwareTotal);
    final previousHardware = state.lastHardwareTotal;
    state.lastHardwareTotal = hardwareTotal;
    await _local.saveState(state);
    _cachedState = state;
    await _emitFromHardware(hardwareTotal, source, timestamp: timestamp, state: state);
    await _persistAggregates(
      state,
      hardwareTotal,
      timestamp,
      previousHardware: previousHardware,
    );
  }

  Future<void> _emitFromHardware(
    int hardwareTotal,
    StepSource source, {
    DateTime? timestamp,
    StepTrackingStateModel? state,
  }) async {
    final activeState = state ?? await _loadState();
    final now = timestamp ?? DateTime.now();
    final todaySteps = StepBaselineCalculator.dailySteps(
      hardwareTotal: hardwareTotal,
      dailyBaseline: activeState.dailyBaseline,
      manualAdjustment: activeState.manualAdjustment,
    );
    final status = !activeState.isTracking
        ? TrackingStatus.idle
        : activeState.isPaused
            ? TrackingStatus.paused
            : TrackingStatus.tracking;

    _liveSteps.add(
      StepData(
        todaySteps: todaySteps,
        hardwareTotal: hardwareTotal,
        timestamp: now,
        source: source,
        status: status,
        manualAdjustment: activeState.manualAdjustment,
      ),
    );
  }

  Future<void> _persistAggregates(
    StepTrackingStateModel state,
    int hardwareTotal,
    DateTime timestamp, {
    required int previousHardware,
  }) async {
    final delta = hardwareTotal > previousHardware ? hardwareTotal - previousHardware : 0;

    final todaySteps = StepBaselineCalculator.dailySteps(
      hardwareTotal: hardwareTotal,
      dailyBaseline: state.dailyBaseline,
      manualAdjustment: state.manualAdjustment,
    );
    await _local.upsertDailySteps(
      date: timestamp,
      steps: todaySteps,
      hardwareBaseline: state.dailyBaseline,
      hardwareTotalEnd: hardwareTotal,
    );
    if (delta > 0) {
      final hourStart = DateTime(
        timestamp.year,
        timestamp.month,
        timestamp.day,
        timestamp.hour,
      );
      await _local.addHourlyDelta(hourStart: hourStart, delta: delta);
    }
  }

  Future<StepTrackingStateModel> _ensureBaselineForNow() {
    return _ensureBaselineForMoment(DateTime.now(), null);
  }

  Future<StepTrackingStateModel> _ensureBaselineForMoment(
    DateTime moment,
    int? hardwareTotal,
  ) async {
    final state = await _loadState();
    final timezone = moment.timeZoneName;
    final newDay = StepBaselineCalculator.isNewLocalDay(
      storedDate: state.baselineDate,
      now: moment,
      storedTimezone: state.timezoneId,
      currentTimezone: timezone,
    );

    if (hardwareTotal != null &&
        hardwareTotal < state.lastHardwareTotal &&
        !newDay) {
      state.dailyBaseline = StepBaselineCalculator.baselineAfterHardwareReset(
        lastHardwareTotal: state.lastHardwareTotal,
        lastDailyBaseline: state.dailyBaseline,
        newHardwareTotal: hardwareTotal,
      );
    }

    if (newDay) {
      final baselineHardware = hardwareTotal ?? state.lastHardwareTotal;
      state
        ..baselineDate = StepBaselineCalculator.localDate(moment)
        ..dailyBaseline = StepBaselineCalculator.newDayBaseline(baselineHardware)
        ..timezoneId = timezone
        ..manualAdjustment = 0;
    }

    return state;
  }

  Future<StepTrackingStateModel> _loadState() async {
    _cachedState ??= await _local.getOrCreateState();
    return _cachedState!;
  }
}
