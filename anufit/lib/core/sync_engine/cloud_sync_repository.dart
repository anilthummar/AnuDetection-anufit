/// Optional cloud sync providers. Offline-first: local DB remains source of truth.
abstract class CloudSyncRepository {
  String get providerName;

  Future<bool> isAvailable();

  Future<bool> isConnected();

  Future<void> connect();

  Future<void> disconnect();

  Future<String> uploadBackup(String localFilePath);

  Future<String?> downloadLatestBackup({required String destinationPath});
}

enum CloudSyncProvider { googleDrive, iCloud }
