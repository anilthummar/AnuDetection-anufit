import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:anufit/app/router/app_routes.dart';
import 'package:anufit/core/di/injection.dart';
import 'package:anufit/core/enums/gender.dart';
import 'package:anufit/core/enums/onboarding_step.dart';
import 'package:anufit/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:anufit/features/onboarding/presentation/bloc/profile_bloc.dart';
import 'package:anufit/features/onboarding/presentation/widgets/onboarding_layout.dart';
import 'package:anufit/shared/widgets/design_system.dart';

class OnboardingProfilePage extends StatefulWidget {
  const OnboardingProfilePage({super.key});

  @override
  State<OnboardingProfilePage> createState() => _OnboardingProfilePageState();
}

class _OnboardingProfilePageState extends State<OnboardingProfilePage> {
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProfileBloc>()..add(const ProfileLoadExisting()),
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state.error != null) {
            AppSnackBar.showError(context, state.error!);
          }
          if (state.isSaved) {
            _navigateToGoal(context);
            context.read<ProfileBloc>().add(const ProfileSaveAcknowledged());
          }
        },
        builder: (context, state) {
          return OnboardingLayout(
            title: 'Personal Information',
            isLoading: state.isSaving,
            onContinue: () => context.read<ProfileBloc>().add(const ProfileSaveRequested()),
            child: Column(
              children: [
                AppTextField(
                  controller: _nameController,
                  label: 'Name (optional)',
                  onChanged: (v) => context.read<ProfileBloc>().add(ProfileNameChanged(v)),
                ),
                const SizedBox(height: 12),
                AppTextField(
                  label: 'Age',
                  keyboardType: TextInputType.number,
                  onChanged: (v) => context.read<ProfileBloc>().add(
                        ProfileAgeChanged(int.tryParse(v) ?? state.age),
                      ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<Gender>(
                  initialValue: state.gender,
                  decoration: const InputDecoration(labelText: 'Gender'),
                  items: Gender.values
                      .map((g) => DropdownMenuItem(value: g, child: Text(g.name)))
                      .toList(),
                  onChanged: (v) {
                    if (v != null) {
                      context.read<ProfileBloc>().add(ProfileGenderChanged(v));
                    }
                  },
                ),
                const SizedBox(height: 12),
                AppTextField(
                  label: 'Height (cm)',
                  keyboardType: TextInputType.number,
                  onChanged: (v) => context.read<ProfileBloc>().add(
                        ProfileHeightChanged(double.tryParse(v) ?? state.height),
                      ),
                ),
                const SizedBox(height: 12),
                AppTextField(
                  label: 'Weight (kg)',
                  keyboardType: TextInputType.number,
                  onChanged: (v) => context.read<ProfileBloc>().add(
                        ProfileWeightChanged(double.tryParse(v) ?? state.weight),
                      ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _navigateToGoal(BuildContext context) async {
    final onboardingBloc = context.read<OnboardingBloc>();
    onboardingBloc.add(const OnboardingGoToStep(OnboardingStep.goal));
    await onboardingBloc.stream.firstWhere((s) => s.currentStep == OnboardingStep.goal);
    if (context.mounted) {
      context.go(AppRoutes.onboardingStep(OnboardingStep.goal));
    }
  }
}
