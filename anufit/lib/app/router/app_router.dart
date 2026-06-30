import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import 'package:anufit/app/router/main_shell_scaffold.dart';
import 'package:anufit/app/router/app_routes.dart';
import 'package:anufit/core/di/injection.dart';
import 'package:anufit/core/enums/onboarding_step.dart';
import 'package:anufit/features/analytics/analytics_injection.dart';
import 'package:anufit/features/achievements/presentation/pages/achievements_page.dart';
import 'package:anufit/features/activity/presentation/pages/timeline_page.dart';
import 'package:anufit/features/dashboard/dashboard_injection.dart';
import 'package:anufit/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:anufit/features/goals/presentation/pages/goal_dashboard_page.dart';
import 'package:anufit/features/health/health_injection.dart';
import 'package:anufit/features/health/presentation/pages/health_settings_page.dart';
import 'package:anufit/features/history/presentation/pages/history_page.dart';
import 'package:anufit/features/lifestyle/lifestyle_injection.dart';
import 'package:anufit/features/backup/presentation/pages/backup_page.dart';
import 'package:anufit/features/export/presentation/pages/export_hub_page.dart';
import 'package:anufit/features/production/production_injection.dart';
import 'package:anufit/features/release/presentation/pages/privacy_policy_page.dart';
import 'package:anufit/features/release/presentation/pages/release_info_page.dart';
import 'package:anufit/features/security/presentation/pages/security_page.dart';
import 'package:anufit/features/sync/presentation/pages/cloud_sync_page.dart';
import 'package:anufit/features/widgets/presentation/pages/widget_settings_page.dart';
import 'package:anufit/features/motivation/motivation_injection.dart';
import 'package:anufit/features/profile/presentation/pages/profile_page.dart';
import 'package:anufit/features/reminder/presentation/pages/reminder_page.dart';
import 'package:anufit/features/reports/presentation/pages/reports_page.dart';
import 'package:anufit/features/settings/presentation/pages/settings_page.dart';
import 'package:anufit/features/statistics/presentation/pages/statistics_page.dart';
import 'package:anufit/features/water/presentation/pages/water_page.dart';
import 'package:anufit/features/weight/presentation/pages/weight_page.dart';
import 'package:anufit/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:anufit/features/onboarding/presentation/pages/onboarding_features_page.dart';
import 'package:anufit/features/onboarding/presentation/pages/onboarding_finish_page.dart';
import 'package:anufit/features/onboarding/presentation/pages/onboarding_goal_page.dart';
import 'package:anufit/features/onboarding/presentation/pages/onboarding_health_page.dart';
import 'package:anufit/features/onboarding/presentation/pages/onboarding_permissions_page.dart';
import 'package:anufit/features/onboarding/presentation/pages/onboarding_profile_page.dart';
import 'package:anufit/features/onboarding/presentation/pages/onboarding_walking_page.dart';
import 'package:anufit/features/onboarding/presentation/pages/onboarding_welcome_page.dart';
import 'package:anufit/features/splash/presentation/pages/splash_page.dart';

