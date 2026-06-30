import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:anufit/core/constants/app_spacing.dart';
import 'package:anufit/core/widgets/responsive_builder.dart';
import 'package:anufit/features/health/presentation/bloc/health_settings_bloc.dart';
import 'package:anufit/features/health/presentation/widgets/health_source_chip.dart';
import 'package:anufit/features/health/presentation/widgets/health_status_card.dart';
import 'package:anufit/features/health/presentation/widgets/permission_tile.dart';
import 'package:anufit/features/health/presentation/widgets/sync_progress_dialog.dart';
import 'package:anufit/features/health/presentation/widgets/sync_status_card.dart';
import 'package:anufit/shared/widgets/design_system.dart';

class HealthSettingsPage extends StatelessWidget {
  const HealthSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Health Sync')),
      body: ResponsiveContainer(
        child: BlocConsumer<HealthSettingsBloc, HealthSettingsState>(
          listener: (context, state) {
            if (state is HealthSettingsLoaded && state.message != null) {
              AppSnackBar.show(context, state.message!);
            }
            if (state is HealthSettingsError) {
              AppSnackBar.showError(context, state.message);
            }
          },
          builder: (context, state) {
            return switch (state) {
              HealthSettingsInitial() || HealthSettingsLoading() =>
                const Center(child: CircularProgressIndicator()),
              HealthSettingsError(:final message) => Center(child: Text(message)),
              HealthSettingsLoaded() => _Body(state: state),
            };
          },
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.state});

  final HealthSettingsLoaded state;

  @override
  Widget build(BuildContext context) {
  if (!state.platformAvailable) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Text(
            'Health Connect is not installed or HealthKit is unavailable on this device.',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        HealthSourceChip(platform: state.status.platform),
        const SizedBox(height: AppSpacing.md),
        HealthStatusCard(
          connected: state.status.connected,
          platform: state.status.platform,
        ),
        const SizedBox(height: AppSpacing.md),
        SyncStatusCard(status: state.status),
        const SizedBox(height: AppSpacing.lg),
        Text('Permissions', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: AppSpacing.sm),
        PermissionsSection(permissions: state.status.permissions),
        const SizedBox(height: AppSpacing.lg),
        if (!state.status.connected)
          AppButton(
            label: 'Connect',
            isLoading: state.isBusy,
            onPressed: () =>
                context.read<HealthSettingsBloc>().add(const HealthConnectRequested()),
          ),
        if (state.status.connected) ...[
          AppButton(
            label: 'Sync Now',
            isLoading: state.isSyncing,
            onPressed: () async {
              SyncProgressDialog.show(context);
              context.read<HealthSettingsBloc>().add(const HealthSyncNowRequested());
              await Future<void>.delayed(const Duration(milliseconds: 500));
              if (context.mounted) SyncProgressDialog.hide(context);
            },
          ),
          const SizedBox(height: AppSpacing.sm),
          AppButton(
            label: 'View Permissions',
            variant: AppButtonVariant.secondary,
            onPressed: () => context
                .read<HealthSettingsBloc>()
                .add(const HealthViewPermissionsRequested()),
          ),
          const SizedBox(height: AppSpacing.sm),
          AppButton(
            label: 'Disconnect',
            variant: AppButtonVariant.text,
            onPressed: () =>
                context.read<HealthSettingsBloc>().add(const HealthDisconnectRequested()),
          ),
        ],
      ],
    );
  }
}
