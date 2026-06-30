part of 'settings_bloc.dart';

sealed class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

class SettingsLoadRequested extends SettingsEvent {
  const SettingsLoadRequested();
}

class SettingsThemeChanged extends SettingsEvent {
  const SettingsThemeChanged(this.theme);

  final String theme;

  @override
  List<Object?> get props => [theme];
}

class SettingsLanguageChanged extends SettingsEvent {
  const SettingsLanguageChanged(this.language);

  final String language;

  @override
  List<Object?> get props => [language];
}

class SettingsNotificationsToggled extends SettingsEvent {
  const SettingsNotificationsToggled(this.enabled);

  final bool enabled;

  @override
  List<Object?> get props => [enabled];
}

class SettingsClearCacheRequested extends SettingsEvent {
  const SettingsClearCacheRequested();
}

class SettingsUnitChanged extends SettingsEvent {
  const SettingsUnitChanged(this.unit);

  final UnitSystem unit;

  @override
  List<Object?> get props => [unit];
}
