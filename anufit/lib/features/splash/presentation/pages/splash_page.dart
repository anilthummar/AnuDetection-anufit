import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:anufit/app/permission_resume_handler.dart';
import 'package:anufit/app/router/app_routes.dart';
import 'package:anufit/core/constants/app_branding.dart';
import 'package:anufit/core/constants/app_constants.dart';
import 'package:anufit/core/di/injection.dart';
import 'package:anufit/core/extensions/responsive_extension.dart';
import 'package:anufit/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:anufit/shared/widgets/app_logo.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SplashBloc>()..add(const SplashStarted()),
      child: const _SplashView(),
    );
  }
}

class _SplashView extends StatelessWidget {
  const _SplashView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (BuildContext context, SplashState state) {
        switch (state) {
          case SplashNavigateDashboard():
            context.go(AppRoutes.dashboard);
            handlePermissionResume(GoRouter.of(context));
          case SplashNavigateOnboarding(:final step):
            context.go(AppRoutes.onboardingStep(step));
          case SplashError(:final message):
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
          default:
            break;
        }
      },
      child: Scaffold(
        backgroundColor: AppBranding.splashBackground,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.92, end: 1),
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.easeOutBack,
                  builder: (context, scale, child) {
                    return Transform.scale(scale: scale, child: child);
                  },
                  child: AppLogo(
                    foreground: true,
                    size: context.responsive(
                      phone: 168,
                      tablet: 208,
                      desktop: 232,
                    ),
                  ),
                ),
                SizedBox(height: context.responsive(phone: 24, tablet: 28, desktop: 32)),
                Text(
                  AppConstants.appShortName,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.2,
                      ),
                ),
                SizedBox(height: context.responsive(phone: 32, tablet: 36, desktop: 40)),
                const SizedBox(
                  width: 32,
                  height: 32,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: Colors.white,
                    backgroundColor: Color(0x33FFFFFF),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
