
enum DataSourceType {
  manualAdjustment,
  nativeStepCounter,
  localAnalytics,
  healthPlatform,
  cloudBackup,
}

/// Defines priority order when multiple sources report different values.
abstract final class DataSourcePriorityManager {
  static const List<DataSourceType> priority = [
    DataSourceType.manualAdjustment,
    DataSourceType.nativeStepCounter,
    DataSourceType.localAnalytics,
    DataSourceType.healthPlatform,
    DataSourceType.cloudBackup,
  ];

  static int resolveSteps({
    required Map<DataSourceType, int> values,
  }) {
    for (final source in priority) {
      final value = values[source];
      if (value != null && value > 0) {
        return value;
      }
    }
    return 0;
  }

  static bool shouldImportFromHealth({
    required int localSteps,
    required int healthSteps,
    required DataSourceType localSource,
  }) {
    final localIndex = priority.indexOf(localSource);
    final healthIndex = priority.indexOf(DataSourceType.healthPlatform);
    if (healthSteps > localSteps) return true;
    return healthIndex < localIndex;
  }
}
