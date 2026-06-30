import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:anufit/app/router/app_routes.dart';
import 'package:anufit/core/enums/onboarding_step.dart';
import 'package:anufit/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:anufit/features/onboarding/presentation/widgets/onboarding_layout.dart';
import 'package:anufit/shared/widgets/design_system.dart';

class OnboardingFeaturesPage extends StatelessWidget {
  const OnboardingFeaturesPage({super.key});

  static const _features = <(IconData, String, String)>[
    (Icons.directions_walk, 'Step Tracking', 'Accurate daily step counts'),
    (Icons.local_fire_department_outlined, 'Calories', 'Estimate calories burned'),
    (Icons.straighten, 'Distance', 'Track how far you walk'),
    (Icons.water_drop_outlined, 'Water Tracking', 'Stay hydrated'),
    (Icons.monitor_weight_outlined, 'Weight Tracking', 'Monitor your progress'),
    (Icons.favorite_outline, 'Health Sync', 'Connect Apple Health / Health Connect'),
    (Icons.bar_chart_outlined, 'Reports', 'Insights over time'),
    (Icons.emoji_events_outlined, 'Achievements', 'Celebrate milestones'),
  ];

  @override
  Widget build(BuildContext context) {
    return OnboardingLayout(
      title: 'Everything you need',
      onContinue: () => _goNext(context, OnboardingStep.permissions),
      child: Column(
        children: _features
            .map(
              (f) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: AppCard(
                  child: Row(
                    children: [
                      Icon(f.$1),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(f.$2, style: Theme.of(context).textTheme.titleMedium),
                            Text(f.$3),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
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
