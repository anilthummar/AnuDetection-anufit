import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import 'package:anufit/app/router/app_routes.dart';
import 'package:anufit/app/router/app_shell.dart';

@lazySingleton
class AppRouter {
  late final GoRouter router = GoRouter(
    initialLocation: AppRoutes.shell,
    debugLogDiagnostics: true,
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.shell,
        name: 'shell',
        builder: (BuildContext context, GoRouterState state) {
          return const AppShell();
        },
      ),
    ],
  );
}
