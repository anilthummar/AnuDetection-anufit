import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:anufit/app/app.dart';
import 'package:anufit/app/app_preferences_controller.dart';
import 'package:anufit/app/router/app_routes.dart';
import 'package:anufit/core/di/injection.dart';
import 'package:anufit/features/onboarding/domain/repository/onboarding_repository.dart';
import 'package:mocktail/mocktail.dart';

class _MockOnboardingRepository extends Mock implements OnboardingRepository {}

void main() {
  setUpAll(() {
    if (!getIt.isRegistered<AppPreferencesController>()) {
      getIt.registerLazySingleton<AppPreferencesController>(
        () => AppPreferencesController(_MockOnboardingRepository()),
      );
    }
  });

  testWidgets('App renders with router', (WidgetTester tester) async {
    final router = GoRouter(
      routes: <RouteBase>[
        GoRoute(
          path: AppRoutes.splash,
          builder: (BuildContext context, GoRouterState state) {
            return const Scaffold(body: Center(child: Text('Step Counter')));
          },
        ),
      ],
    );

    await tester.pumpWidget(App(router: router));
    await tester.pumpAndSettle();

    expect(find.text('Step Counter'), findsOneWidget);
  });
}
