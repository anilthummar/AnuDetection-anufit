import 'package:anufit/features/reminder/domain/entities/reminder_entity.dart';
import 'package:flutter/material.dart';

class ReminderTile extends StatelessWidget {
  const ReminderTile({
    required this.reminder,
    required this.onToggle,
    required this.onTap,
    super.key,
  });

  final ReminderEntity reminder;
  final ValueChanged<bool> onToggle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(_iconFor(reminder.type)),
      title: Text(reminder.title),
      subtitle: Text(
        '${reminder.hour.toString().padLeft(2, '0')}:${reminder.minute.toString().padLeft(2, '0')} · ${reminder.repeat.name}',
      ),
      trailing: Switch(value: reminder.enabled, onChanged: onToggle),
    );
  }

  IconData _iconFor(ReminderType type) => switch (type) {
        ReminderType.walking => Icons.directions_walk,
        ReminderType.water => Icons.water_drop,
        ReminderType.standUp => Icons.accessibility_new,
        ReminderType.goal => Icons.flag_outlined,
        ReminderType.weight => Icons.monitor_weight_outlined,
        ReminderType.custom => Icons.notifications_outlined,
      };
}

class SchedulePicker extends StatelessWidget {
  const SchedulePicker({
    required this.hour,
    required this.minute,
    required this.onChanged,
    super.key,
  });

  final int hour;
  final int minute;
  final void Function(int hour, int minute) onChanged;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () async {
        final picked = await showTimePicker(
          context: context,
          initialTime: TimeOfDay(hour: hour, minute: minute),
        );
        if (picked != null) onChanged(picked.hour, picked.minute);
      },
      icon: const Icon(Icons.schedule),
      label: Text('${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}'),
    );
  }
}
