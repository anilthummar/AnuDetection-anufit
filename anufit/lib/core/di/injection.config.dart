// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:anufit/app/config/app_config.dart' as _i404;
import 'package:anufit/app/router/app_router.dart' as _i475;
import 'package:anufit/core/database/isar_service.dart' as _i906;
import 'package:anufit/core/di/register_module.dart' as _i863;
import 'package:anufit/core/logger/app_logger.dart' as _i983;
import 'package:anufit/core/storage/local_storage_service.dart' as _i889;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:isar/isar.dart' as _i338;
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
    await gh.factoryAsync<_i338.Isar>(
      () => registerModule.isar,
      preResolve: true,
    );
    gh.lazySingleton<_i404.AppConfig>(() => _i404.AppConfig());
    gh.lazySingleton<_i475.AppRouter>(() => _i475.AppRouter());
    gh.lazySingleton<_i906.IsarService>(
      () => _i906.IsarService(gh<_i338.Isar>()),
    );
    gh.lazySingleton<_i983.AppLogger>(
      () => _i983.AppLogger(gh<_i404.AppConfig>()),
    );
    gh.lazySingleton<_i889.LocalStorageService>(
      () => _i889.LocalStorageService(gh<_i460.SharedPreferences>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i863.RegisterModule {}
