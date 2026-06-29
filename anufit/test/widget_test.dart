import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:anufit/app/app.dart';
import 'package:anufit/app/router/app_routes.dart';
import 'package:anufit/app/router/app_shell.dart';

void main() {
  testWidgets('App bootstraps with foundation shell', (WidgetTester tester) async {
    final router = GoRouter(
      routes: <RouteBase>[
        GoRoute(
          path: AppRoutes.shell,
          builder: (BuildContext context, GoRouterState state) {
            return const AppShell();
          },
        ),
      ],
    );

    await tester.pumpWidget(App(router: router));
    await tester.pumpAndSettle();

    expect(find.byType(AppShell), findsOneWidget);
  });
}
