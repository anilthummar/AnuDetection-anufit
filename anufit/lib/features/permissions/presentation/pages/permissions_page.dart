import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:anufit/app/router/app_routes.dart';
import 'package:anufit/core/constants/app_spacing.dart';
import 'package:anufit/core/di/injection.dart';
import 'package:anufit/core/widgets/responsive_builder.dart';
import 'package:anufit/features/onboarding/presentation/bloc/permission_bloc.dart';
import 'package:anufit/features/permissions/presentation/widgets/permissions_content.dart';
import 'package:anufit/shared/widgets/design_system.dart';

/// Standalone permissions screen shown when the user must re-grant access.
class PermissionsPage extends StatelessWidget {
  const PermissionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PermissionBloc>()..add(const PermissionLoadStatus()),
      child: const _PermissionsPageBody(),
    );
  }
}

class _PermissionsPageBody extends StatefulWidget {
  const _PermissionsPageBody();

  @override
  State<_PermissionsPageBody> createState() => _PermissionsPageBodyState();
}

class _PermissionsPageBodyState extends State<_PermissionsPageBody> with WidgetsBindingObserver {
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
        final activityReady = state.activityGranted;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Permissions'),
            leading: activityReady
                ? IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => context.go(AppRoutes.dashboard),
                  )
                : null,
            automaticallyImplyLeading: activityReady,
          ),
          body: ResponsiveContainer(
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                Text(
                  'Step counting needs Activity Recognition',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Permissions may be removed from App info in system settings. '
                  'Re-enable them here to continue tracking.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: AppSpacing.lg),
                if (state.isLoading)
                  const Center(child: CircularProgressIndicator())
                else
                  const PermissionsContent(),
                const SizedBox(height: AppSpacing.lg),
                AppButton(
                  label: 'Open Settings',
                  variant: AppButtonVariant.text,
                  onPressed: () =>
                      context.read<PermissionBloc>().add(const PermissionOpenSettings()),
                  expand: false,
                ),
                const SizedBox(height: AppSpacing.md),
                AppButton(
                  label: activityReady ? 'Continue' : 'Activity permission required',
                  onPressed: activityReady ? () => context.go(AppRoutes.dashboard) : null,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
