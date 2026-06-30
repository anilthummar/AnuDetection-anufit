import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/features/step_counter/data/pigeon/step_counter_api.g.dart',
    dartOptions: DartOptions(),
    dartPackageName: 'anufit',
    kotlinOut:
        'android/app/src/main/kotlin/com/anudetection/anufit/stepcounter/StepCounterApi.g.kt',
    kotlinOptions: KotlinOptions(
      package: 'com.anudetection.anufit.stepcounter',
    ),
    swiftOut: 'ios/Runner/StepCounterApi.g.swift',
    swiftOptions: SwiftOptions(),
  ),
)
class StepCounterNativeEvent {
  StepCounterNativeEvent({
    required this.hardwareTotal,
    required this.delta,
    required this.timestampMs,
    required this.source,
  });

  final int hardwareTotal;
  final int delta;
  final int timestampMs;
  final String source;
}

class StepCounterNativeError {
  StepCounterNativeError({
    required this.code,
    required this.message,
  });

  final String code;
  final String message;
}

@HostApi()
abstract class StepCounterHostApi {
  bool startTracking();

  bool stopTracking();

  bool pauseTracking();

  bool resumeTracking();

  int getHardwareTotal();

  bool isSensorAvailable();

  String getPlatformSource();
}

@FlutterApi()
abstract class StepCounterFlutterApi {
  void onStepEvent(StepCounterNativeEvent event);

  void onStepError(StepCounterNativeError error);
}
