import 'package:flutter/material.dart';

import 'package:anufit/app/app.dart';
import 'package:anufit/app/config/app_config.dart';
import 'package:anufit/app/config/env_loader.dart';
import 'package:anufit/app/router/app_router.dart';
import 'package:anufit/core/database/isar_service.dart';
import 'package:anufit/app/app_preferences_controller.dart';
import 'package:anufit/core/di/injection.dart';
import 'package:anufit/core/logger/app_logger.dart';
import 'package:anufit/core/performance/startup_optimizer.dart';
import 'package:anufit/core/services/local_notification_service.dart';
import 'package:anufit/core/services/motivation_notification_scheduler.dart';
import 'package:anufit/core/widget_engine/widget_engine.dart';
import 'package:anufit/features/health/services/health_sync_scheduler.dart';
import 'package:anufit/features/history/domain/services/analytics_engine.dart';
import 'package:anufit/features/reminder/domain/repository/reminder_repository.dart';
import 'package:anufit/features/step_counter/data/datasource/step_counter_pigeon_datasource.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  final environment = await loadEnvironment();
  await configureDependencies();

  await getIt<AppPreferencesController>().load();

  final logger = getIt<AppLogger>();
  final config = getIt<AppConfig>();

  logger.i('Anufit starting — env: ${environment.value}');
  logger.i('API: ${config.apiBaseUrl}');
  logger.i('Isar initialized: ${getIt<IsarService>().db.isOpen}');
  logger.i('SharedPreferences ready');

  // Register Pigeon Flutter API handler for native step events.
  getIt<StepCounterPigeonDatasource>();
  await getIt<LocalNotificationService>().initialize();
  await getIt<WidgetEngine>().initialize();

  runApp(App(router: getIt<AppRouter>().router));

  StartupOptimizer.runDeferred([
    () => getIt<MotivationNotificationScheduler>().scheduleMotivationReminders(),
    () => getIt<AnalyticsEngine>().syncRecent(),
    () => getIt<HealthSyncScheduler>().syncIfConnected(),
    () => getIt<ReminderRepository>().rescheduleAll(),
    () => getIt<WidgetEngine>().syncWidgetData(),
  ]);
}
