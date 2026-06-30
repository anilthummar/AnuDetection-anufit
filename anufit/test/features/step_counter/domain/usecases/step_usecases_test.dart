import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:anufit/core/usecase/usecase.dart';
import 'package:anufit/features/step_counter/domain/entities/step_data.dart';
import 'package:anufit/features/step_counter/domain/repository/step_repository.dart';
import 'package:anufit/features/step_counter/domain/usecases/step_usecases.dart';

class MockStepRepository extends Mock implements StepRepository {}

void main() {
  late MockStepRepository repository;

  setUp(() {
    repository = MockStepRepository();
  });

  group('Step use cases', () {
    test('StartStepTrackingUseCase delegates to repository', () async {
      when(() => repository.startTracking()).thenAnswer((_) async {});

      await StartStepTrackingUseCase(repository).call(const NoParams());

      verify(() => repository.startTracking()).called(1);
    });

    test('GetTodayStepsUseCase returns repository value', () async {
      when(() => repository.getTodaySteps()).thenAnswer((_) async => 321);

      final steps = await GetTodayStepsUseCase(repository).call(const NoParams());

      expect(steps, 321);
    });

    test('AdjustStepsUseCase forwards adjustment', () async {
      when(() => repository.adjustSteps(any())).thenAnswer((_) async {});

      await AdjustStepsUseCase(repository).call(const AdjustStepsParams(-10));

      verify(() => repository.adjustSteps(-10)).called(1);
    });

    test('WatchLiveStepsUseCase exposes repository stream', () async {
      final data = StepData(
        todaySteps: 42,
        hardwareTotal: 100,
        timestamp: DateTime(2026, 6, 29),
        source: StepSource.stepCounter,
        status: TrackingStatus.tracking,
      );
      when(() => repository.watchLiveSteps()).thenAnswer((_) => Stream.value(data));

      final event = await WatchLiveStepsUseCase(repository)
          .call(const NoParams())
          .first;

      expect(event.todaySteps, 42);
    });
  });
}
