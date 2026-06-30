import 'package:injectable/injectable.dart';

import 'package:anufit/core/services/reminder_scheduler.dart';
import 'package:anufit/features/reminder/data/datasource/reminder_local_datasource.dart';
import 'package:anufit/features/reminder/data/models/reminder_model.dart';
import 'package:anufit/features/reminder/domain/entities/reminder_entity.dart';
import 'package:anufit/features/reminder/domain/repository/reminder_repository.dart';

@LazySingleton(as: ReminderRepository)
class ReminderRepositoryImpl implements ReminderRepository {
  ReminderRepositoryImpl(this._local, this._scheduler);

  final ReminderLocalDatasource _local;
  final ReminderScheduler _scheduler;

  @override
  Future<List<ReminderEntity>> getReminders() async {
    await _local.ensureDefaults();
    final models = await _local.getAll();
    return models.map(_toEntity).toList();
  }

  @override
  Future<ReminderEntity> saveReminder(ReminderEntity reminder) async {
    final saved = await _local.save(_fromEntity(reminder));
    final entity = _toEntity(saved);
    if (entity.enabled) {
      await _scheduler.schedule(entity);
    } else {
      await _scheduler.cancel(entity.notificationId);
    }
    return entity;
  }

  @override
  Future<void> deleteReminder(int id) async {
    final all = await _local.getAll();
    final match = all.where((m) => m.id == id).firstOrNull;
    if (match != null) {
      await _scheduler.cancel(match.notificationId);
    }
    await _local.delete(id);
  }

  @override
  Future<void> toggleReminder(int id, bool enabled) async {
    final all = await _local.getAll();
    final model = all.where((m) => m.id == id).firstOrNull;
    if (model == null) return;
    model.enabled = enabled;
    final entity = _toEntity(await _local.save(model));
    if (enabled) {
      await _scheduler.schedule(entity);
    } else {
      await _scheduler.cancel(entity.notificationId);
    }
  }

  @override
  Future<void> rescheduleAll() async {
    final reminders = await getReminders();
    await _scheduler.scheduleAll(reminders);
  }

  ReminderEntity _toEntity(ReminderModel m) => ReminderEntity(
        id: m.id,
        title: m.title,
        description: m.description,
        type: ReminderType.values.firstWhere(
          (t) => t.name == m.type || _legacyType(m.type) == t,
          orElse: () => ReminderType.custom,
        ),
        repeat: ReminderRepeat.values.firstWhere(
          (r) => r.name == m.repeat,
          orElse: () => ReminderRepeat.daily,
        ),
        hour: m.hour,
        minute: m.minute,
        enabled: m.enabled,
        notificationId: m.notificationId,
      );

  ReminderType _legacyType(String type) => switch (type) {
        'standUp' => ReminderType.standUp,
        _ => ReminderType.custom,
      };

  ReminderModel _fromEntity(ReminderEntity e) {
    return ReminderModel()
      ..id = e.id
      ..title = e.title
      ..description = e.description
      ..type = e.type.name
      ..repeat = e.repeat.name
      ..hour = e.hour
      ..minute = e.minute
      ..enabled = e.enabled
      ..notificationId = e.notificationId;
  }
}

extension _FirstOrNull<E> on Iterable<E> {
  E? get firstOrNull {
    final it = iterator;
    if (!it.moveNext()) return null;
    return it.current;
  }
}
