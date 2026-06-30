import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:anufit/app/router/app_routes.dart';
import 'package:anufit/core/di/injection.dart';
import 'package:anufit/core/enums/onboarding_step.dart';
import 'package:anufit/core/enums/unit_system.dart';
import 'package:anufit/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:anufit/features/onboarding/presentation/bloc/walking_preferences_bloc.dart';
import 'package:anufit/features/onboarding/presentation/widgets/onboarding_layout.dart';
import 'package:anufit/shared/widgets/design_system.dart';

class OnboardingWalkingPage extends StatelessWidget {
  const OnboardingWalkingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<WalkingPreferencesBloc>()..add(const WalkingPreferencesLoadExisting()),
      child: BlocListener<WalkingPreferencesBloc, WalkingPreferencesState>(
        listener: (context, state) {
          if (state.isSaved) {
            _navigateNext(context);
            context.read<WalkingPreferencesBloc>().add(const WalkingPreferencesSaveAcknowledged());
          }
        },
        child: BlocBuilder<WalkingPreferencesBloc, WalkingPreferencesState>(
          builder: (context, state) {
            return OnboardingLayout(
              title: 'Walking Preferences',
              isLoading: state.isSaving,
              onContinue: () =>
                  context.read<WalkingPreferencesBloc>().add(const WalkingPreferencesSaveRequested()),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Units', style: Theme.of(context).textTheme.titleMedium),
                  SegmentedButton<UnitSystem>(
                    segments: const [
                      ButtonSegment(value: UnitSystem.metric, label: Text('Metric')),
                      ButtonSegment(value: UnitSystem.imperial, label: Text('Imperial')),
                    ],
                    selected: {state.unit},
                    onSelectionChanged: (s) => context
                        .read<WalkingPreferencesBloc>()
                        .add(WalkingPreferencesUnitChanged(s.first)),
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: const Text('Auto stride calculation (recommended)'),
                    value: state.autoStride,
                    onChanged: (v) => context
                        .read<WalkingPreferencesBloc>()
                        .add(WalkingPreferencesAutoStrideChanged(v)),
                  ),
                  if (!state.autoStride)
                    AppTextField(
                      label: 'Stride length (m)',
                      keyboardType: TextInputType.number,
                      onChanged: (v) => context.read<WalkingPreferencesBloc>().add(
                            WalkingPreferencesStrideChanged(
                              double.tryParse(v) ?? state.strideLength,
                            ),
                          ),
                    ),
                  AppTextField(
                    label: 'Walking speed (optional, km/h)',
                    keyboardType: TextInputType.number,
                    onChanged: (v) => context.read<WalkingPreferencesBloc>().add(
                          WalkingPreferencesWalkingSpeedChanged(double.tryParse(v)),
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

  Future<void> _navigateNext(BuildContext context) async {
    final onboardingBloc = context.read<OnboardingBloc>();
    onboardingBloc.add(const OnboardingGoToStep(OnboardingStep.healthIntegration));
    await onboardingBloc.stream.firstWhere(
      (s) => s.currentStep == OnboardingStep.healthIntegration,
    );
    if (context.mounted) {
      context.go(AppRoutes.onboardingStep(OnboardingStep.healthIntegration));
    }
  }
}
