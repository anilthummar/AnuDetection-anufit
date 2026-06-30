import 'package:anufit/core/security/encryption_service.dart';
import 'package:anufit/core/security/secure_storage_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockSecureStorage extends Mock implements SecureStorageService {}

void main() {
  late EncryptionService encryption;
  late _MockSecureStorage storage;

  setUp(() {
    storage = _MockSecureStorage();
    when(() => storage.getOrCreateBackupKey()).thenAnswer((_) async => 'a' * 32);
    encryption = EncryptionService(storage);
  });

  test('encrypts and decrypts json roundtrip', () async {
    const payload = '{"hello":"world"}';
    final encrypted = await encryption.encryptJson(payload);
    final decrypted = await encryption.decryptJson(encrypted);
    expect(decrypted, payload);
  });

  test('passphrase derives stable key', () {
    final a = encryption.deriveKeyFromPassphrase('secret');
    final b = encryption.deriveKeyFromPassphrase('secret');
    expect(a, b);
    expect(a.length, 32);
  });
}
