import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:anufit/features/widgets/presentation/bloc/widget_bloc.dart';
import 'package:anufit/l10n/app_localizations.dart';
import 'package:anufit/shared/widgets/design_system.dart';

class WidgetSettingsPage extends StatelessWidget {
  const WidgetSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.widgets)),
      body: BlocConsumer<WidgetBloc, HomeWidgetBlocState>(
        listener: (context, state) {
          if (state is HomeWidgetSynced) {
            AppSnackBar.show(context, 'Home screen widget updated');
          }
          if (state is HomeWidgetError) {
            AppSnackBar.showError(context, state.message);
          }
        },
        builder: (context, state) {
          final syncing = state is HomeWidgetSyncing;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Supported sizes', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text('Android: small, medium, large'),
                    Text('iOS: small, medium, large, lock screen'),
                    SizedBox(height: 8),
                    Text('Shows: steps, goal progress, water intake, weight'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AppButton(
                label: 'Update widget now',
                isLoading: syncing,
                onPressed: syncing
                    ? null
                    : () => context.read<WidgetBloc>().add(const WidgetSyncRequested()),
              ),
              const SizedBox(height: 16),
              const Text(
                'Add the Anufit widget from your home screen widget gallery. '
                'Data refreshes when you open the app or tap Update.',
              ),
            ],
          );
        },
      ),
    );
  }
}
