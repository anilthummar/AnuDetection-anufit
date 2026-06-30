import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:anufit/app/permission_resume_handler.dart';
import 'package:anufit/app/router/app_routes.dart';
import 'package:anufit/app/theme/app_colors.dart';
import 'package:anufit/core/di/injection.dart';
import 'package:anufit/core/constants/app_constants.dart';
import 'package:anufit/core/extensions/responsive_extension.dart';
import 'package:anufit/features/splash/presentation/bloc/splash_bloc.dart';

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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.8, end: 1),
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOutBack,
                builder: (context, scale, child) {
                  return Transform.scale(scale: scale, child: child);
                },
                child: Container(
                  width: context.responsive(phone: 96, desktop: 120),
                  height: context.responsive(phone: 96, desktop: 120),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Icon(
                    Icons.directions_walk_rounded,
                    size: context.responsive(phone: 48, desktop: 60),
                    color: AppColors.surface,
                  ),
                ),
              ),
              SizedBox(height: context.responsive(phone: 24, desktop: 32)),
              Text(
                AppConstants.appShortName,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 24),
              const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
