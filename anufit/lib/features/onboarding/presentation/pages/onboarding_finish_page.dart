import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:anufit/app/router/app_routes.dart';
import 'package:anufit/core/di/injection.dart';
import 'package:anufit/features/onboarding/domain/entities/app_settings_entity.dart';
import 'package:anufit/features/onboarding/domain/entities/user_entity.dart';
import 'package:anufit/features/onboarding/domain/usecases/onboarding_usecases.dart';
import 'package:anufit/features/onboarding/presentation/widgets/onboarding_layout.dart';
import 'package:anufit/shared/widgets/design_system.dart';

class OnboardingFinishPage extends StatelessWidget {
  const OnboardingFinishPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadSummary(),
      builder: (context, snapshot) {
        final user = snapshot.data?.$1;
        final settings = snapshot.data?.$2;
        return OnboardingLayout(
          title: 'You\'re all set!',
          continueLabel: 'Start Tracking',
          onContinue: snapshot.connectionState == ConnectionState.done
              ? () => _complete(context)
              : null,
          isLoading: snapshot.connectionState != ConnectionState.done,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (user != null) ...[
                Text('Profile', style: Theme.of(context).textTheme.titleMedium),
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (user.name != null) Text('Name: ${user.name}'),
                      Text('Age: ${user.age}'),
                      Text('Height: ${user.height} cm'),
                      Text('Weight: ${user.weight} kg'),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
              if (user != null)
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Goal', style: Theme.of(context).textTheme.titleMedium),
                      Text('${user.dailyGoal} steps / day'),
                      Text('Units: ${user.unit.name}'),
                      if (user.strideLength != null)
                        Text('Stride: ${user.strideLength} m'),
                    ],
                  ),
                ),
              if (settings != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('App version: ${settings.appVersion}'),
                ),
            ],
          ),
        );
      },
    );
  }

  Future<(UserEntity?, AppSettingsEntity)> _loadSummary() async {
    final user = await getIt<GetUserProfileUseCase>()();
    final settings = await getIt<GetAppSettingsUseCase>()();
    return (user, settings);
  }

  Future<void> _complete(BuildContext context) async {
    await getIt<CompleteOnboardingUseCase>()();
    if (context.mounted) {
      context.go(AppRoutes.dashboard);
    }
  }
}
