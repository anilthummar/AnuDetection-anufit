import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:anufit/core/di/injection.dart';
import 'package:anufit/features/dashboard/presentation/bloc/dashboard_bloc.dart';

/// Dashboard feature DI helpers for route-level bloc provisioning.
abstract final class DashboardInjection {
  static DashboardBloc createBloc() {
    return getIt<DashboardBloc>()..add(const LoadDashboard());
  }

  static List<BlocProvider> get providers => [
        BlocProvider<DashboardBloc>(
          create: (_) => createBloc(),
        ),
      ];
}
