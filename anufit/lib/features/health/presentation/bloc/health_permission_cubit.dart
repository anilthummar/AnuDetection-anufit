import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:anufit/core/usecase/usecase.dart';
import 'package:anufit/features/health/domain/entities/health_entity.dart';
import 'package:anufit/features/health/domain/usecases/health_usecases.dart';

@injectable
class HealthPermissionCubit extends Cubit<HealthPermissionEntity> {
  HealthPermissionCubit(this._check, this._request)
      : super(const HealthPermissionEntity(
          steps: false,
          distance: false,
          calories: false,
          weight: false,
          height: false,
          authorized: false,
          status: HealthPermissionState.unknown,
        ));

  final CheckHealthPermissionsUseCase _check;
  final RequestHealthPermissionsUseCase _request;

  Future<void> load() async {
    emit(await _check(const NoParams()));
  }

  Future<void> request() async {
    emit(await _request(const NoParams()));
  }
}

@injectable
class SyncCubit extends Cubit<SyncResult?> {
  SyncCubit(this._sync) : super(null);

  final SyncHealthDataUseCase _sync;

  Future<void> syncNow({bool initial = false}) async {
    final result = await _sync(SyncHealthParams(initial: initial));
    emit(result);
  }
}
