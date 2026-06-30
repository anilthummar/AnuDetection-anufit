import 'package:anufit/features/health/domain/entities/health_entity.dart';

/// Resolves conflicts between local and platform health data.
abstract final class ConflictResolver {
  /// Prefer the higher validated step total; never decrease below manual adjustments.
  static ConflictResolution resolveSteps({
    required DateTime date,
    required int localSteps,
    required int remoteSteps,
    int manualAdjustment = 0,
  }) {
    final localEffective = localSteps;
    final remoteEffective = remoteSteps;

    if (localEffective == remoteEffective) {
      return ConflictResolution(
        date: date,
        localSteps: localSteps,
        remoteSteps: remoteSteps,
        resolvedSteps: localEffective,
        reason: 'values_match',
      );
    }

    final resolved = remoteEffective > localEffective ? remoteEffective : localEffective;
  final withManual = resolved < manualAdjustment ? manualAdjustment : resolved;

    return ConflictResolution(
      date: date,
      localSteps: localSteps,
      remoteSteps: remoteSteps,
      resolvedSteps: withManual,
      reason: remoteEffective > localEffective ? 'prefer_higher_remote' : 'prefer_higher_local',
    );
  }
}
