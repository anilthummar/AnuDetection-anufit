import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:anufit/app/app_preferences_controller.dart';
import 'package:anufit/core/database/isar_service.dart';
import 'package:anufit/core/enums/unit_system.dart';
import 'package:anufit/features/onboarding/domain/entities/user_entity.dart';
import 'package:anufit/features/history/data/models/daily_summary_model.dart';
import 'package:anufit/features/history/data/models/monthly_summary_model.dart';
import 'package:anufit/features/history/data/models/weekly_summary_model.dart';
import 'package:anufit/features/onboarding/domain/entities/app_settings_entity.dart';
import 'package:anufit/features/onboarding/domain/repository/onboarding_repository.dart';

part 'settings_event.dart';
part 'settings_state.dart';

@injectable
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc(this._repository, this._isar, this._preferences) : super(const SettingsInitial()) {
    on<SettingsLoadRequested>(_onLoad);
    on<SettingsThemeChanged>(_onTheme);
    on<SettingsLanguageChanged>(_onLanguage);
    on<SettingsNotificationsToggled>(_onNotifications);
    on<SettingsUnitChanged>(_onUnit);
    on<SettingsClearCacheRequested>(_onClearCache);
  }

  final OnboardingRepository _repository;
  final IsarService _isar;
  final AppPreferencesController _preferences;

  Future<void> _onLoad(SettingsLoadRequested event, Emitter<SettingsState> emit) async {
    emit(const SettingsLoading());
    try {
      final settings = await _repository.getSettings();
      final user = await _repository.getUser();
      emit(SettingsLoaded(
        settings: settings,
        unit: user?.unit ?? UnitSystem.metric,
      ));
    } catch (e) {
      emit(SettingsError(e.toString()));
    }
  }

  Future<void> _onTheme(SettingsThemeChanged event, Emitter<SettingsState> emit) async {
    final current = state;
    if (current is! SettingsLoaded) return;
    await _preferences.setTheme(event.theme);
    final settings = await _repository.getSettings();
    emit(current.copyWith(settings: settings));
  }

  Future<void> _onLanguage(SettingsLanguageChanged event, Emitter<SettingsState> emit) async {
    final current = state;
    if (current is! SettingsLoaded) return;
    await _preferences.setLanguage(event.language);
    final settings = await _repository.getSettings();
    emit(current.copyWith(settings: settings));
  }

  Future<void> _onUnit(SettingsUnitChanged event, Emitter<SettingsState> emit) async {
    final current = state;
    if (current is! SettingsLoaded) return;
    final user = await _repository.getUser();
    if (user == null) return;
    await _repository.saveUser(_userWithUnit(user, event.unit));
    emit(current.copyWith(unit: event.unit));
  }

  UserEntity _userWithUnit(UserEntity user, UnitSystem unit) {
    return UserEntity(
      id: user.id,
      name: user.name,
      age: user.age,
      gender: user.gender,
      height: user.height,
      weight: user.weight,
      dailyGoal: user.dailyGoal,
      strideLength: user.strideLength,
      unit: unit,
      autoStride: user.autoStride,
      walkingSpeed: user.walkingSpeed,
      createdAt: user.createdAt,
    );
  }

  Future<void> _onNotifications(
    SettingsNotificationsToggled event,
    Emitter<SettingsState> emit,
  ) async {
    final current = state;
    if (current is! SettingsLoaded) return;
    final updated = current.settings.copyWith(notificationsEnabled: event.enabled);
    await _repository.saveSettings(updated);
    emit(current.copyWith(settings: updated));
  }

  Future<void> _onClearCache(SettingsClearCacheRequested event, Emitter<SettingsState> emit) async {
    await _isar.db.writeTxn(() async {
      await _isar.db.dailySummaryModels.clear();
      await _isar.db.weeklySummaryModels.clear();
      await _isar.db.monthlySummaryModels.clear();
    });
    emit(const SettingsCacheCleared());
  }
}
