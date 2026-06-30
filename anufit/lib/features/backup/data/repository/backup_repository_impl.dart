import 'package:injectable/injectable.dart';

import 'package:anufit/core/backup_engine/backup_engine.dart';
import 'package:anufit/features/backup/domain/repository/backup_repository.dart';

@LazySingleton(as: BackupRepository)
class BackupRepositoryImpl implements BackupRepository {
  BackupRepositoryImpl(this._engine);

  final BackupEngine _engine;

  @override
  Future<BackupFile> exportBackup({bool encrypt = true, String? passphrase}) =>
      _engine.exportBackup(encrypt: encrypt, passphrase: passphrase);

  @override
  Future<void> restoreBackup(String path, {String? passphrase}) =>
      _engine.importBackup(path, passphrase: passphrase);
}
