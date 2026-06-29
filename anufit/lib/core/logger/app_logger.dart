import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import 'package:anufit/app/config/app_config.dart';

@lazySingleton
class AppLogger {
  AppLogger(this._config) {
    _logger = Logger(
      printer: PrettyPrinter(
        methodCount: 0,
        dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
      ),
      level: _config.enableLogging ? Level.debug : Level.off,
    );
  }

  final AppConfig _config;
  late final Logger _logger;

  void d(Object? message, [Object? error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      _logger.d(message, error: error, stackTrace: stackTrace);
    }
  }

  void i(Object? message, [Object? error, StackTrace? stackTrace]) {
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  void w(Object? message, [Object? error, StackTrace? stackTrace]) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  void e(Object? message, [Object? error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }
}
