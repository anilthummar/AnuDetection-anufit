import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:anufit/app/config/app_environment.dart';

Future<AppEnvironment> loadEnvironment() async {
  const envName = String.fromEnvironment('ENV', defaultValue: 'dev');
  final environment = AppEnvironment.fromString(envName);

  await dotenv.load(fileName: environment.envFileName);

  return environment;
}
