import 'package:injectable/injectable.dart';
import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:anufit/core/constants/app_constants.dart';
import 'package:anufit/core/database/isar_schemas.dart';
import 'package:anufit/features/step_counter/data/pigeon/step_counter_api.g.dart';

@module
abstract class RegisterModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @preResolve
  Future<Isar> get isar async {
    final dir = await getApplicationDocumentsDirectory();
    return Isar.open(
      isarSchemas,
      directory: dir.path,
      name: AppConstants.databaseName,
    );
  }

  @lazySingleton
  StepCounterHostApi get stepCounterHostApi => StepCounterHostApi();
}
