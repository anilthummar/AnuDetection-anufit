import 'package:anufit/core/backup_engine/backup_engine.dart';

abstract class BackupRepository {
  Future<BackupFile> exportBackup({bool encrypt, String? passphrase});
  Future<void> restoreBackup(String path, {String? passphrase});
}
