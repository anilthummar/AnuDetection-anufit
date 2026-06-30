import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

import 'package:anufit/features/history/data/datasource/history_local_datasource.dart';
import 'package:anufit/features/history/data/models/daily_summary_model.dart';
import 'package:anufit/features/history/domain/entities/history_entity.dart';
import 'package:anufit/features/history/domain/repository/history_repository.dart';
import 'package:anufit/features/history/domain/services/analytics_engine.dart';

@LazySingleton(as: HistoryRepository)
class HistoryRepositoryImpl implements HistoryRepository {
  HistoryRepositoryImpl(this._local, this._analytics);

  final HistoryLocalDatasource _local;
  final AnalyticsEngine _analytics;

  @override
  Future<void> ensureSynced({HistoryFilter? filter}) async {
    final range = _resolveRange(filter ?? HistoryFilter.last30Days, null, null);
    await _analytics.syncRecent(days: range.end.difference(range.start).inDays + 1);
  }

  @override
  Future<HistoryPageResult> getDailyHistory({
    required HistoryFilter filter,
    DateTime? customStart,
    DateTime? customEnd,
    HistorySearchQuery? search,
    int page = 0,
    int pageSize = 20,
  }) async {
    await ensureSynced(filter: filter);
    final range = _resolveRange(filter, customStart, customEnd);
    final offset = page * pageSize;
    final models = await _local.searchDaily(
      start: range.start,
      end: range.end,
      search: search,
      offset: offset,
      limit: pageSize + 1,
    );

    final hasMore = models.length > pageSize;
    final items = models.take(pageSize).map(_toEntity).toList();

    return HistoryPageResult(items: items, hasMore: hasMore, page: page);
  }

  @override
  Future<AggregatedHistoryEntity> getWeeklyHistory({int? week, int? year}) async {
    final now = DateTime.now();
    final w = week ?? AnalyticsEngine.isoWeek(now);
    final y = year ?? now.year;
    await _analytics.syncForDate(now);
    final model = await _local.getWeekly(w, y);
    if (model == null) {
      return AggregatedHistoryEntity(
        label: 'Week $w',
        steps: 0,
        distanceKm: 0,
        calories: 0,
        walkingTime: Duration.zero,
      );
    }
    return AggregatedHistoryEntity(
      label: 'Week $w',
      steps: model.steps,
      distanceKm: model.distanceKm,
      calories: model.calories,
      walkingTime: Duration(minutes: model.walkingTimeMinutes),
    );
  }

  @override
  Future<AggregatedHistoryEntity> getMonthlyHistory({int? month, int? year}) async {
    final now = DateTime.now();
    final m = month ?? now.month;
    final y = year ?? now.year;
    await _analytics.syncForDate(now);
    final model = await _local.getMonthly(m, y);
    final label = DateFormat('MMMM yyyy').format(DateTime(y, m));
    if (model == null) {
      return AggregatedHistoryEntity(
        label: label,
        steps: 0,
        distanceKm: 0,
        calories: 0,
        walkingTime: Duration.zero,
      );
    }
    return AggregatedHistoryEntity(
      label: label,
      steps: model.steps,
      distanceKm: model.distanceKm,
      calories: model.calories,
      walkingTime: Duration(minutes: model.walkingTimeMinutes),
    );
  }

  @override
  Future<AggregatedHistoryEntity> getYearlyHistory({int? year}) async {
    final y = year ?? DateTime.now().year;
    await ensureSynced();
    final months = await _local.getMonthlyForYear(y);
    var steps = 0;
    var distance = 0.0;
    var calories = 0.0;
    var walkingMinutes = 0;
    for (final m in months) {
      steps += m.steps;
      distance += m.distanceKm;
      calories += m.calories;
      walkingMinutes += m.walkingTimeMinutes;
    }
    return AggregatedHistoryEntity(
      label: '$y',
      steps: steps,
      distanceKm: distance,
      calories: calories,
      walkingTime: Duration(minutes: walkingMinutes),
    );
  }

  @override
  Future<List<DateTime>> getActiveDates({
    required DateTime start,
    required DateTime end,
  }) async {
    final models = await _local.getDailyRange(start: start, end: end, limit: 400);
    return models.where((m) => m.steps > 0).map((m) => m.date).toList();
  }

  DailySummaryEntity _toEntity(DailySummaryModel m) => DailySummaryEntity(
        date: m.date,
        steps: m.steps,
        distanceKm: m.distanceKm,
        calories: m.calories,
        walkingTime: Duration(minutes: m.walkingTimeMinutes),
        goalCompleted: m.goalCompleted,
      );

  ({DateTime start, DateTime end}) _resolveRange(
    HistoryFilter filter,
    DateTime? customStart,
    DateTime? customEnd,
  ) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return switch (filter) {
      HistoryFilter.today => (start: today, end: today),
      HistoryFilter.yesterday => (
          start: today.subtract(const Duration(days: 1)),
          end: today.subtract(const Duration(days: 1)),
        ),
      HistoryFilter.last7Days => (
          start: today.subtract(const Duration(days: 6)),
          end: today,
        ),
      HistoryFilter.last30Days => (
          start: today.subtract(const Duration(days: 29)),
          end: today,
        ),
      HistoryFilter.thisMonth => (
          start: DateTime(today.year, today.month, 1),
          end: today,
        ),
      HistoryFilter.thisYear => (
          start: DateTime(today.year, 1, 1),
          end: today,
        ),
      HistoryFilter.custom => (
          start: customStart ?? today.subtract(const Duration(days: 29)),
          end: customEnd ?? today,
        ),
    };
  }
}
