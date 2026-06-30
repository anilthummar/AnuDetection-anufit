import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:anufit/core/di/injection.dart';
import 'package:anufit/features/backup/presentation/bloc/backup_bloc.dart';
import 'package:anufit/features/security/presentation/bloc/security_bloc.dart';
import 'package:anufit/features/sync/presentation/bloc/sync_bloc.dart';
import 'package:anufit/features/widgets/presentation/bloc/widget_bloc.dart';

abstract final class ProductionInjection {
  static List<BlocProvider> get backupProviders => [
        BlocProvider<BackupBloc>(create: (_) => getIt<BackupBloc>()),
      ];

  static List<BlocProvider> get syncProviders => [
        BlocProvider<SyncBloc>(
          create: (_) => getIt<SyncBloc>()..add(const SyncLoadRequested()),
        ),
      ];

  static List<BlocProvider> get securityProviders => [
        BlocProvider<SecurityBloc>(
          create: (_) => getIt<SecurityBloc>()..add(const SecurityLoadRequested()),
        ),
      ];

  static List<BlocProvider> get widgetProviders => [
        BlocProvider<WidgetBloc>(
          create: (_) => getIt<WidgetBloc>()..add(const WidgetSyncRequested()),
        ),
      ];
}
