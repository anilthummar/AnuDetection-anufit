import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:anufit/app/router/app_routes.dart';
import 'package:anufit/core/di/injection.dart';
import 'package:anufit/core/enums/onboarding_step.dart';
import 'package:anufit/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:anufit/features/onboarding/presentation/bloc/permission_bloc.dart';
import 'package:anufit/features/onboarding/presentation/widgets/onboarding_layout.dart';
import 'package:anufit/features/permissions/presentation/widgets/permissions_content.dart';
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

class _PermissionsView extends StatefulWidget {
  const _PermissionsView();

  @override
  State<_PermissionsView> createState() => _PermissionsViewState();
}

class _PermissionsViewState extends State<_PermissionsView> with WidgetsBindingObserver {
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
      context.read<PermissionBloc>().add(const PermissionLoadStatus());
    }
  }

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
          child: const PermissionsContent(),
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
