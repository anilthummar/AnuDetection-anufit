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
import 'package:anufit/shared/widgets/permission_guide_card.dart';

class OnboardingHealthPage extends StatefulWidget {
  const OnboardingHealthPage({super.key});

  @override
  State<OnboardingHealthPage> createState() => _OnboardingHealthPageState();
}

class _OnboardingHealthPageState extends State<OnboardingHealthPage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && mounted) {
      context.read<HealthConnectBloc>().add(const HealthConnectResumeCheck());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HealthConnectBloc>(),
      child: BlocListener<HealthConnectBloc, HealthConnectState>(
        listenWhen: (prev, curr) =>
            curr.skipped || curr.connectLater || curr.connected,
        listener: (context, state) {
          if (state.skipped || state.connectLater || state.connected) {
            _goNext(context);
          }
        },
        child: BlocBuilder<HealthConnectBloc, HealthConnectState>(
          builder: (context, state) {
            final platformLabel = Platform.isIOS ? 'Apple Health' : 'Health Connect';
            return OnboardingLayout(
              title: 'Health Integration',
              isLoading: state.isSaving,
              continueLabel: 'Connect $platformLabel',
              onContinue: () =>
                  context.read<HealthConnectBloc>().add(const HealthConnectRequested()),
              secondaryAction: Column(
                children: [
                  if (state.errorMessage != null) ...[
                    PermissionGuideCard(
                      message: state.errorMessage!,
                      actionLabel: switch (state.guidance) {
                        HealthConnectGuidance.grantActivityPermission =>
                          'Grant Activity Permission',
                        HealthConnectGuidance.openAppSettingsForActivity =>
                          'Open App Permissions',
                        HealthConnectGuidance.openHealthConnect =>
                          'Grant Health Connect Access',
                        null => 'Open Permissions',
                      },
                      onAction: () {
                        final bloc = context.read<HealthConnectBloc>();
                        switch (state.guidance) {
                          case HealthConnectGuidance.grantActivityPermission:
                            context.push(AppRoutes.permissions).then((_) {
                              if (context.mounted) {
                                bloc.add(const HealthConnectGuidanceHandled());
                              }
                            });
                          case HealthConnectGuidance.openAppSettingsForActivity:
                            bloc.add(const HealthConnectOpenSettingsRequested());
                          case HealthConnectGuidance.openHealthConnect:
                            bloc.add(const HealthConnectRequestHealthPermissions());
                          case null:
                            bloc.add(const HealthConnectRequested());
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                  ],
                  AppButton(
                    label: 'Connect Later',
                    variant: AppButtonVariant.secondary,
                    onPressed: () => context
                        .read<HealthConnectBloc>()
                        .add(const HealthConnectLaterRequested()),
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
                        Text(
                          'Step Counter needs permission to read your steps, distance, '
                          'and activity data. Tap "$platformLabel" above to allow access.',
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
