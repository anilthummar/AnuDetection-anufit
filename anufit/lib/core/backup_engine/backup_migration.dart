abstract final class BackupMigration {
  static const int currentVersion = 1;

  static Map<String, dynamic> migrate(Map<String, dynamic> snapshot) {
    final version = snapshot['version'] as int? ?? 0;
    var data = snapshot;
    if (version < 1) {
      data = _toV1(data);
    }
    data['version'] = currentVersion;
    return data;
  }

  static Map<String, dynamic> _toV1(Map<String, dynamic> data) {
    return {
      'version': 1,
      'exportedAt': data['exportedAt'] ?? DateTime.now().toIso8601String(),
      'collections': data['collections'] ?? data,
    };
  }
}
