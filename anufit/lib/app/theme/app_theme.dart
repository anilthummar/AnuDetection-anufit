import 'package:flutter/material.dart';

import 'package:anufit/app/theme/app_colors.dart';
import 'package:anufit/app/theme/app_typography.dart';

abstract final class AppTheme {
  static ThemeData get light => _buildTheme(
        brightness: Brightness.light,
        background: AppColors.background,
        surface: AppColors.surface,
        text: AppColors.text,
        border: AppColors.border,
      );

  static ThemeData get dark => _buildTheme(
        brightness: Brightness.dark,
        background: AppColors.backgroundDark,
        surface: AppColors.surfaceDark,
        text: AppColors.textDark,
        border: AppColors.borderDark,
      );

  static ThemeData _buildTheme({
    required Brightness brightness,
    required Color background,
    required Color surface,
    required Color text,
    required Color border,
  }) {
    final isLight = brightness == Brightness.light;
    final colorScheme = isLight
        ? const ColorScheme.light(
            primary: AppColors.primary,
            secondary: AppColors.secondary,
            surface: AppColors.surface,
            error: AppColors.danger,
            onPrimary: AppColors.surface,
            onSecondary: AppColors.surface,
            onSurface: AppColors.text,
            onError: AppColors.surface,
          )
        : const ColorScheme.dark(
            primary: AppColors.primary,
            secondary: AppColors.secondary,
            surface: AppColors.surfaceDark,
            error: AppColors.danger,
            onPrimary: AppColors.textDark,
            onSecondary: AppColors.textDark,
            onSurface: AppColors.textDark,
            onError: AppColors.textDark,
          );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      fontFamily: 'Roboto',
      scaffoldBackgroundColor: background,
      colorScheme: colorScheme,
      textTheme: AppTypography.textTheme.apply(bodyColor: text, displayColor: text),
      dividerColor: border,
      appBarTheme: AppBarTheme(
        backgroundColor: surface,
        foregroundColor: text,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: surface,
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          side: BorderSide(color: border),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderSide: BorderSide(color: border)),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: border)),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
      extensions: const <ThemeExtension<dynamic>>[
        AppSemanticColors(),
      ],
    );
  }
}

/// Semantic colors beyond Material [ColorScheme].
class AppSemanticColors extends ThemeExtension<AppSemanticColors> {
  const AppSemanticColors({
    this.success = AppColors.success,
    this.warning = AppColors.warning,
    this.danger = AppColors.danger,
    this.info = AppColors.info,
    this.border = AppColors.border,
  });

  final Color success;
  final Color warning;
  final Color danger;
  final Color info;
  final Color border;

  @override
  AppSemanticColors copyWith({
    Color? success,
    Color? warning,
    Color? danger,
    Color? info,
    Color? border,
  }) {
    return AppSemanticColors(
      success: success ?? this.success,
      warning: warning ?? this.warning,
      danger: danger ?? this.danger,
      info: info ?? this.info,
      border: border ?? this.border,
    );
  }

  @override
  AppSemanticColors lerp(covariant ThemeExtension<AppSemanticColors>? other, double t) {
    if (other is! AppSemanticColors) return this;
    return AppSemanticColors(
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      info: Color.lerp(info, other.info, t)!,
      border: Color.lerp(border, other.border, t)!,
    );
  }
}

extension AppSemanticColorsX on BuildContext {
  AppSemanticColors get semanticColors =>
      Theme.of(this).extension<AppSemanticColors>()!;
}
