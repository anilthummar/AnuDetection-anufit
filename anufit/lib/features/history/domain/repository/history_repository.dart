import 'package:anufit/features/history/domain/entities/history_entity.dart';

abstract class HistoryRepository {
  Future<HistoryPageResult> getDailyHistory({
    required HistoryFilter filter,
    DateTime? customStart,
    DateTime? customEnd,
    HistorySearchQuery? search,
    int page = 0,
    int pageSize = 20,
  });

  Future<AggregatedHistoryEntity> getWeeklyHistory({int? week, int? year});

  Future<AggregatedHistoryEntity> getMonthlyHistory({int? month, int? year});

  Future<AggregatedHistoryEntity> getYearlyHistory({int? year});

  Future<List<DateTime>> getActiveDates({
    required DateTime start,
    required DateTime end,
  });

  Future<void> ensureSynced({HistoryFilter? filter});
}
