import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:anufit/core/exceptions/app_exception.dart';
import 'package:anufit/core/usecase/usecase.dart';
import 'package:anufit/features/step_counter/domain/entities/step_data.dart';
import 'package:anufit/features/step_counter/domain/usecases/step_usecases.dart';
import 'package:anufit/features/step_counter/presentation/bloc/step_tracking_bloc.dart';

class MockStartStepTrackingUseCase extends Mock implements StartStepTrackingUseCase {}

class MockStopStepTrackingUseCase extends Mock implements StopStepTrackingUseCase {}

class MockPauseTrackingUseCase extends Mock implements PauseTrackingUseCase {}

class MockResumeTrackingUseCase extends Mock implements ResumeTrackingUseCase {}

class MockResetTodayStepsUseCase extends Mock implements ResetTodayStepsUseCase {}

class MockAdjustStepsUseCase extends Mock implements AdjustStepsUseCase {}

class MockGetTodayStepsUseCase extends Mock implements GetTodayStepsUseCase {}

class MockGetWeeklyStepsUseCase extends Mock implements GetWeeklyStepsUseCase {}

class MockGetMonthlyStepsUseCase extends Mock implements GetMonthlyStepsUseCase {}

class MockWatchLiveStepsUseCase extends Mock implements WatchLiveStepsUseCase {}

void main() {
  late MockStartStepTrackingUseCase startTracking;
  late MockStopStepTrackingUseCase stopTracking;
  late MockPauseTrackingUseCase pauseTracking;
  late MockResumeTrackingUseCase resumeTracking;
  late MockResetTodayStepsUseCase resetTodaySteps;
  late MockAdjustStepsUseCase adjustSteps;
  late MockGetTodayStepsUseCase getTodaySteps;
  late MockGetWeeklyStepsUseCase getWeeklySteps;
  late MockGetMonthlyStepsUseCase getMonthlySteps;
  late MockWatchLiveStepsUseCase watchLiveSteps;

  final liveData = StepData(
    todaySteps: 10,
    hardwareTotal: 100,
    timestamp: DateTime(2026, 6, 29),
    source: StepSource.stepCounter,
    status: TrackingStatus.tracking,
  );

  StepTrackingBloc buildBloc() {
    return StepTrackingBloc(
      startTracking,
      stopTracking,
      pauseTracking,
      resumeTracking,
      resetTodaySteps,
      adjustSteps,
      getTodaySteps,
      getWeeklySteps,
      getMonthlySteps,
      watchLiveSteps,
    );
  }

  setUpAll(() {
    registerFallbackValue(const NoParams());
    registerFallbackValue(const AdjustStepsParams(0));
  });

  setUp(() {
    startTracking = MockStartStepTrackingUseCase();
    stopTracking = MockStopStepTrackingUseCase();
    pauseTracking = MockPauseTrackingUseCase();
    resumeTracking = MockResumeTrackingUseCase();
    resetTodaySteps = MockResetTodayStepsUseCase();
    adjustSteps = MockAdjustStepsUseCase();
    getTodaySteps = MockGetTodayStepsUseCase();
    getWeeklySteps = MockGetWeeklyStepsUseCase();
    getMonthlySteps = MockGetMonthlyStepsUseCase();
    watchLiveSteps = MockWatchLiveStepsUseCase();

    when(() => watchLiveSteps(any())).thenAnswer((_) => Stream.value(liveData));
    when(() => startTracking(any())).thenAnswer((_) async {});
    when(() => stopTracking(any())).thenAnswer((_) async {});
    when(() => pauseTracking(any())).thenAnswer((_) async {});
    when(() => resumeTracking(any())).thenAnswer((_) async {});
    when(() => resetTodaySteps(any())).thenAnswer((_) async {});
    when(() => adjustSteps(any())).thenAnswer((_) async {});
    when(() => getTodaySteps(any())).thenAnswer((_) async => 10);
    when(() => getWeeklySteps(any())).thenAnswer((_) async => const []);
    when(() => getMonthlySteps(any())).thenAnswer((_) async => const []);
  });

  blocTest<StepTrackingBloc, StepTrackingState>(
    'emits live updates from watch stream',
    build: buildBloc,
    wait: const Duration(milliseconds: 10),
    expect: () => [
      isA<StepTrackingState>().having((s) => s.liveData.todaySteps, 'steps', 10),
    ],
  );

  blocTest<StepTrackingBloc, StepTrackingState>(
    'start tracking clears busy flag on success',
    build: buildBloc,
    skip: 1,
    act: (bloc) => bloc.add(const StepTrackingStartRequested()),
    verify: (bloc) {
      expect(bloc.state.isBusy, isFalse);
      verify(() => startTracking(any())).called(1);
    },
  );

  blocTest<StepTrackingBloc, StepTrackingState>(
    'start tracking surfaces repository errors',
    build: () {
      when(() => startTracking(any())).thenThrow(const CacheException('sensor down'));
      when(() => watchLiveSteps(any())).thenAnswer((_) => const Stream<StepData>.empty());
      return buildBloc();
    },
    act: (bloc) => bloc.add(const StepTrackingStartRequested()),
    verify: (bloc) {
      expect(bloc.state.errorMessage, 'sensor down');
      expect(bloc.state.isBusy, isFalse);
    },
  );
}
