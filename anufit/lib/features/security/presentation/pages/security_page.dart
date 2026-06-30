import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:anufit/features/security/presentation/bloc/security_bloc.dart';
import 'package:anufit/l10n/app_localizations.dart';
import 'package:anufit/shared/widgets/design_system.dart';

class SecurityPage extends StatelessWidget {
  const SecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.security)),
      body: BlocBuilder<SecurityBloc, SecurityState>(
        builder: (context, state) {
          if (state is! SecurityLoaded) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              SwitchListTile(
                title: const Text('Encrypt local backups by default'),
                subtitle: const Text('Uses secure platform storage for encryption keys'),
                value: state.encryptionEnabled,
                onChanged: (v) =>
                    context.read<SecurityBloc>().add(SecurityEncryptionToggled(v)),
              ),
              const SizedBox(height: 16),
              const AppCard(
                child: Text(
                  'Sensitive keys are stored in the platform secure enclave '
                  '(Keychain on iOS, EncryptedSharedPreferences on Android). '
                  'Health and profile data remain on-device in Isar.',
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
