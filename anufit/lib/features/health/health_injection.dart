import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:anufit/core/di/injection.dart';
import 'package:anufit/features/health/presentation/bloc/health_permission_cubit.dart';
import 'package:anufit/features/health/presentation/bloc/health_settings_bloc.dart';

abstract final class HealthInjection {
  static List<BlocProvider> get providers => [
        BlocProvider<HealthSettingsBloc>(
          create: (_) => getIt<HealthSettingsBloc>()..add(const HealthSettingsLoadRequested()),
        ),
        BlocProvider<HealthPermissionCubit>(
          create: (_) => getIt<HealthPermissionCubit>()..load(),
        ),
        BlocProvider<SyncCubit>(
          create: (_) => getIt<SyncCubit>(),
        ),
      ];
}
