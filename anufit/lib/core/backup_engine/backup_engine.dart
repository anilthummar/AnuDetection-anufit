import 'dart:convert';
import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

import 'package:anufit/core/backup_engine/backup_migration.dart';
import 'package:anufit/core/backup_engine/backup_snapshot_collector.dart';
import 'package:anufit/core/security/encryption_service.dart';

class BackupFile {
  const BackupFile({required this.path, required this.encrypted, required this.sizeBytes});

  final String path;
  final bool encrypted;
  final int sizeBytes;
}

@lazySingleton
class BackupEngine {
  BackupEngine(this._collector, this._encryption);

  final BackupSnapshotCollector _collector;
  final EncryptionService _encryption;

  static const formatId = 'anufit-backup';

  Future<BackupFile> exportBackup({bool encrypt = true, String? passphrase}) async {
    final info = await PackageInfo.fromPlatform();
    final collections = await _collector.collect();
    final snapshot = {
      'format': formatId,
      'version': BackupMigration.currentVersion,
      'exportedAt': DateTime.now().toIso8601String(),
      'appVersion': info.version,
      'collections': collections,
    };
    final json = jsonEncode(snapshot);
    final dir = await getApplicationDocumentsDirectory();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final path = '${dir.path}/anufit_backup_$timestamp.json${encrypt ? '.enc' : ''}';
    final file = File(path);

    if (encrypt) {
      final encrypted = await _encryption.encryptJson(json, passphrase: passphrase);
      final wrapper = jsonEncode({'format': formatId, 'encrypted': true, 'payload': encrypted});
      await file.writeAsString(wrapper);
    } else {
      await file.writeAsString(json);
    }

    return BackupFile(path: path, encrypted: encrypt, sizeBytes: await file.length());
  }

  Future<void> importBackup(String filePath, {String? passphrase}) async {
    final raw = await File(filePath).readAsString();
    final decoded = jsonDecode(raw);
    late Map<String, dynamic> snapshot;

    if (decoded is Map<String, dynamic> && decoded['encrypted'] == true) {
      final payload = decoded['payload'] as String;
      final json = await _encryption.decryptJson(payload, passphrase: passphrase);
      snapshot = jsonDecode(json) as Map<String, dynamic>;
    } else if (decoded is Map<String, dynamic>) {
      snapshot = decoded;
    } else {
      throw const FormatException('Invalid backup file');
    }

    if (snapshot['format'] != formatId) {
      throw const FormatException('Unsupported backup format');
    }

    final migrated = BackupMigration.migrate(snapshot);
    final collections = migrated['collections'] as Map<String, dynamic>;
    await _collector.restore(collections);
  }
}
