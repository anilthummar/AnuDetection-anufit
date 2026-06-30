import 'package:flutter_test/flutter_test.dart';

import 'package:anufit/features/health/domain/entities/health_entity.dart';
import 'package:anufit/features/health/services/conflict_resolver.dart';
import 'package:anufit/features/health/services/data_source_priority_manager.dart';

void main() {
  test('ConflictResolver prefers higher step count', () {
    final resolution = ConflictResolver.resolveSteps(
      date: DateTime(2026, 6, 29),
      localSteps: 8250,
      remoteSteps: 8320,
    );
    expect(resolution.resolvedSteps, 8320);
    expect(resolution.reason, 'prefer_higher_remote');
  });

  test('ConflictResolver keeps local when higher', () {
    final resolution = ConflictResolver.resolveSteps(
      date: DateTime(2026, 6, 29),
      localSteps: 9000,
      remoteSteps: 8320,
    );
    expect(resolution.resolvedSteps, 9000);
    expect(resolution.reason, 'prefer_higher_local');
  });

  test('DataSourcePriorityManager prefers manual adjustment', () {
    final steps = DataSourcePriorityManager.resolveSteps(values: {
      DataSourceType.manualAdjustment: 500,
      DataSourceType.nativeStepCounter: 8000,
    });
    expect(steps, 500);
  });

  test('DataSourcePriorityManager imports health when higher', () {
    final shouldImport = DataSourcePriorityManager.shouldImportFromHealth(
      localSteps: 8000,
      healthSteps: 8500,
      localSource: DataSourceType.nativeStepCounter,
    );
    expect(shouldImport, isTrue);
  });
}
