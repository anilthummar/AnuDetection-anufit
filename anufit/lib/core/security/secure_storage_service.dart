import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SecureStorageService {
  SecureStorageService() : _storage = const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  static const _backupKeyId = 'anufit_backup_aes_key';
  static const _encryptionEnabledId = 'anufit_encryption_enabled';

  Future<String?> read(String key) => _storage.read(key: key);

  Future<void> write(String key, String value) => _storage.write(key: key, value: value);

  Future<void> delete(String key) => _storage.delete(key: key);

  Future<String> getOrCreateBackupKey() async {
    final existing = await _storage.read(key: _backupKeyId);
    if (existing != null && existing.isNotEmpty) return existing;
    final key = _generateKey();
    await _storage.write(key: _backupKeyId, value: key);
    return key;
  }

  Future<bool> isEncryptionEnabled() async {
    final value = await _storage.read(key: _encryptionEnabledId);
    return value == 'true';
  }

  Future<void> setEncryptionEnabled(bool enabled) =>
      _storage.write(key: _encryptionEnabledId, value: enabled.toString());

  String _generateKey() {
    final bytes = List<int>.generate(32, (i) => (DateTime.now().microsecondsSinceEpoch + i) % 256);
    return bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  }
}
