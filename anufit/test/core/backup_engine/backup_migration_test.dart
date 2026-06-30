import 'package:anufit/core/backup_engine/backup_migration.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BackupMigration', () {
    test('migrates legacy snapshot to v1', () {
      final migrated = BackupMigration.migrate({'collections': {'users': []}});
      expect(migrated['version'], BackupMigration.currentVersion);
      expect(migrated['collections'], isNotNull);
    });

    test('preserves current version snapshots', () {
      final input = {
        'version': 1,
        'collections': {'users': []},
      };
      final migrated = BackupMigration.migrate(input);
      expect(migrated['version'], 1);
    });
  });
}
