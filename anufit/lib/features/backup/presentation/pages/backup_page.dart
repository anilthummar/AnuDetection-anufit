import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:anufit/features/backup/presentation/bloc/backup_bloc.dart';
import 'package:anufit/l10n/app_localizations.dart';
import 'package:anufit/shared/widgets/design_system.dart';

class BackupPage extends StatefulWidget {
  const BackupPage({super.key});

  @override
  State<BackupPage> createState() => _BackupPageState();
}

class _BackupPageState extends State<BackupPage> {
  bool _encrypt = true;
  final _passphraseController = TextEditingController();

  @override
  void dispose() {
    _passphraseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.backup)),
      body: BlocConsumer<BackupBloc, BackupState>(
        listener: (context, state) {
          if (state is BackupRestored) {
            AppSnackBar.show(context, 'Backup restored. Restart the app if needed.');
          }
          if (state is BackupError) {
            AppSnackBar.showError(context, state.message);
          }
        },
        builder: (context, state) {
          final loading = state is BackupLoading;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              SwitchListTile(
                title: Text(l10n.backupEncrypted),
                value: _encrypt,
                onChanged: loading ? null : (v) => setState(() => _encrypt = v),
              ),
              if (_encrypt)
                AppTextField(
                  label: 'Passphrase (optional)',
                  controller: _passphraseController,
                  obscureText: true,
                ),
              const SizedBox(height: 16),
              AppButton(
                label: l10n.backupExport,
                isLoading: loading,
                onPressed: loading
                    ? null
                    : () => context.read<BackupBloc>().add(
                          BackupExportRequested(
                            encrypt: _encrypt,
                            passphrase: _passphraseController.text.isEmpty
                                ? null
                                : _passphraseController.text,
                          ),
                        ),
              ),
              const SizedBox(height: 12),
              AppButton(
                label: l10n.backupRestore,
                variant: AppButtonVariant.secondary,
                isLoading: loading,
                onPressed: loading ? null : () => _pickAndRestore(context),
              ),
              const SizedBox(height: 24),
              const AppCard(
                child: Text(
                  'Backups include steps, goals, weight, water, reminders, and settings. '
                  'Encrypted backups use AES with a device key or your passphrase.',
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _pickAndRestore(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json', 'enc'],
    );
    final path = result?.files.single.path;
    if (path != null && context.mounted) {
      context.read<BackupBloc>().add(
            BackupRestoreRequested(
              path: path,
              passphrase: _passphraseController.text.isEmpty ? null : _passphraseController.text,
            ),
          );
    }
  }
}
