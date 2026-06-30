import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:anufit/core/di/injection.dart';
import 'package:anufit/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:anufit/features/reminder/presentation/bloc/reminder_bloc.dart';
import 'package:anufit/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:anufit/features/water/presentation/bloc/water_bloc.dart';
import 'package:anufit/features/weight/presentation/bloc/weight_bloc.dart';

abstract final class LifestyleInjection {
  static List<BlocProvider> get weightProviders => [
        BlocProvider<WeightBloc>(
          create: (_) => getIt<WeightBloc>()..add(const WeightLoadRequested()),
        ),
      ];

  static List<BlocProvider> get waterProviders => [
        BlocProvider<WaterBloc>(
          create: (_) => getIt<WaterBloc>()..add(const WaterLoadRequested()),
        ),
      ];

  static List<BlocProvider> get reminderProviders => [
        BlocProvider<ReminderBloc>(
          create: (_) => getIt<ReminderBloc>()..add(const ReminderLoadRequested()),
        ),
      ];

  static List<BlocProvider> get profileProviders => [
        BlocProvider<ProfileBloc>(
          create: (_) => getIt<ProfileBloc>()..add(const ProfileLoadRequested()),
        ),
      ];

  static List<BlocProvider> get settingsProviders => [
        BlocProvider<SettingsBloc>(
          create: (_) => getIt<SettingsBloc>()..add(const SettingsLoadRequested()),
        ),
      ];
}
