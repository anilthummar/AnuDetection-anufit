import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:anufit/core/exceptions/app_exception.dart';
import 'package:anufit/core/logger/app_logger.dart';
import 'package:anufit/features/step_counter/data/datasource/step_counter_pigeon_datasource.dart';
import 'package:anufit/features/step_counter/data/datasource/step_local_datasource.dart';
import 'package:anufit/features/step_counter/data/models/step_tracking_state_model.dart';
import 'package:anufit/features/step_counter/data/repository/step_repository_impl.dart';
import 'package:anufit/features/step_counter/domain/entities/step_data.dart';

class MockStepCounterPigeonDatasource extends Mock implements StepCounterPigeonDatasource {}

class MockStepLocalDatasource extends Mock implements StepLocalDatasource {}

class MockAppLogger extends Mock implements AppLogger {}

void main() {
  late MockStepCounterPigeonDatasource native;
  late MockStepLocalDatasource local;
  late MockAppLogger logger;
  late StepRepositoryImpl repository;

  setUpAll(() {
    registerFallbackValue(StepTrackingStateModel());
  });

  final initialState = StepTrackingStateModel()
    ..baselineDate = DateTime(2026, 6, 29)
    ..dailyBaseline = 1000
    ..lastHardwareTotal = 1000
    ..timezoneId = DateTime.now().timeZoneName
    ..isTracking = false;

  setUp(() {
    native = MockStepCounterPigeonDatasource();
    local = MockStepLocalDatasource();
    logger = MockAppLogger();

    when(() => native.events).thenAnswer((_) => const Stream.empty());
    when(() => native.errors).thenAnswer((_) => const Stream.empty());
    when(() => local.getOrCreateState()).thenAnswer((_) async => initialState);
    when(() => local.saveState(any())).thenAnswer((_) async {});
    when(() => local.upsertDailySteps(
          date: any(named: 'date'),
          steps: any(named: 'steps'),
          hardwareBaseline: any(named: 'hardwareBaseline'),
          hardwareTotalEnd: any(named: 'hardwareTotalEnd'),
        )).thenAnswer((_) async {});
    when(() => local.addHourlyDelta(
          hourStart: any(named: 'hourStart'),
          delta: any(named: 'delta'),
        )).thenAnswer((_) async {});

    repository = StepRepositoryImpl(native, local, logger);
  });

  test('startTracking fails when sensor unavailable', () async {
    when(() => native.isSensorAvailable()).thenAnswer((_) async => false);

    expect(
      () => repository.startTracking(),
      throwsA(isA<CacheException>()),
    );
  });

  test('startTracking updates persisted state and live stream', () async {
    when(() => native.isSensorAvailable()).thenAnswer((_) async => true);
    when(() => native.startTracking()).thenAnswer((_) async => true);
    when(() => native.getHardwareTotal()).thenAnswer((_) async => 1200);

    await repository.startTracking();

    final live = await repository.watchLiveSteps().first;
    expect(live.todaySteps, 200);
    expect(live.status, TrackingStatus.tracking);
    verify(() => local.saveState(any(that: predicate<StepTrackingStateModel>((s) => s.isTracking)))).called(greaterThan(0));
  });

  test('adjustSteps applies manual offset', () async {
    when(() => native.getHardwareTotal()).thenAnswer((_) async => 1300);

    await repository.adjustSteps(25);

    final live = await repository.watchLiveSteps().first;
    expect(live.todaySteps, 25);
    expect(live.manualAdjustment, 25);
  });
}
