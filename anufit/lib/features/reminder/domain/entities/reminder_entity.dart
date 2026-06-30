import 'package:equatable/equatable.dart';

enum ReminderType {
  walking,
  water,
  standUp,
  goal,
  weight,
  custom,
}

enum ReminderRepeat { once, daily, weekly, monthly, custom }

class ReminderEntity extends Equatable {
  const ReminderEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.repeat,
    required this.hour,
    required this.minute,
    required this.enabled,
    required this.notificationId,
  });

  final int id;
  final String title;
  final String description;
  final ReminderType type;
  final ReminderRepeat repeat;
  final int hour;
  final int minute;
  final bool enabled;
  final int notificationId;

  @override
  List<Object?> get props =>
      [id, title, description, type, repeat, hour, minute, enabled, notificationId];
}
