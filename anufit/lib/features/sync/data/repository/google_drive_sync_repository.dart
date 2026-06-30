import 'dart:io';

import 'package:injectable/injectable.dart';

import 'package:anufit/core/sync_engine/cloud_sync_repository.dart';

@lazySingleton
@Named('googleDrive')
class GoogleDriveSyncRepository implements CloudSyncRepository {
  @override
  String get providerName => 'Google Drive';

  @override
  Future<bool> isAvailable() async => Platform.isAndroid || Platform.isIOS;

  @override
  Future<bool> isConnected() async => false;

  @override
  Future<void> connect() async {
    throw UnimplementedError('Google Drive sync is planned for a future release');
  }

  @override
  Future<void> disconnect() async {}

  @override
  Future<String> uploadBackup(String localFilePath) async {
    throw UnimplementedError('Google Drive upload not yet configured');
  }

  @override
  Future<String?> downloadLatestBackup({required String destinationPath}) async {
    throw UnimplementedError('Google Drive download not yet configured');
  }
}
