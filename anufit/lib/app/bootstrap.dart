import 'package:flutter/material.dart';

import 'package:anufit/app/app.dart';
import 'package:anufit/app/config/app_config.dart';
import 'package:anufit/app/config/env_loader.dart';
import 'package:anufit/app/router/app_router.dart';
import 'package:anufit/core/database/isar_service.dart';
import 'package:anufit/core/di/injection.dart';
import 'package:anufit/core/logger/app_logger.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  final environment = await loadEnvironment();
  await configureDependencies();

  final logger = getIt<AppLogger>();
  final config = getIt<AppConfig>();

  logger.i('Anufit starting — env: ${environment.value}');
  logger.i('API: ${config.apiBaseUrl}');
  logger.i('Isar initialized: ${getIt<IsarService>().db.isOpen}');
  logger.i('SharedPreferences ready');

  runApp(App(router: getIt<AppRouter>().router));
}
