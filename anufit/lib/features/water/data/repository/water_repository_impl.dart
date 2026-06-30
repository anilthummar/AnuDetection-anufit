import 'package:injectable/injectable.dart';

import 'package:anufit/features/water/data/datasource/water_local_datasource.dart';
import 'package:anufit/features/water/data/models/water_entry_model.dart';
import 'package:anufit/features/water/domain/entities/water_entity.dart';
import 'package:anufit/features/water/domain/repository/water_repository.dart';

@LazySingleton(as: WaterRepository)
class WaterRepositoryImpl implements WaterRepository {
  WaterRepositoryImpl(this._local);

  final WaterLocalDatasource _local;

  @override
  Future<WaterDashboardEntity> getDashboard() async {
    final todayMl = await _local.getTodayTotalMl();
    final goal = await _local.getGoal();
    final history = await _local.getEntriesForDate(DateTime.now());

    return WaterDashboardEntity(
      todayMl: todayMl,
      goalLiters: goal.dailyGoalLiters,
      history: history.map(_toEntity).toList(),
    );
  }

  @override
  Future<void> addWater({required int amountMl, String? source, String? note}) =>
      _local.addEntry(amountMl: amountMl, source: source, note: note);

  @override
  Future<void> setDailyGoalLiters(double liters) => _local.setGoalLiters(liters);

  WaterEntryEntity _toEntity(WaterEntryModel m) => WaterEntryEntity(
        id: m.id,
        date: m.date,
        time: m.time,
        amountMl: m.amountMl,
        source: m.source,
        note: m.note,
      );
}
