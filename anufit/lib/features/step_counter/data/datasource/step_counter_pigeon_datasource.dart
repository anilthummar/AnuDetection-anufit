import 'dart:async';

import 'package:injectable/injectable.dart';

import 'package:anufit/core/logger/app_logger.dart';
import 'package:anufit/features/step_counter/data/pigeon/step_counter_api.g.dart';
import 'package:anufit/features/step_counter/domain/entities/step_data.dart';

@lazySingleton
class StepCounterPigeonDatasource implements StepCounterFlutterApi {
  StepCounterPigeonDatasource(this._hostApi, this._logger) {
    StepCounterFlutterApi.setUp(this);
  }

  final StepCounterHostApi _hostApi;
  final AppLogger _logger;

  final _events = StreamController<StepCounterNativeEvent>.broadcast();
  final _errors = StreamController<StepCounterNativeError>.broadcast();

  Stream<StepCounterNativeEvent> get events => _events.stream;

  Stream<StepCounterNativeError> get errors => _errors.stream;

  @override
  void onStepEvent(StepCounterNativeEvent event) {
    _logger.d('Native step event: ${event.hardwareTotal} (${event.source})');
    _events.add(event);
  }

  @override
  void onStepError(StepCounterNativeError error) {
    _logger.e('Native step error: ${error.code} — ${error.message}');
    _errors.add(error);
  }

  Future<bool> startTracking() => _hostApi.startTracking();

  Future<bool> stopTracking() => _hostApi.stopTracking();

  Future<bool> pauseTracking() => _hostApi.pauseTracking();

  Future<bool> resumeTracking() => _hostApi.resumeTracking();

  Future<int> getHardwareTotal() => _hostApi.getHardwareTotal();

  Future<bool> isSensorAvailable() => _hostApi.isSensorAvailable();

  Future<StepSource> getPlatformSource() async {
    final source = await _hostApi.getPlatformSource();
    return StepSource.fromNative(source);
  }
}
