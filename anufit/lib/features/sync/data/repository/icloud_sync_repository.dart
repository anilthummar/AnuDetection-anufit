import 'dart:io';

import 'package:injectable/injectable.dart';

import 'package:anufit/core/sync_engine/cloud_sync_repository.dart';

@lazySingleton
@Named('iCloud')
class ICloudSyncRepository implements CloudSyncRepository {
  @override
  String get providerName => 'iCloud';

  @override
  Future<bool> isAvailable() async => Platform.isIOS || Platform.isMacOS;

  @override
  Future<bool> isConnected() async => false;

  @override
  Future<void> connect() async {
    throw UnimplementedError('iCloud sync is planned for a future release');
  }

  @override
  Future<void> disconnect() async {}

  @override
  Future<String> uploadBackup(String localFilePath) async {
    throw UnimplementedError('iCloud upload not yet configured');
  }

  @override
  Future<String?> downloadLatestBackup({required String destinationPath}) async {
    throw UnimplementedError('iCloud download not yet configured');
  }
}
