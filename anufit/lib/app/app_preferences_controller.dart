import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'package:anufit/features/onboarding/domain/entities/app_settings_entity.dart';
import 'package:anufit/features/onboarding/domain/repository/onboarding_repository.dart';

/// Global theme/locale state so settings changes apply without restarting the app.
@lazySingleton
class AppPreferencesController extends ChangeNotifier {
  AppPreferencesController(this._repository);

  final OnboardingRepository _repository;

  ThemeMode themeMode = ThemeMode.system;
  Locale? locale;

  Future<void> load() async {
    try {
      final settings = await _repository.getSettings();
      _applyFromSettings(settings);
      notifyListeners();
    } catch (_) {}
  }

  Future<void> setTheme(String theme) async {
    final settings = await _repository.getSettings();
    await _repository.saveSettings(settings.copyWith(theme: theme));
    themeMode = _themeFromString(theme);
    notifyListeners();
  }

  Future<void> setLanguage(String language) async {
    final settings = await _repository.getSettings();
    await _repository.saveSettings(settings.copyWith(language: language));
    locale = _localeFromCode(language);
    notifyListeners();
  }

  void _applyFromSettings(AppSettingsEntity settings) {
    themeMode = _themeFromString(settings.theme);
    locale = _localeFromCode(settings.language);
  }

  ThemeMode _themeFromString(String theme) => switch (theme) {
        'light' => ThemeMode.light,
        'dark' => ThemeMode.dark,
        _ => ThemeMode.system,
      };

  Locale? _localeFromCode(String code) => switch (code) {
        'hi' => const Locale('hi'),
        'gu' => const Locale('gu'),
        'en' => const Locale('en'),
        _ => const Locale('en'),
      };
}
