part of 'settings_bloc.dart';

sealed class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object?> get props => [];
}

class SettingsInitial extends SettingsState {
  const SettingsInitial();
}

class SettingsLoading extends SettingsState {
  const SettingsLoading();
}

class SettingsLoaded extends SettingsState {
  const SettingsLoaded({required this.settings, required this.unit});

  final AppSettingsEntity settings;
  final UnitSystem unit;

  SettingsLoaded copyWith({
    AppSettingsEntity? settings,
    UnitSystem? unit,
  }) {
    return SettingsLoaded(
      settings: settings ?? this.settings,
      unit: unit ?? this.unit,
    );
  }

  @override
  List<Object?> get props => [settings, unit];
}

class SettingsCacheCleared extends SettingsState {
  const SettingsCacheCleared();
}

class SettingsError extends SettingsState {
  const SettingsError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
