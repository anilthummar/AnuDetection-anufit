import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:anufit/app/router/app_routes.dart';
import 'package:anufit/core/di/injection.dart';
import 'package:anufit/core/enums/onboarding_step.dart';
import 'package:anufit/features/onboarding/presentation/bloc/health_connect_bloc.dart';
import 'package:anufit/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:anufit/features/onboarding/presentation/widgets/onboarding_layout.dart';
import 'package:anufit/shared/widgets/design_system.dart';

class OnboardingHealthPage extends StatelessWidget {
  const OnboardingHealthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HealthConnectBloc>(),
      child: BlocListener<HealthConnectBloc, HealthConnectState>(
        listener: (context, state) {
          if (state.skipped || state.connectLater) {
            _goNext(context);
          }
        },
        child: BlocBuilder<HealthConnectBloc, HealthConnectState>(
          builder: (context, state) {
            final platformLabel = Platform.isIOS ? 'Apple Health' : 'Health Connect';
            return OnboardingLayout(
              title: 'Health Integration',
              isLoading: state.isSaving,
              onContinue: () => _goNext(context),
              continueLabel: 'Continue',
              secondaryAction: Column(
                children: [
                  AppButton(
                    label: 'Connect Later',
                    variant: AppButtonVariant.secondary,
                    onPressed: () =>
                        context.read<HealthConnectBloc>().add(const HealthConnectLaterRequested()),
                  ),
                  AppButton(
                    label: 'Skip',
                    variant: AppButtonVariant.text,
                    onPressed: () =>
                        context.read<HealthConnectBloc>().add(const HealthConnectSkipRequested()),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sync with $platformLabel',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Import steps, distance, and health data automatically. '
                          'You can set this up later from Settings.',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _goNext(BuildContext context) async {
    final onboardingBloc = context.read<OnboardingBloc>();
    onboardingBloc.add(const OnboardingGoToStep(OnboardingStep.finish));
    await onboardingBloc.stream.firstWhere((s) => s.currentStep == OnboardingStep.finish);
    if (context.mounted) {
      context.go(AppRoutes.onboardingStep(OnboardingStep.finish));
    }
  }
}
