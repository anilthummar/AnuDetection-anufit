import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:anufit/core/extensions/responsive_extension.dart';
import 'package:anufit/core/widgets/responsive_builder.dart';
import 'package:anufit/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:anufit/shared/widgets/design_system.dart';

class OnboardingLayout extends StatelessWidget {
  const OnboardingLayout({
    required this.title,
    required this.child,
    required this.onContinue,
    this.continueLabel = 'Continue',
    this.secondaryAction,
    this.isLoading = false,
    super.key,
  });

  final String title;
  final Widget child;
  final VoidCallback? onContinue;
  final String continueLabel;
  final Widget? secondaryAction;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final step = context.watch<OnboardingBloc>().state;
    return Scaffold(
      body: ResponsiveContainer(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(context.horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppProgressIndicator(
                  currentStep: step.stepIndex,
                  totalSteps: step.totalSteps,
                ),
                const SizedBox(height: 24),
                Text(title, style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 16),
                Expanded(child: SingleChildScrollView(child: child)),
                if (secondaryAction != null) ...[
                  secondaryAction!,
                  const SizedBox(height: 8),
                ],
                if (onContinue != null)
                  AppButton(
                    label: continueLabel,
                    onPressed: onContinue,
                    isLoading: isLoading,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
