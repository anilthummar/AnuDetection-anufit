import 'package:anufit/features/reminder/domain/entities/reminder_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ReminderEntity', () {
    test('supports all reminder types', () {
      expect(ReminderType.values.length, 6);
      expect(ReminderType.walking.name, 'walking');
      expect(ReminderType.standUp.name, 'standUp');
    });

    test('equality includes schedule fields', () {
      const a = ReminderEntity(
        id: 1,
        title: 'Water',
        description: 'Drink',
        type: ReminderType.water,
        repeat: ReminderRepeat.daily,
        hour: 9,
        minute: 30,
        enabled: true,
        notificationId: 3001,
      );
      const b = ReminderEntity(
        id: 1,
        title: 'Water',
        description: 'Drink',
        type: ReminderType.water,
        repeat: ReminderRepeat.daily,
        hour: 9,
        minute: 30,
        enabled: true,
        notificationId: 3001,
      );
      expect(a, equals(b));
    });
  });
}