@lazySingleton
class AppRouter {
  late final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        builder: (BuildContext context, GoRouterState state) => const SplashPage(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        name: 'onboarding',
        redirect: (BuildContext context, GoRouterState state) {
          if (state.uri.path == AppRoutes.onboarding) {
            return AppRoutes.onboardingStep(OnboardingStep.welcome);
          }
          return null;
        },
        routes: <RouteBase>[
          for (final step in OnboardingStep.values)
            GoRoute(
              path: step.routeSuffix,
              name: 'onboarding-${step.routeSuffix}',
              builder: (BuildContext context, GoRouterState state) {
                return BlocProvider(
                  create: (_) => getIt<OnboardingBloc>()
                    ..add(OnboardingResumeAt(step)),
                  child: switch (step) {
                    OnboardingStep.welcome => const OnboardingWelcomePage(),
                    OnboardingStep.features => const OnboardingFeaturesPage(),
                    OnboardingStep.permissions => const OnboardingPermissionsPage(),
                    OnboardingStep.profile => const OnboardingProfilePage(),
                    OnboardingStep.goal => const OnboardingGoalPage(),
                    OnboardingStep.walkingPreferences => const OnboardingWalkingPage(),
                    OnboardingStep.healthIntegration => const OnboardingHealthPage(),
                    OnboardingStep.finish => const OnboardingFinishPage(),
                  },
                );
              },
            ),
        ],
      ),
      StatefulShellRoute.indexedStack(
        builder: (BuildContext context, GoRouterState state, StatefulNavigationShell shell) {
          return MainShellScaffold(navigationShell: shell);
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.dashboard,
                name: 'dashboard',
                builder: (BuildContext context, GoRouterState state) {
                  return MultiBlocProvider(
                    providers: DashboardInjection.providers,
                    child: const DashboardPage(),
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.history,
                name: 'history',
                builder: (BuildContext context, GoRouterState state) {
                  return MultiBlocProvider(
                    providers: HistoryInjection.providers,
                    child: const HistoryPage(),
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.statistics,
                name: 'statistics',
                builder: (BuildContext context, GoRouterState state) {
                  return MultiBlocProvider(
                    providers: StatisticsInjection.providers,
                    child: const StatisticsPage(),
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.goals,
                name: 'goals',
                builder: (BuildContext context, GoRouterState state) {
                  return MultiBlocProvider(
                    providers: GoalsInjection.providers,
                    child: const GoalDashboardPage(),
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.profile,
                name: 'profile',
                builder: (BuildContext context, GoRouterState state) {
                  return MultiBlocProvider(
                    providers: LifestyleInjection.profileProviders,
                    child: const ProfilePage(),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.activity,
        name: 'activity',
        builder: (BuildContext context, GoRouterState state) {
          return MultiBlocProvider(
            providers: ActivityInjection.providers,
            child: const TimelinePage(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.achievements,
        name: 'achievements',
        builder: (BuildContext context, GoRouterState state) {
          return MultiBlocProvider(
            providers: AchievementsInjection.providers,
            child: const AchievementsPage(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.reports,
        name: 'reports',
        builder: (BuildContext context, GoRouterState state) {
          return MultiBlocProvider(
            providers: ReportsInjection.providers,
            child: const ReportsPage(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.healthSync,
        name: 'health-sync',
        builder: (BuildContext context, GoRouterState state) {
          return MultiBlocProvider(
            providers: HealthInjection.providers,
            child: const HealthSettingsPage(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.weight,
        name: 'weight',
        builder: (BuildContext context, GoRouterState state) {
          return MultiBlocProvider(
            providers: LifestyleInjection.weightProviders,
            child: const WeightPage(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.water,
        name: 'water',
        builder: (BuildContext context, GoRouterState state) {
          return MultiBlocProvider(
            providers: LifestyleInjection.waterProviders,
            child: const WaterPage(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.reminder,
        name: 'reminder',
        builder: (BuildContext context, GoRouterState state) {
          return MultiBlocProvider(
            providers: LifestyleInjection.reminderProviders,
            child: const ReminderPage(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.settings,
        name: 'settings',
        builder: (BuildContext context, GoRouterState state) {
          return MultiBlocProvider(
            providers: LifestyleInjection.settingsProviders,
            child: const SettingsPage(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.backup,
        name: 'backup',
        builder: (BuildContext context, GoRouterState state) {
          return MultiBlocProvider(
            providers: ProductionInjection.backupProviders,
            child: const BackupPage(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.exportHub,
        name: 'export',
        builder: (BuildContext context, GoRouterState state) => const ExportHubPage(),
      ),
      GoRoute(
        path: AppRoutes.cloudSync,
        name: 'cloud-sync',
        builder: (BuildContext context, GoRouterState state) {
          return MultiBlocProvider(
            providers: ProductionInjection.syncProviders,
            child: const CloudSyncPage(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.widgets,
        name: 'widgets',
        builder: (BuildContext context, GoRouterState state) {
          return MultiBlocProvider(
            providers: ProductionInjection.widgetProviders,
            child: const WidgetSettingsPage(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.security,
        name: 'security',
        builder: (BuildContext context, GoRouterState state) {
          return MultiBlocProvider(
            providers: ProductionInjection.securityProviders,
            child: const SecurityPage(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.release,
        name: 'release',
        builder: (BuildContext context, GoRouterState state) => const ReleaseInfoPage(),
      ),
      GoRoute(
        path: AppRoutes.privacyPolicy,
        name: 'privacyPolicy',
        builder: (BuildContext context, GoRouterState state) => const PrivacyPolicyPage(),
      ),
    ],
  );
}
