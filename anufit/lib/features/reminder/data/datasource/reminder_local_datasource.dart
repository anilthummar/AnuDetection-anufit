import 'package:injectable/injectable.dart';
import 'package:isar_community/isar.dart';

import 'package:anufit/core/database/isar_service.dart';
import 'package:anufit/features/reminder/data/models/reminder_model.dart';

@lazySingleton
class ReminderLocalDatasource {
  ReminderLocalDatasource(this._isar);

  final IsarService _isar;
  int _nextNotificationId = 3000;

  Future<List<ReminderModel>> getAll() =>
      _isar.db.reminderModels.where().sortByHour().findAll();

  Future<ReminderModel> save(ReminderModel model) async {
    await _isar.db.writeTxn(() async {
      if (model.notificationId == 0) {
        model.notificationId = _nextNotificationId++;
      }
      await _isar.db.reminderModels.put(model);
    });
    return model;
  }

  Future<void> delete(int id) async {
    await _isar.db.writeTxn(() async {
      await _isar.db.reminderModels.delete(id);
    });
  }

  Future<void> ensureDefaults() async {
    final existing = await getAll();
    if (existing.isNotEmpty) return;

    final defaults = [
      _default('Time to walk!', 'Walking', 'walking', 'daily', 9, 0),
      _default('Drink some water 💧', 'Water', 'water', 'daily', 11, 0),
      _default("You've been inactive.", 'Stand Up', 'standUp', 'daily', 14, 0),
      _default('Only a few steps left.', 'Goal', 'goal', 'daily', 18, 0),
      _default("Log today's weight.", 'Weight', 'weight', 'daily', 8, 0),
    ];

    await _isar.db.writeTxn(() async {
      for (final d in defaults) {
        d.notificationId = _nextNotificationId++;
        await _isar.db.reminderModels.put(d);
      }
    });
  }

  ReminderModel _default(
    String title,
    String description,
    String type,
    String repeat,
    int hour,
    int minute,
  ) {
    return ReminderModel()
      ..title = title
      ..description = description
      ..type = type
      ..repeat = repeat
      ..hour = hour
      ..minute = minute
      ..enabled = true;
  }
}
