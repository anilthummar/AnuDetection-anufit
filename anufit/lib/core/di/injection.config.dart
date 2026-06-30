// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:anufit/app/app_preferences_controller.dart' as _i491;
import 'package:anufit/app/config/app_config.dart' as _i404;
import 'package:anufit/app/router/app_router.dart' as _i475;
import 'package:anufit/core/backup_engine/backup_engine.dart' as _i998;
import 'package:anufit/core/backup_engine/backup_snapshot_collector.dart'
    as _i170;
import 'package:anufit/core/database/isar_service.dart' as _i906;
import 'package:anufit/core/di/register_module.dart' as _i863;
import 'package:anufit/core/logger/app_logger.dart' as _i983;
import 'package:anufit/core/security/encryption_service.dart' as _i185;
import 'package:anufit/core/security/secure_storage_service.dart' as _i32;
import 'package:anufit/core/services/local_notification_service.dart' as _i956;
import 'package:anufit/core/services/motivation_notification_scheduler.dart'
    as _i901;
import 'package:anufit/core/services/permission_service.dart' as _i571;
import 'package:anufit/core/services/reminder_scheduler.dart' as _i659;
import 'package:anufit/core/storage/local_storage_service.dart' as _i889;
import 'package:anufit/core/widget_engine/widget_engine.dart' as _i62;
import 'package:anufit/features/achievements/data/datasource/achievement_local_datasource.dart'
    as _i875;
import 'package:anufit/features/achievements/data/repository/achievement_repository_impl.dart'
    as _i584;
import 'package:anufit/features/achievements/domain/repository/achievement_repository.dart'
    as _i56;
import 'package:anufit/features/achievements/presentation/bloc/achievement_bloc.dart'
    as _i732;
import 'package:anufit/features/activity/data/datasource/activity_local_datasource.dart'
    as _i329;
import 'package:anufit/features/activity/data/repository/activity_repository_impl.dart'
    as _i672;
import 'package:anufit/features/activity/domain/repository/activity_repository.dart'
    as _i1060;
import 'package:anufit/features/activity/presentation/bloc/insight_bloc.dart'
    as _i708;
import 'package:anufit/features/activity/presentation/bloc/timeline_bloc.dart'
    as _i530;
import 'package:anufit/features/backup/data/repository/backup_repository_impl.dart'
    as _i221;
import 'package:anufit/features/backup/domain/repository/backup_repository.dart'
    as _i101;
import 'package:anufit/features/backup/presentation/bloc/backup_bloc.dart'
    as _i192;
import 'package:anufit/features/dashboard/data/repository/dashboard_repository_impl.dart'
    as _i288;
import 'package:anufit/features/dashboard/domain/repository/dashboard_repository.dart'
    as _i367;
import 'package:anufit/features/dashboard/domain/usecases/dashboard_usecases.dart'
    as _i247;
import 'package:anufit/features/dashboard/presentation/bloc/dashboard_bloc.dart'
    as _i942;
import 'package:anufit/features/goals/data/datasource/goal_local_datasource.dart'
    as _i327;
import 'package:anufit/features/goals/data/repository/goal_repository_impl.dart'
    as _i203;
import 'package:anufit/features/goals/domain/repository/goal_repository.dart'
    as _i96;
import 'package:anufit/features/goals/domain/usecases/goal_usecases.dart'
    as _i65;
import 'package:anufit/features/goals/presentation/bloc/motivation_goal_bloc.dart'
    as _i964;
import 'package:anufit/features/health/data/datasource/health_local_datasource.dart'
    as _i596;
import 'package:anufit/features/health/data/datasource/health_platform_datasource.dart'
    as _i713;
import 'package:anufit/features/health/data/repository/health_repository_impl.dart'
    as _i405;
import 'package:anufit/features/health/domain/repository/health_repository.dart'
    as _i989;
import 'package:anufit/features/health/domain/usecases/health_usecases.dart'
    as _i894;
import 'package:anufit/features/health/presentation/bloc/health_bloc.dart'
    as _i456;
import 'package:anufit/features/health/presentation/bloc/health_permission_cubit.dart'
    as _i1060;
import 'package:anufit/features/health/presentation/bloc/health_settings_bloc.dart'
    as _i425;
import 'package:anufit/features/health/services/health_sync_scheduler.dart'
    as _i635;
