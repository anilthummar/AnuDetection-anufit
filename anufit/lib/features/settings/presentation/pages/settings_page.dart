import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:anufit/app/router/app_routes.dart';
import 'package:anufit/core/constants/release_features.dart';
import 'package:anufit/core/enums/unit_system.dart';
import 'package:anufit/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:anufit/features/settings/presentation/widgets/settings_section.dart';
import 'package:anufit/l10n/app_localizations.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: BlocConsumer<SettingsBloc, SettingsState>(
        listener: (context, state) {
          if (state is SettingsCacheCleared) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Analytics cache cleared')),
            );
          }
        },
        builder: (context, state) {
          return switch (state) {
            SettingsLoading() || SettingsInitial() => const Center(child: CircularProgressIndicator()),
            SettingsError(:final message) => Center(child: Text(message)),
            SettingsLoaded(:final settings, :final unit) => ListView(
                children: [
                  SettingsSection(
                    title: 'General',
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ThemeSelector(
                          value: settings.theme,
                          onChanged: (t) =>
                              context.read<SettingsBloc>().add(SettingsThemeChanged(t)),
                        ),
                      ),
                      SettingsTile(
                        title: 'Language',
                        subtitle: _languageLabel(settings.language, l10n),
                        onTap: () => _pickLanguage(context, settings.language, l10n),
                      ),
                      UnitSelector(
                        label: unit == UnitSystem.imperial ? 'Imperial' : 'Metric',
                        onTap: () => _pickUnit(context, unit),
                      ),
                    ],
                  ),
                  SettingsSection(
                    title: 'Notifications',
                    children: [
                      SwitchListTile(
                        title: const Text('Notifications'),
                        value: settings.notificationsEnabled,
                        onChanged: (v) => context
                            .read<SettingsBloc>()
                            .add(SettingsNotificationsToggled(v)),
                      ),
                      SettingsTile(
                        title: 'Manage Reminders',
                        onTap: () => context.push(AppRoutes.reminder),
                      ),
                    ],
                  ),
                  SettingsSection(
                    title: 'Health',
                    children: [
                      SettingsTile(
                        title: 'Health Connect / Apple Health',
                        onTap: () => context.push(AppRoutes.healthSync),
                      ),
                      if (Platform.isAndroid)
                        SettingsTile(
                          title: 'Battery optimization',
                          subtitle: 'Keep step counting reliable',
                          onTap: () => context.push(AppRoutes.batteryOptimization),
                        ),
                    ],
                  ),
                  SettingsSection(
                    title: 'Data & Production',
                    children: [
                      SettingsTile(
                        title: l10n.export,
                        onTap: () => context.push(AppRoutes.exportHub),
                      ),
                      SettingsTile(
                        title: l10n.backup,
                        onTap: () => context.push(AppRoutes.backup),
                      ),
                      if (ReleaseFeatures.cloudSync)
                        SettingsTile(
                          title: l10n.cloudSync,
                          onTap: () => context.push(AppRoutes.cloudSync),
                        ),
                      SettingsTile(
                        title: l10n.widgets,
                        onTap: () => context.push(AppRoutes.widgets),
                      ),
                      SettingsTile(
                        title: l10n.security,
                        onTap: () => context.push(AppRoutes.security),
                      ),
                      SettingsTile(
                        title: 'Clear Cache',
                        subtitle: 'Clear precomputed analytics',
                        onTap: () => context
                            .read<SettingsBloc>()
                            .add(const SettingsClearCacheRequested()),
                      ),
                    ],
                  ),
                  SettingsSection(
                    title: 'Account',
                    children: [
                      SettingsTile(
                        title: 'Profile',
                        onTap: () => context.go(AppRoutes.profile),
                      ),
                      SettingsTile(
                        title: l10n.releaseInfo,
                        onTap: () => context.push(AppRoutes.release),
                      ),
                    ],
                  ),
                ],
              ),
            SettingsCacheCleared() => const Center(child: CircularProgressIndicator()),
          };
        },
      ),
    );
  }

  String _languageLabel(String code, AppLocalizations l10n) => switch (code) {
        'hi' => l10n.languageHindi,
        'gu' => l10n.languageGujarati,
        _ => l10n.languageEnglish,
      };

  Future<void> _pickLanguage(
    BuildContext context,
    String current,
    AppLocalizations l10n,
  ) async {
    final options = <String, String>{
      'en': l10n.languageEnglish,
      if (ReleaseFeatures.partialLocales) ...{
        'hi': l10n.languageHindi,
        'gu': l10n.languageGujarati,
      },
    };
    final picked = await showDialog<String>(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('Language'),
        children: options.entries
            .map(
              (e) => SimpleDialogOption(
                onPressed: () => Navigator.pop(ctx, e.key),
                child: Text(e.key == current ? '${e.value} (current)' : e.value),
              ),
            )
            .toList(),
      ),
    );
    if (picked != null && context.mounted) {
      context.read<SettingsBloc>().add(SettingsLanguageChanged(picked));
    }
  }

  Future<void> _pickUnit(BuildContext context, UnitSystem current) async {
    final picked = await showDialog<UnitSystem>(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('Units'),
        children: UnitSystem.values
            .map(
              (u) => SimpleDialogOption(
                onPressed: () => Navigator.pop(ctx, u),
                child: Text(u == current ? '${u.name} (current)' : u.name),
              ),
            )
            .toList(),
      ),
    );
    if (picked != null && context.mounted) {
      context.read<SettingsBloc>().add(SettingsUnitChanged(picked));
    }
  }
}
