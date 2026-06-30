import 'package:injectable/injectable.dart';
import 'package:isar_community/isar.dart';

import 'package:anufit/core/database/isar_service.dart';
import 'package:anufit/features/water/data/models/water_entry_model.dart';
import 'package:anufit/features/water/data/models/water_goal_model.dart';

@lazySingleton
class WaterLocalDatasource {
  WaterLocalDatasource(this._isar);

  final IsarService _isar;

  DateTime _dayStart(DateTime date) => DateTime(date.year, date.month, date.day);

  Future<void> addEntry({
    required int amountMl,
    String? source,
    String? note,
    DateTime? when,
  }) async {
    final now = when ?? DateTime.now();
    await _isar.db.writeTxn(() async {
      await _isar.db.waterEntryModels.put(
        WaterEntryModel()
          ..date = _dayStart(now)
          ..time = now
          ..amountMl = amountMl
          ..source = source
          ..note = note,
      );
    });
  }

  Future<List<WaterEntryModel>> getEntriesForDate(DateTime date) {
    final start = _dayStart(date);
    final end = start.add(const Duration(days: 1));
    return _isar.db.waterEntryModels
        .filter()
        .dateBetween(start, end.subtract(const Duration(milliseconds: 1)))
        .sortByTimeDesc()
        .findAll();
  }

  Future<int> getTodayTotalMl() async {
    final entries = await getEntriesForDate(DateTime.now());
    return entries.fold<int>(0, (sum, e) => sum + e.amountMl);
  }

  Future<WaterGoalModel> getGoal() async {
    final existing = await _isar.db.waterGoalModels.get(1);
    if (existing != null) return existing;
    final goal = WaterGoalModel()
      ..dailyGoalLiters = 2.0
      ..updatedAt = DateTime.now();
    await _isar.db.writeTxn(() async {
      await _isar.db.waterGoalModels.put(goal);
    });
    return goal;
  }

  Future<void> setGoalLiters(double liters) async {
    await _isar.db.writeTxn(() async {
      final goal = await getGoal();
      goal
        ..dailyGoalLiters = liters
        ..updatedAt = DateTime.now();
      await _isar.db.waterGoalModels.put(goal);
    });
  }
}