import 'package:anufit/features/health/sync/sync_engine.dart' as _i1017;
import 'package:anufit/features/history/data/datasource/history_local_datasource.dart'
    as _i689;
import 'package:anufit/features/history/data/repository/history_repository_impl.dart'
    as _i790;
import 'package:anufit/features/history/domain/repository/history_repository.dart'
    as _i402;
import 'package:anufit/features/history/domain/services/analytics_engine.dart'
    as _i46;
import 'package:anufit/features/history/presentation/bloc/history_bloc.dart'
    as _i358;
import 'package:anufit/features/onboarding/data/repository/onboarding_repository_impl.dart'
    as _i516;
import 'package:anufit/features/onboarding/domain/repository/onboarding_repository.dart'
    as _i364;
import 'package:anufit/features/onboarding/domain/usecases/onboarding_usecases.dart'
    as _i758;
import 'package:anufit/features/onboarding/presentation/bloc/goal_bloc.dart'
    as _i973;
import 'package:anufit/features/onboarding/presentation/bloc/health_connect_bloc.dart'
    as _i362;
import 'package:anufit/features/onboarding/presentation/bloc/onboarding_bloc.dart'
    as _i258;
import 'package:anufit/features/onboarding/presentation/bloc/permission_bloc.dart'
    as _i1063;
import 'package:anufit/features/onboarding/presentation/bloc/profile_bloc.dart'
    as _i139;
import 'package:anufit/features/onboarding/presentation/bloc/walking_preferences_bloc.dart'
    as _i85;
import 'package:anufit/features/profile/presentation/bloc/profile_bloc.dart'
    as _i541;
import 'package:anufit/features/reminder/data/datasource/reminder_local_datasource.dart'
    as _i356;
import 'package:anufit/features/reminder/data/repository/reminder_repository_impl.dart'
    as _i538;
import 'package:anufit/features/reminder/domain/repository/reminder_repository.dart'
    as _i265;
import 'package:anufit/features/reminder/presentation/bloc/reminder_bloc.dart'
    as _i28;
import 'package:anufit/features/reports/data/repository/report_repository_impl.dart'
    as _i349;
import 'package:anufit/features/reports/domain/repository/report_repository.dart'
    as _i712;
import 'package:anufit/features/reports/presentation/bloc/report_bloc.dart'
    as _i791;
import 'package:anufit/features/security/presentation/bloc/security_bloc.dart'
    as _i1053;
import 'package:anufit/features/settings/presentation/bloc/settings_bloc.dart'
    as _i267;
import 'package:anufit/features/splash/domain/usecases/initialize_splash_usecase.dart'
    as _i987;
import 'package:anufit/features/splash/presentation/bloc/splash_bloc.dart'
    as _i1036;
import 'package:anufit/features/statistics/data/repository/statistics_repository_impl.dart'
    as _i16;
import 'package:anufit/features/statistics/domain/repository/statistics_repository.dart'
    as _i1043;
import 'package:anufit/features/statistics/presentation/bloc/chart_bloc.dart'
    as _i888;
import 'package:anufit/features/statistics/presentation/bloc/statistics_bloc.dart'
    as _i13;
import 'package:anufit/features/step_counter/data/datasource/step_counter_pigeon_datasource.dart'
    as _i35;
import 'package:anufit/features/step_counter/data/datasource/step_local_datasource.dart'
    as _i29;
import 'package:anufit/features/step_counter/data/pigeon/step_counter_api.g.dart'
    as _i485;
import 'package:anufit/features/step_counter/data/repository/step_repository_impl.dart'
    as _i401;
import 'package:anufit/features/step_counter/domain/repository/step_repository.dart'
    as _i892;
import 'package:anufit/features/step_counter/domain/usecases/step_usecases.dart'
    as _i166;
import 'package:anufit/features/step_counter/presentation/bloc/step_tracking_bloc.dart'
    as _i200;
import 'package:anufit/features/sync/data/repository/google_drive_sync_repository.dart'
    as _i146;
import 'package:anufit/features/sync/data/repository/icloud_sync_repository.dart'
    as _i533;
import 'package:anufit/features/sync/presentation/bloc/sync_bloc.dart' as _i246;
import 'package:anufit/features/water/data/datasource/water_local_datasource.dart'
    as _i989;
