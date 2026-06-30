import 'package:injectable/injectable.dart';
import 'package:isar_community/isar.dart';

import 'package:anufit/core/database/isar_service.dart';
import 'package:anufit/features/step_counter/data/models/daily_step_record_model.dart';
import 'package:anufit/features/step_counter/data/models/hourly_step_record_model.dart';
import 'package:anufit/features/step_counter/domain/entities/hourly_step_point.dart';
import 'package:anufit/features/step_counter/data/models/step_tracking_state_model.dart';
import 'package:anufit/features/step_counter/domain/entities/step_data.dart';
import 'package:anufit/features/step_counter/domain/services/step_baseline_calculator.dart';

@lazySingleton
class StepLocalDatasource {
  StepLocalDatasource(this._isarService);

  final IsarService _isarService;

  Future<StepTrackingStateModel> getOrCreateState() async {
    final existing = await _isarService.db.stepTrackingStateModels.get(1);
    if (existing != null) return existing;

    final now = DateTime.now();
    final initial = StepTrackingStateModel()
      ..baselineDate = StepBaselineCalculator.localDate(now)
      ..timezoneId = now.timeZoneName;

    await _isarService.db.writeTxn(() async {
      await _isarService.db.stepTrackingStateModels.put(initial);
    });
    return initial;
  }

  Future<void> saveState(StepTrackingStateModel state) async {
    await _isarService.db.writeTxn(() async {
      await _isarService.db.stepTrackingStateModels.put(state);
    });
  }

  Future<void> addHourlyDelta({
    required DateTime hourStart,
    required int delta,
  }) async {
    if (delta <= 0) return;

    final truncated = DateTime(
      hourStart.year,
      hourStart.month,
      hourStart.day,
      hourStart.hour,
    );
    await _isarService.db.writeTxn(() async {
      final existing = await _isarService.db.hourlyStepRecordModels
          .filter()
          .hourStartEqualTo(truncated)
          .findFirst();
      if (existing != null) {
        existing.steps += delta;
        await _isarService.db.hourlyStepRecordModels.put(existing);
      } else {
        await _isarService.db.hourlyStepRecordModels.put(
          HourlyStepRecordModel()
            ..hourStart = truncated
            ..steps = delta,
        );
      }
    });
  }

  Future<void> upsertDailySteps({
    required DateTime date,
    required int steps,
    required int hardwareBaseline,
    required int hardwareTotalEnd,
  }) async {
    final day = StepBaselineCalculator.localDate(date);
    await _isarService.db.writeTxn(() async {
      final existing = await _isarService.db.dailyStepRecordModels
          .filter()
          .dateEqualTo(day)
          .findFirst();
      if (existing != null) {
        existing
          ..steps = steps
          ..hardwareBaseline = hardwareBaseline
          ..hardwareTotalEnd = hardwareTotalEnd;
        await _isarService.db.dailyStepRecordModels.put(existing);
      } else {
        await _isarService.db.dailyStepRecordModels.put(
          DailyStepRecordModel()
            ..date = day
            ..steps = steps
            ..hardwareBaseline = hardwareBaseline
            ..hardwareTotalEnd = hardwareTotalEnd,
        );
      }
    });
  }

  Future<int> getTodayStepsFromDailyRecord(DateTime now) async {
    final day = StepBaselineCalculator.localDate(now);
    final record = await _isarService.db.dailyStepRecordModels
        .filter()
        .dateEqualTo(day)
        .findFirst();
    return record?.steps ?? 0;
  }

  Future<List<StepPeriodSummary>> getDailySummaries({
    required DateTime start,
    required DateTime end,
  }) async {
    final records = await _isarService.db.dailyStepRecordModels
        .filter()
        .dateBetween(start, end)
        .sortByDate()
        .findAll();
    return records
        .map((r) => StepPeriodSummary(periodStart: r.date, steps: r.steps))
        .toList();
  }

  Future<List<HourlyStepPoint>> getTodayHourlySteps(DateTime now) async {
    return getHourlyStepsForDate(now);
  }

  Future<List<HourlyStepPoint>> getHourlyStepsForDate(DateTime date) async {
    final day = StepBaselineCalculator.localDate(date);
    final dayEnd = day.add(const Duration(days: 1));
    final records = await _isarService.db.hourlyStepRecordModels
        .filter()
        .hourStartGreaterThan(day.subtract(const Duration(seconds: 1)))
        .hourStartLessThan(dayEnd)
        .sortByHourStart()
        .findAll();
    return records
        .map((r) => HourlyStepPoint(hour: r.hourStart.hour, steps: r.steps))
        .toList();
  }

  Future<void> clearTodayRecords(DateTime now) async {
    final day = StepBaselineCalculator.localDate(now);
    final dayEnd = day.add(const Duration(days: 1));
    await _isarService.db.writeTxn(() async {
      final daily = await _isarService.db.dailyStepRecordModels
          .filter()
          .dateEqualTo(day)
          .findAll();
      await _isarService.db.dailyStepRecordModels
          .deleteAll(daily.map((e) => e.id).toList());

      final hourly = await _isarService.db.hourlyStepRecordModels
          .filter()
          .hourStartGreaterThan(day.subtract(const Duration(seconds: 1)))
          .hourStartLessThan(dayEnd)
          .findAll();
      await _isarService.db.hourlyStepRecordModels
          .deleteAll(hourly.map((e) => e.id).toList());
    });
  }
}
