import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:anufit/app/router/app_routes.dart';
import 'package:anufit/core/di/injection.dart';
import 'package:anufit/core/enums/onboarding_step.dart';
import 'package:anufit/features/onboarding/presentation/bloc/goal_bloc.dart';
import 'package:anufit/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:anufit/features/onboarding/presentation/widgets/onboarding_layout.dart';
import 'package:anufit/shared/widgets/design_system.dart';

class OnboardingGoalPage extends StatelessWidget {
  const OnboardingGoalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<GoalBloc>()..add(const GoalLoadExisting()),
      child: BlocListener<GoalBloc, GoalState>(
        listener: (context, state) {
          if (state.isSaved) {
            _navigateNext(context);
            context.read<GoalBloc>().add(const GoalSaveAcknowledged());
          }
        },
        child: BlocBuilder<GoalBloc, GoalState>(
          builder: (context, state) {
            return OnboardingLayout(
              title: 'Daily Step Goal',
              isLoading: state.isSaving,
              onContinue: () => context.read<GoalBloc>().add(const GoalSaveRequested()),
              child: Column(
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: GoalState.presets.map((goal) {
                      final selected = !state.isCustom && state.selectedGoal == goal;
                      return ChoiceChip(
                        label: Text('$goal'),
                        selected: selected,
                        onSelected: (_) =>
                            context.read<GoalBloc>().add(GoalPresetSelected(goal)),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    label: 'Custom goal',
                    keyboardType: TextInputType.number,
                    onChanged: (v) => context.read<GoalBloc>().add(GoalCustomChanged(v)),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _navigateNext(BuildContext context) async {
    final onboardingBloc = context.read<OnboardingBloc>();
    onboardingBloc.add(const OnboardingGoToStep(OnboardingStep.walkingPreferences));
    await onboardingBloc.stream.firstWhere(
      (s) => s.currentStep == OnboardingStep.walkingPreferences,
    );
    if (context.mounted) {
      context.go(AppRoutes.onboardingStep(OnboardingStep.walkingPreferences));
    }
  }
}
