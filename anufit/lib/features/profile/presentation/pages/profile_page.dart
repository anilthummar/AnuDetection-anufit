import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';

import 'package:anufit/app/router/app_routes.dart';
import 'package:anufit/core/utils/unit_format.dart';
import 'package:anufit/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:anufit/features/profile/presentation/widgets/profile_header.dart';
import 'package:anufit/l10n/app_localizations.dart';
import 'package:anufit/shared/widgets/design_system.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLoaded && state.saveMessage != null) {
            if (state.saveMessage == 'Profile saved') {
              AppSnackBar.show(context, 'Profile saved successfully');
            } else {
              AppSnackBar.showError(context, state.saveMessage!);
            }
          }
        },
        builder: (context, state) {
          return switch (state) {
            ProfileLoading() || ProfileInitial() => const Center(child: CircularProgressIndicator()),
            ProfileError(:final message) => Center(child: Text(message)),
            ProfileLoaded(:final draft, :final isSaving) => ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  ProfileHeader(name: draft.name ?? 'User'),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ProfileStatCard(
                          label: 'Height',
                          value: UnitFormat.heightLabel(draft.height, draft.unit),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ProfileStatCard(
                          label: 'Weight',
                          value: UnitFormat.weightLabel(draft.weight, draft.unit),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: ProfileStatCard(label: 'Goal', value: '${draft.dailyGoal} steps'),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ProfileStatCard(
                          label: 'BMI',
                          value: state.view.bmi.toStringAsFixed(1),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  EditableProfileForm(
                    key: ValueKey(draft.id),
                    user: draft,
                    onChanged: (u) => context.read<ProfileBloc>().add(ProfileFieldChanged(u)),
                  ),
                  const SizedBox(height: 16),
                  AppButton(
                    label: 'Save Profile',
                    isLoading: isSaving,
                    onPressed: isSaving
                        ? null
                        : () => context.read<ProfileBloc>().add(const ProfileSaveRequested()),
                  ),
                  const SizedBox(height: 24),
                  Text('More', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  ListTile(
                    leading: const Icon(Icons.timeline_outlined),
                    title: const Text('Activity Timeline'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.push(AppRoutes.activity),
                  ),
                  ListTile(
                    leading: const Icon(Icons.favorite_outline),
                    title: const Text('Health Sync'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.push(AppRoutes.healthSync),
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings_outlined),
                    title: Text(l10n.settings),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.push(AppRoutes.settings),
                  ),
                ],
              ),
          };
        },
      ),
    );
  }
}
