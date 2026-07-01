import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:anufit/app/config/app_environment.dart';

Future<AppEnvironment> loadEnvironment() async {
  const envName = String.fromEnvironment('ENV', defaultValue: 'dev');
  final environment = AppEnvironment.fromString(envName);

  try {
    await dotenv.load(fileName: environment.envFileName);
  } catch (_) {
    // Dev/staging env files are not bundled in release builds.
    dotenv.testLoad(
      fileInput: switch (environment) {
        AppEnvironment.production =>
          'ENV=production\nAPI_BASE_URL=https://api.example.com\nAPI_TIMEOUT=30000\nENABLE_LOGGING=false',
        AppEnvironment.staging =>
          'ENV=staging\nAPI_BASE_URL=https://api.example.com\nAPI_TIMEOUT=30000\nENABLE_LOGGING=true',
        AppEnvironment.dev =>
          'ENV=dev\nAPI_BASE_URL=https://api.example.com\nAPI_TIMEOUT=30000\nENABLE_LOGGING=true',
      },
    );
  }

  return environment;
}