import 'package:anufit/features/water/data/repository/water_repository_impl.dart'
    as _i1005;
import 'package:anufit/features/water/domain/repository/water_repository.dart'
    as _i956;
import 'package:anufit/features/water/presentation/bloc/water_bloc.dart'
    as _i462;
import 'package:anufit/features/weight/data/datasource/weight_local_datasource.dart'
    as _i284;
import 'package:anufit/features/weight/data/repository/weight_repository_impl.dart'
    as _i417;
import 'package:anufit/features/weight/domain/repository/weight_repository.dart'
    as _i152;
import 'package:anufit/features/weight/presentation/bloc/weight_bloc.dart'
    as _i226;
import 'package:anufit/features/widgets/presentation/bloc/widget_bloc.dart'
    as _i392;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:isar_community/isar.dart' as _i214;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    await gh.factoryAsync<_i214.Isar>(
      () => registerModule.isar,
      preResolve: true,
    );
    gh.factory<_i571.PermissionService>(() => _i571.PermissionService());
    gh.lazySingleton<_i404.AppConfig>(() => _i404.AppConfig());
    gh.lazySingleton<_i475.AppRouter>(() => _i475.AppRouter());
    gh.lazySingleton<_i485.StepCounterHostApi>(
      () => registerModule.stepCounterHostApi,
    );
    gh.lazySingleton<_i32.SecureStorageService>(
      () => _i32.SecureStorageService(),
    );
    gh.lazySingleton<_i956.LocalNotificationService>(
      () => _i956.LocalNotificationService(),
    );
    gh.lazySingleton<_i713.HealthPlatformDatasource>(
      () => _i713.HealthPlatformDatasource(),
    );
    gh.lazySingleton<_i906.IsarService>(
      () => _i906.IsarService(gh<_i214.Isar>()),
    );
    gh.lazySingleton<_i533.ICloudSyncRepository>(
      () => _i533.ICloudSyncRepository(),
      instanceName: 'iCloud',
    );
    gh.lazySingleton<_i875.AchievementLocalDatasource>(
      () => _i875.AchievementLocalDatasource(gh<_i906.IsarService>()),
    );
    gh.lazySingleton<_i329.ActivityLocalDatasource>(
      () => _i329.ActivityLocalDatasource(gh<_i906.IsarService>()),
    );
    gh.lazySingleton<_i596.HealthLocalDatasource>(
      () => _i596.HealthLocalDatasource(gh<_i906.IsarService>()),
    );
    gh.lazySingleton<_i689.HistoryLocalDatasource>(
      () => _i689.HistoryLocalDatasource(gh<_i906.IsarService>()),
    );
    gh.lazySingleton<_i29.StepLocalDatasource>(
      () => _i29.StepLocalDatasource(gh<_i906.IsarService>()),
    );
    gh.lazySingleton<_i146.GoogleDriveSyncRepository>(
      () => _i146.GoogleDriveSyncRepository(),
      instanceName: 'googleDrive',
    );
    gh.lazySingleton<_i983.AppLogger>(
      () => _i983.AppLogger(gh<_i404.AppConfig>()),
    );
    gh.lazySingleton<_i35.StepCounterPigeonDatasource>(
      () => _i35.StepCounterPigeonDatasource(
        gh<_i485.StepCounterHostApi>(),
        gh<_i983.AppLogger>(),
      ),
    );
    gh.lazySingleton<_i170.BackupSnapshotCollector>(
      () => _i170.BackupSnapshotCollector(gh<_i906.IsarService>()),
    );
    gh.lazySingleton<_i356.ReminderLocalDatasource>(
      () => _i356.ReminderLocalDatasource(gh<_i906.IsarService>()),
    );
    gh.lazySingleton<_i989.WaterLocalDatasource>(
      () => _i989.WaterLocalDatasource(gh<_i906.IsarService>()),
    );
    gh.lazySingleton<_i185.EncryptionService>(
      () => _i185.EncryptionService(gh<_i32.SecureStorageService>()),
    );
    gh.factory<_i1053.SecurityBloc>(
      () => _i1053.SecurityBloc(gh<_i32.SecureStorageService>()),
    );
    gh.lazySingleton<_i889.LocalStorageService>(
      () => _i889.LocalStorageService(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i1063.PermissionBloc>(
      () => _i1063.PermissionBloc(gh<_i571.PermissionService>()),
    );
    gh.lazySingleton<_i659.ReminderScheduler>(
      () => _i659.ReminderScheduler(gh<_i956.LocalNotificationService>()),
    );
    gh.lazySingleton<_i956.WaterRepository>(
      () => _i1005.WaterRepositoryImpl(gh<_i989.WaterLocalDatasource>()),
    );
    gh.lazySingleton<_i265.ReminderRepository>(
      () => _i538.ReminderRepositoryImpl(
        gh<_i356.ReminderLocalDatasource>(),
        gh<_i659.ReminderScheduler>(),
      ),
    );
    gh.lazySingleton<_i364.OnboardingRepository>(
      () => _i516.OnboardingRepositoryImpl(gh<_i906.IsarService>()),
    );
    gh.factory<_i758.InitializeAppSettingsUseCase>(
      () =>
          _i758.InitializeAppSettingsUseCase(gh<_i364.OnboardingRepository>()),
    );
    gh.factory<_i758.GetOnboardingStatusUseCase>(
      () => _i758.GetOnboardingStatusUseCase(gh<_i364.OnboardingRepository>()),
    );
    gh.factory<_i758.SaveOnboardingStepUseCase>(
      () => _i758.SaveOnboardingStepUseCase(gh<_i364.OnboardingRepository>()),
    );
    gh.factory<_i758.CompleteOnboardingUseCase>(
      () => _i758.CompleteOnboardingUseCase(gh<_i364.OnboardingRepository>()),
    );
    gh.factory<_i758.SaveUserProfileUseCase>(
      () => _i758.SaveUserProfileUseCase(gh<_i364.OnboardingRepository>()),
    );
    gh.factory<_i758.GetUserProfileUseCase>(
      () => _i758.GetUserProfileUseCase(gh<_i364.OnboardingRepository>()),
    );
    gh.factory<_i758.SaveAppSettingsUseCase>(
      () => _i758.SaveAppSettingsUseCase(gh<_i364.OnboardingRepository>()),
    );
    gh.factory<_i758.GetAppSettingsUseCase>(
      () => _i758.GetAppSettingsUseCase(gh<_i364.OnboardingRepository>()),
    );
    gh.factory<_i541.ProfileBloc>(
      () => _i541.ProfileBloc(gh<_i364.OnboardingRepository>()),
    );
    gh.lazySingleton<_i491.AppPreferencesController>(
      () => _i491.AppPreferencesController(gh<_i364.OnboardingRepository>()),
    );
    gh.lazySingleton<_i892.StepRepository>(
      () => _i401.StepRepositoryImpl(
        gh<_i35.StepCounterPigeonDatasource>(),
        gh<_i29.StepLocalDatasource>(),
        gh<_i983.AppLogger>(),
      ),
    );
    gh.factory<_i28.ReminderBloc>(
      () => _i28.ReminderBloc(gh<_i265.ReminderRepository>()),
    );
    gh.factory<_i246.SyncBloc>(
      () => _i246.SyncBloc(
        gh<_i146.GoogleDriveSyncRepository>(instanceName: 'googleDrive'),
        gh<_i533.ICloudSyncRepository>(instanceName: 'iCloud'),
      ),
    );
    gh.lazySingleton<_i367.DashboardRepository>(
      () => _i288.DashboardRepositoryImpl(
        gh<_i892.StepRepository>(),
        gh<_i364.OnboardingRepository>(),
      ),
    );
    gh.factory<_i258.OnboardingBloc>(
      () => _i258.OnboardingBloc(gh<_i758.SaveOnboardingStepUseCase>()),
    );
    gh.factory<_i247.GetTodaySummaryUseCase>(
      () => _i247.GetTodaySummaryUseCase(gh<_i367.DashboardRepository>()),
    );
    gh.factory<_i247.DashboardWatchLiveStepsUseCase>(
      () =>
          _i247.DashboardWatchLiveStepsUseCase(gh<_i367.DashboardRepository>()),
    );
    gh.factory<_i247.GetGoalProgressUseCase>(
      () => _i247.GetGoalProgressUseCase(gh<_i367.DashboardRepository>()),
    );
    gh.factory<_i247.GetCaloriesUseCase>(
      () => _i247.GetCaloriesUseCase(gh<_i367.DashboardRepository>()),
    );
    gh.factory<_i247.GetDistanceUseCase>(
      () => _i247.GetDistanceUseCase(gh<_i367.DashboardRepository>()),
    );
    gh.factory<_i247.GetWalkingTimeUseCase>(
      () => _i247.GetWalkingTimeUseCase(gh<_i367.DashboardRepository>()),
    );
    gh.factory<_i247.GetCurrentStreakUseCase>(
      () => _i247.GetCurrentStreakUseCase(gh<_i367.DashboardRepository>()),
    );
    gh.factory<_i247.GetAchievementsPreviewUseCase>(
      () =>
          _i247.GetAchievementsPreviewUseCase(gh<_i367.DashboardRepository>()),
    );
    gh.factory<_i247.GetHourlyStepsUseCase>(
      () => _i247.GetHourlyStepsUseCase(gh<_i367.DashboardRepository>()),
    );
    gh.factory<_i247.DashboardStartTrackingUseCase>(
      () =>
          _i247.DashboardStartTrackingUseCase(gh<_i367.DashboardRepository>()),
    );
    gh.factory<_i247.DashboardPauseTrackingUseCase>(
      () =>
          _i247.DashboardPauseTrackingUseCase(gh<_i367.DashboardRepository>()),
    );
    gh.factory<_i247.DashboardResumeTrackingUseCase>(
      () =>
          _i247.DashboardResumeTrackingUseCase(gh<_i367.DashboardRepository>()),
    );
    gh.lazySingleton<_i998.BackupEngine>(
      () => _i998.BackupEngine(
        gh<_i170.BackupSnapshotCollector>(),
        gh<_i185.EncryptionService>(),
      ),
    );
    gh.factory<_i362.HealthConnectBloc>(
      () => _i362.HealthConnectBloc(
        gh<_i758.GetAppSettingsUseCase>(),
        gh<_i758.SaveAppSettingsUseCase>(),
      ),
    );
    gh.factory<_i267.SettingsBloc>(
      () => _i267.SettingsBloc(
        gh<_i364.OnboardingRepository>(),
        gh<_i906.IsarService>(),
        gh<_i491.AppPreferencesController>(),
      ),
    );
    gh.lazySingleton<_i327.GoalLocalDatasource>(
      () => _i327.GoalLocalDatasource(
        gh<_i906.IsarService>(),
        gh<_i364.OnboardingRepository>(),
      ),
    );
    gh.factory<_i462.WaterBloc>(
      () => _i462.WaterBloc(gh<_i956.WaterRepository>()),
    );
    gh.factory<_i942.DashboardBloc>(
      () => _i942.DashboardBloc(
        gh<_i247.GetTodaySummaryUseCase>(),
        gh<_i247.DashboardWatchLiveStepsUseCase>(),
        gh<_i247.GetDistanceUseCase>(),
        gh<_i247.GetWalkingTimeUseCase>(),
        gh<_i247.GetHourlyStepsUseCase>(),
        gh<_i247.DashboardStartTrackingUseCase>(),
        gh<_i247.DashboardPauseTrackingUseCase>(),
        gh<_i247.DashboardResumeTrackingUseCase>(),
        gh<_i571.PermissionService>(),
      ),
    );
    gh.factory<_i139.ProfileBloc>(
      () => _i139.ProfileBloc(
        gh<_i758.SaveUserProfileUseCase>(),
        gh<_i758.GetUserProfileUseCase>(),
      ),
    );
    gh.lazySingleton<_i101.BackupRepository>(
      () => _i221.BackupRepositoryImpl(gh<_i998.BackupEngine>()),
    );
    gh.factory<_i987.InitializeSplashUseCase>(
      () => _i987.InitializeSplashUseCase(
        gh<_i758.InitializeAppSettingsUseCase>(),
        gh<_i758.GetOnboardingStatusUseCase>(),
      ),
    );
    gh.lazySingleton<_i284.WeightLocalDatasource>(
      () => _i284.WeightLocalDatasource(
        gh<_i906.IsarService>(),
        gh<_i364.OnboardingRepository>(),
      ),
    );
    gh.factory<_i166.StartStepTrackingUseCase>(
      () => _i166.StartStepTrackingUseCase(gh<_i892.StepRepository>()),
    );
    gh.factory<_i166.StopStepTrackingUseCase>(
      () => _i166.StopStepTrackingUseCase(gh<_i892.StepRepository>()),
    );
    gh.factory<_i166.PauseTrackingUseCase>(
      () => _i166.PauseTrackingUseCase(gh<_i892.StepRepository>()),
    );
    gh.factory<_i166.ResumeTrackingUseCase>(
      () => _i166.ResumeTrackingUseCase(gh<_i892.StepRepository>()),
    );
    gh.factory<_i166.ResetTodayStepsUseCase>(
      () => _i166.ResetTodayStepsUseCase(gh<_i892.StepRepository>()),
    );
    gh.factory<_i166.AdjustStepsUseCase>(
      () => _i166.AdjustStepsUseCase(gh<_i892.StepRepository>()),
    );
    gh.factory<_i166.GetTodayStepsUseCase>(
      () => _i166.GetTodayStepsUseCase(gh<_i892.StepRepository>()),
    );
    gh.factory<_i166.GetWeeklyStepsUseCase>(
      () => _i166.GetWeeklyStepsUseCase(gh<_i892.StepRepository>()),
    );
    gh.factory<_i166.GetMonthlyStepsUseCase>(
      () => _i166.GetMonthlyStepsUseCase(gh<_i892.StepRepository>()),
    );
    gh.factory<_i166.WatchLiveStepsUseCase>(
      () => _i166.WatchLiveStepsUseCase(gh<_i892.StepRepository>()),
    );
    gh.factory<_i973.GoalBloc>(
      () => _i973.GoalBloc(
        gh<_i758.GetUserProfileUseCase>(),
        gh<_i758.SaveUserProfileUseCase>(),
      ),
    );
    gh.factory<_i85.WalkingPreferencesBloc>(
      () => _i85.WalkingPreferencesBloc(
        gh<_i758.GetUserProfileUseCase>(),
        gh<_i758.SaveUserProfileUseCase>(),
      ),
    );
    gh.factory<_i1036.SplashBloc>(
      () => _i1036.SplashBloc(gh<_i987.InitializeSplashUseCase>()),
    );
    gh.factory<_i200.StepTrackingBloc>(
      () => _i200.StepTrackingBloc(
        gh<_i166.StartStepTrackingUseCase>(),
        gh<_i166.StopStepTrackingUseCase>(),
        gh<_i166.PauseTrackingUseCase>(),
        gh<_i166.ResumeTrackingUseCase>(),
        gh<_i166.ResetTodayStepsUseCase>(),
        gh<_i166.AdjustStepsUseCase>(),
        gh<_i166.GetTodayStepsUseCase>(),
        gh<_i166.GetWeeklyStepsUseCase>(),
        gh<_i166.GetMonthlyStepsUseCase>(),
        gh<_i166.WatchLiveStepsUseCase>(),
      ),
    );
    gh.factory<_i192.BackupBloc>(
      () => _i192.BackupBloc(gh<_i101.BackupRepository>()),
    );
    gh.lazySingleton<_i96.GoalRepository>(
      () => _i203.GoalRepositoryImpl(
        gh<_i327.GoalLocalDatasource>(),
        gh<_i892.StepRepository>(),
        gh<_i364.OnboardingRepository>(),
      ),
      dispose: (i) => i.dispose(),
    );
    gh.lazySingleton<_i46.AnalyticsEngine>(
      () => _i46.AnalyticsEngine(
        gh<_i29.StepLocalDatasource>(),
        gh<_i689.HistoryLocalDatasource>(),
        gh<_i327.GoalLocalDatasource>(),
        gh<_i364.OnboardingRepository>(),
      ),
    );
    gh.lazySingleton<_i1017.SyncEngine>(
      () => _i1017.SyncEngine(
        gh<_i713.HealthPlatformDatasource>(),
        gh<_i596.HealthLocalDatasource>(),
        gh<_i29.StepLocalDatasource>(),
        gh<_i46.AnalyticsEngine>(),
        gh<_i983.AppLogger>(),
      ),
    );
    gh.lazySingleton<_i402.HistoryRepository>(
      () => _i790.HistoryRepositoryImpl(
        gh<_i689.HistoryLocalDatasource>(),
        gh<_i46.AnalyticsEngine>(),
      ),
    );
    gh.lazySingleton<_i152.WeightRepository>(
      () => _i417.WeightRepositoryImpl(
        gh<_i284.WeightLocalDatasource>(),
        gh<_i364.OnboardingRepository>(),
        gh<_i713.HealthPlatformDatasource>(),
      ),
    );
    gh.factory<_i65.GetGoalUseCase>(
      () => _i65.GetGoalUseCase(gh<_i96.GoalRepository>()),
    );
    gh.factory<_i65.UpdateGoalUseCase>(
      () => _i65.UpdateGoalUseCase(gh<_i96.GoalRepository>()),
    );
    gh.factory<_i65.ResetGoalUseCase>(
      () => _i65.ResetGoalUseCase(gh<_i96.GoalRepository>()),
    );
    gh.factory<_i65.WatchGoalProgressUseCase>(
      () => _i65.WatchGoalProgressUseCase(gh<_i96.GoalRepository>()),
    );
    gh.factory<_i65.CalculateCompletionUseCase>(
      () => _i65.CalculateCompletionUseCase(gh<_i96.GoalRepository>()),
    );
    gh.factory<_i65.EstimateCompletionTimeUseCase>(
      () => _i65.EstimateCompletionTimeUseCase(gh<_i96.GoalRepository>()),
    );
    gh.factory<_i65.GetGoalProgressUseCase>(
      () => _i65.GetGoalProgressUseCase(gh<_i96.GoalRepository>()),
    );
    gh.factory<_i964.MotivationGoalBloc>(
      () => _i964.MotivationGoalBloc(
        gh<_i65.UpdateGoalUseCase>(),
        gh<_i65.ResetGoalUseCase>(),
        gh<_i65.WatchGoalProgressUseCase>(),
        gh<_i956.LocalNotificationService>(),
      ),
    );
    gh.lazySingleton<_i1043.StatisticsRepository>(
      () => _i16.StatisticsRepositoryImpl(
        gh<_i689.HistoryLocalDatasource>(),
        gh<_i46.AnalyticsEngine>(),
        gh<_i892.StepRepository>(),
        gh<_i96.GoalRepository>(),
        gh<_i364.OnboardingRepository>(),
      ),
    );
    gh.factory<_i226.WeightBloc>(
      () => _i226.WeightBloc(gh<_i152.WeightRepository>()),
    );
    gh.lazySingleton<_i901.MotivationNotificationScheduler>(
      () => _i901.MotivationNotificationScheduler(
        gh<_i956.LocalNotificationService>(),
        gh<_i892.StepRepository>(),
        gh<_i96.GoalRepository>(),
      ),
    );
    gh.lazySingleton<_i989.HealthRepository>(
      () => _i405.HealthRepositoryImpl(
        gh<_i713.HealthPlatformDatasource>(),
        gh<_i596.HealthLocalDatasource>(),
        gh<_i1017.SyncEngine>(),
        gh<_i364.OnboardingRepository>(),
      ),
    );
    gh.factory<_i888.ChartBloc>(
      () => _i888.ChartBloc(gh<_i1043.StatisticsRepository>()),
    );
    gh.factory<_i13.StatisticsBloc>(
      () => _i13.StatisticsBloc(gh<_i1043.StatisticsRepository>()),
    );
    gh.factory<_i358.HistoryBloc>(
      () => _i358.HistoryBloc(gh<_i402.HistoryRepository>()),
    );
    gh.lazySingleton<_i62.WidgetEngine>(
      () => _i62.WidgetEngine(
        gh<_i892.StepRepository>(),
        gh<_i96.GoalRepository>(),
        gh<_i956.WaterRepository>(),
        gh<_i152.WeightRepository>(),
        gh<_i364.OnboardingRepository>(),
      ),
    );
    gh.lazySingleton<_i56.AchievementRepository>(
      () => _i584.AchievementRepositoryImpl(
        gh<_i875.AchievementLocalDatasource>(),
        gh<_i892.StepRepository>(),
        gh<_i96.GoalRepository>(),
        gh<_i364.OnboardingRepository>(),
      ),
    );
    gh.lazySingleton<_i1060.ActivityRepository>(
      () => _i672.ActivityRepositoryImpl(
        gh<_i329.ActivityLocalDatasource>(),
        gh<_i892.StepRepository>(),
        gh<_i96.GoalRepository>(),
        gh<_i364.OnboardingRepository>(),
      ),
    );
    gh.factory<_i894.RequestHealthPermissionsUseCase>(
      () => _i894.RequestHealthPermissionsUseCase(gh<_i989.HealthRepository>()),
    );
    gh.factory<_i894.CheckHealthPermissionsUseCase>(
      () => _i894.CheckHealthPermissionsUseCase(gh<_i989.HealthRepository>()),
    );
    gh.factory<_i894.ReadTodayHealthUseCase>(
      () => _i894.ReadTodayHealthUseCase(gh<_i989.HealthRepository>()),
    );
    gh.factory<_i894.SyncHealthDataUseCase>(
      () => _i894.SyncHealthDataUseCase(gh<_i989.HealthRepository>()),
    );
    gh.factory<_i894.ConnectHealthUseCase>(
      () => _i894.ConnectHealthUseCase(gh<_i989.HealthRepository>()),
    );
    gh.factory<_i894.DisconnectHealthUseCase>(
      () => _i894.DisconnectHealthUseCase(gh<_i989.HealthRepository>()),
    );
    gh.factory<_i894.GetHealthSyncStatusUseCase>(
      () => _i894.GetHealthSyncStatusUseCase(gh<_i989.HealthRepository>()),
    );
    gh.factory<_i894.IsHealthPlatformAvailableUseCase>(
      () =>
          _i894.IsHealthPlatformAvailableUseCase(gh<_i989.HealthRepository>()),
    );
    gh.factory<_i894.WatchHealthStatusUseCase>(
      () => _i894.WatchHealthStatusUseCase(gh<_i989.HealthRepository>()),
    );
    gh.factory<_i708.InsightBloc>(
      () => _i708.InsightBloc(gh<_i1060.ActivityRepository>()),
    );
    gh.factory<_i530.TimelineBloc>(
      () => _i530.TimelineBloc(gh<_i1060.ActivityRepository>()),
    );
    gh.factory<_i732.AchievementBloc>(
      () => _i732.AchievementBloc(
        gh<_i56.AchievementRepository>(),
        gh<_i956.LocalNotificationService>(),
      ),
    );
    gh.factory<_i1060.SyncCubit>(
      () => _i1060.SyncCubit(gh<_i894.SyncHealthDataUseCase>()),
    );
    gh.lazySingleton<_i712.ReportRepository>(
      () => _i349.ReportRepositoryImpl(
        gh<_i689.HistoryLocalDatasource>(),
        gh<_i46.AnalyticsEngine>(),
        gh<_i364.OnboardingRepository>(),
        gh<_i56.AchievementRepository>(),
      ),
    );
    gh.lazySingleton<_i635.HealthSyncScheduler>(
      () => _i635.HealthSyncScheduler(
        gh<_i894.SyncHealthDataUseCase>(),
        gh<_i364.OnboardingRepository>(),
      ),
    );
    gh.factory<_i425.HealthSettingsBloc>(
      () => _i425.HealthSettingsBloc(
        gh<_i894.GetHealthSyncStatusUseCase>(),
        gh<_i894.ConnectHealthUseCase>(),
        gh<_i894.DisconnectHealthUseCase>(),
        gh<_i894.SyncHealthDataUseCase>(),
        gh<_i894.CheckHealthPermissionsUseCase>(),
        gh<_i894.IsHealthPlatformAvailableUseCase>(),
        gh<_i571.PermissionService>(),
      ),
    );
    gh.factory<_i456.HealthBloc>(
      () => _i456.HealthBloc(
        gh<_i894.WatchHealthStatusUseCase>(),
        gh<_i894.GetHealthSyncStatusUseCase>(),
      ),
    );
    gh.factory<_i791.ReportBloc>(
      () => _i791.ReportBloc(gh<_i712.ReportRepository>()),
    );
    gh.factory<_i392.WidgetBloc>(
      () => _i392.WidgetBloc(gh<_i62.WidgetEngine>()),
    );
    gh.factory<_i1060.HealthPermissionCubit>(
      () => _i1060.HealthPermissionCubit(
        gh<_i894.CheckHealthPermissionsUseCase>(),
        gh<_i894.RequestHealthPermissionsUseCase>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i863.RegisterModule {}
