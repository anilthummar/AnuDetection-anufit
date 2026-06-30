import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:injectable/injectable.dart';

import 'package:anufit/core/security/secure_storage_service.dart';

@lazySingleton
class EncryptionService {
  EncryptionService(this._secureStorage);

  final SecureStorageService _secureStorage;

  Future<String> encryptJson(String json, {String? passphrase}) async {
    final key = await _resolveKey(passphrase);
    final iv = enc.IV.fromSecureRandom(16);
    final encrypter = enc.Encrypter(enc.AES(key));
    final encrypted = encrypter.encrypt(json, iv: iv);
    return jsonEncode({
      'iv': base64Encode(iv.bytes),
      'data': encrypted.base64,
    });
  }

  Future<String> decryptJson(String payload, {String? passphrase}) async {
    final map = jsonDecode(payload) as Map<String, dynamic>;
    final key = await _resolveKey(passphrase);
    final iv = enc.IV(base64Decode(map['iv'] as String));
    final encrypter = enc.Encrypter(enc.AES(key));
    return encrypter.decrypt64(map['data'] as String, iv: iv);
  }

  String deriveKeyFromPassphrase(String passphrase, {String salt = 'anufit'}) {
    final digest = sha256.convert(utf8.encode('$salt:$passphrase'));
    return digest.toString().substring(0, 32);
  }

  Future<enc.Key> _resolveKey(String? passphrase) async {
    if (passphrase != null && passphrase.isNotEmpty) {
      final derived = deriveKeyFromPassphrase(passphrase);
      return enc.Key(Uint8List.fromList(utf8.encode(derived)));
    }
    final stored = await _secureStorage.getOrCreateBackupKey();
    final padded = stored.padRight(32, '0').substring(0, 32);
    return enc.Key(Uint8List.fromList(utf8.encode(padded)));
  }
}
