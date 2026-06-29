import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

import 'package:anufit/app/config/app_environment.dart';

@lazySingleton
class AppConfig {
  AppConfig();

  AppEnvironment get environment =>
      AppEnvironment.fromString(dotenv.get('ENV', fallback: 'dev'));

  String get apiBaseUrl => dotenv.get('API_BASE_URL');

  int get apiTimeout => int.parse(dotenv.get('API_TIMEOUT', fallback: '30000'));

  bool get enableLogging =>
      dotenv.get('ENABLE_LOGGING', fallback: 'true').toLowerCase() == 'true';
}
