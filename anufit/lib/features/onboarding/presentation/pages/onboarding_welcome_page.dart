import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:anufit/app/router/app_routes.dart';
import 'package:anufit/core/enums/onboarding_step.dart';
import 'package:anufit/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:anufit/features/onboarding/presentation/widgets/onboarding_layout.dart';
import 'package:anufit/shared/widgets/design_system.dart';

class OnboardingWelcomePage extends StatelessWidget {
  const OnboardingWelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingLayout(
      title: 'Welcome to Anufit',
      onContinue: () => _goNext(context, OnboardingStep.features),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your personal health & step companion.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          const AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Track steps, distance & calories'),
                SizedBox(height: 8),
                Text('Set goals and build healthy habits'),
                SizedBox(height: 8),
                Text('Sync with health platforms'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _goNext(BuildContext context, OnboardingStep step) async {
    final bloc = context.read<OnboardingBloc>();
    bloc.add(OnboardingGoToStep(step));
    await bloc.stream.firstWhere((s) => s.currentStep == step);
    if (context.mounted) {
      context.go(AppRoutes.onboardingStep(step));
    }
  }
}
