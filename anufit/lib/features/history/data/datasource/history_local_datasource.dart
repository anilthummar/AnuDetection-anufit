import 'package:injectable/injectable.dart';
import 'package:isar_community/isar.dart';

import 'package:anufit/core/database/isar_service.dart';
import 'package:anufit/features/history/data/models/daily_summary_model.dart';
import 'package:anufit/features/history/data/models/monthly_summary_model.dart';
import 'package:anufit/features/history/data/models/weekly_summary_model.dart';
import 'package:anufit/features/history/domain/entities/history_entity.dart';
import 'package:anufit/features/step_counter/domain/services/step_baseline_calculator.dart';

@lazySingleton
class HistoryLocalDatasource {
  HistoryLocalDatasource(this._isarService);

  final IsarService _isarService;

  Future<void> upsertDaily(DailySummaryModel model) async {
    await _isarService.db.writeTxn(() async {
      final existing = await _isarService.db.dailySummaryModels
          .filter()
          .dateEqualTo(model.date)
          .findFirst();
      if (existing != null) {
        model.id = existing.id;
      }
      await _isarService.db.dailySummaryModels.put(model);
    });
  }

  Future<void> upsertWeekly(WeeklySummaryModel model) async {
    await _isarService.db.writeTxn(() async {
      final existing = await _isarService.db.weeklySummaryModels
          .filter()
          .weekEqualTo(model.week)
          .yearEqualTo(model.year)
          .findFirst();
      if (existing != null) {
        model.id = existing.id;
      }
      await _isarService.db.weeklySummaryModels.put(model);
    });
  }

  Future<void> upsertMonthly(MonthlySummaryModel model) async {
    await _isarService.db.writeTxn(() async {
      final existing = await _isarService.db.monthlySummaryModels
          .filter()
          .monthEqualTo(model.month)
          .yearEqualTo(model.year)
          .findFirst();
      if (existing != null) {
        model.id = existing.id;
      }
      await _isarService.db.monthlySummaryModels.put(model);
    });
  }

  Future<List<DailySummaryModel>> getDailyRange({
    required DateTime start,
    required DateTime end,
    int offset = 0,
    int limit = 30,
  }) async {
    final startDay = StepBaselineCalculator.localDate(start);
    final endDay = StepBaselineCalculator.localDate(end);
    return _isarService.db.dailySummaryModels
        .filter()
        .dateBetween(startDay, endDay)
        .sortByDateDesc()
        .offset(offset)
        .limit(limit)
        .findAll();
  }

  Future<int> countDailyRange({
    required DateTime start,
    required DateTime end,
    bool? goalCompleted,
    int? minSteps,
    int? maxSteps,
  }) async {
    final startDay = StepBaselineCalculator.localDate(start);
    final endDay = StepBaselineCalculator.localDate(end);
    var query = _isarService.db.dailySummaryModels.filter().dateBetween(startDay, endDay);
    if (goalCompleted != null) {
      query = query.goalCompletedEqualTo(goalCompleted);
    }
    if (minSteps != null) {
      query = query.stepsGreaterThan(minSteps - 1);
    }
    if (maxSteps != null) {
      query = query.stepsLessThan(maxSteps + 1);
    }
    return query.count();
  }

  Future<List<DailySummaryModel>> searchDaily({
    required DateTime start,
    required DateTime end,
    HistorySearchQuery? search,
    int offset = 0,
    int limit = 30,
  }) async {
    final startDay = StepBaselineCalculator.localDate(start);
    final endDay = StepBaselineCalculator.localDate(end);
    var query = _isarService.db.dailySummaryModels.filter().dateBetween(startDay, endDay);

    if (search?.date != null) {
      final day = StepBaselineCalculator.localDate(search!.date!);
      query = _isarService.db.dailySummaryModels.filter().dateEqualTo(day);
    } else {
      if (search?.goalCompleted != null) {
        query = query.goalCompletedEqualTo(search!.goalCompleted!);
      }
      if (search?.minSteps != null) {
        query = query.stepsGreaterThan(search!.minSteps! - 1);
      }
      if (search?.maxSteps != null) {
        query = query.stepsLessThan(search!.maxSteps! + 1);
      }
    }

    return query.sortByDateDesc().offset(offset).limit(limit).findAll();
  }

  Future<WeeklySummaryModel?> getWeekly(int week, int year) {
    return _isarService.db.weeklySummaryModels
        .filter()
        .weekEqualTo(week)
        .yearEqualTo(year)
        .findFirst();
  }

  Future<MonthlySummaryModel?> getMonthly(int month, int year) {
    return _isarService.db.monthlySummaryModels
        .filter()
        .monthEqualTo(month)
        .yearEqualTo(year)
        .findFirst();
  }

  Future<List<DailySummaryModel>> getAllDaily() {
    return _isarService.db.dailySummaryModels.where().sortByDate().findAll();
  }

  Future<List<WeeklySummaryModel>> getWeeklyForYear(int year) {
    return _isarService.db.weeklySummaryModels
        .filter()
        .yearEqualTo(year)
        .sortByWeek()
        .findAll();
  }

  Future<List<MonthlySummaryModel>> getMonthlyForYear(int year) {
    return _isarService.db.monthlySummaryModels
        .filter()
        .yearEqualTo(year)
        .sortByMonth()
        .findAll();
  }
}
