import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:anufit/app/router/app_routes.dart';
import 'package:anufit/app/theme/app_colors.dart';
import 'package:anufit/core/di/injection.dart';
import 'package:anufit/core/enums/onboarding_step.dart';
import 'package:anufit/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:anufit/features/onboarding/presentation/bloc/permission_bloc.dart';
import 'package:anufit/features/onboarding/presentation/widgets/onboarding_layout.dart';
import 'package:anufit/shared/widgets/design_system.dart';

class OnboardingPermissionsPage extends StatelessWidget {
  const OnboardingPermissionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PermissionBloc>()..add(const PermissionLoadStatus()),
      child: const _PermissionsView(),
    );
  }
}

class _PermissionsView extends StatelessWidget {
  const _PermissionsView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PermissionBloc, PermissionState>(
      builder: (context, state) {
        return OnboardingLayout(
          title: 'Permissions',
          isLoading: state.isLoading,
          onContinue: () => _goNext(context, OnboardingStep.profile),
          secondaryAction: AppButton(
            label: 'Open Settings',
            variant: AppButtonVariant.text,
            onPressed: () => context.read<PermissionBloc>().add(const PermissionOpenSettings()),
            expand: false,
          ),
          child: Column(
            children: [
              _PermissionTile(
                title: 'Activity Recognition',
                subtitle: 'Required to count steps and distance',
                granted: state.activityGranted,
                deniedPermanently: state.activityDeniedPermanently,
                onRequest: () => context.read<PermissionBloc>().add(const PermissionRequestActivity()),
              ),
              const SizedBox(height: 12),
              _PermissionTile(
                title: 'Notifications',
                subtitle: 'Reminders and daily goal updates',
                granted: state.notificationsGranted,
                deniedPermanently: state.notificationsDeniedPermanently,
                onRequest: () =>
                    context.read<PermissionBloc>().add(const PermissionRequestNotifications()),
              ),
              const SizedBox(height: 16),
              Text(
                'You can continue even if some permissions are denied. '
                'Grant them later in Settings for full functionality.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        );
      },
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

class _PermissionTile extends StatelessWidget {
  const _PermissionTile({
    required this.title,
    required this.subtitle,
    required this.granted,
    required this.deniedPermanently,
    required this.onRequest,
  });

  final String title;
  final String subtitle;
  final bool granted;
  final bool deniedPermanently;
  final VoidCallback onRequest;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                Text(subtitle),
                if (deniedPermanently)
                  Text(
                    'Denied — open Settings to enable',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
              ],
            ),
          ),
          if (granted)
            const Icon(Icons.check_circle, color: AppColors.success)
          else
            AppButton(
              label: 'Allow',
              expand: false,
              onPressed: onRequest,
            ),
        ],
      ),
    );
  }
}
