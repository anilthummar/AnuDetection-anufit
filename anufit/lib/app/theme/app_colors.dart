import 'package:flutter/material.dart';

/// Single source of truth for app colors.
/// Never use [Color], [Colors], or hex literals outside this file.
abstract final class AppColors {
  // Brand
  static const Color primary = Color(0xFF2563EB);
  static const Color secondary = Color(0xFF7C3AED);

  // Semantic
  static const Color success = Color(0xFF16A34A);
  static const Color warning = Color(0xFFF59E0B);
  static const Color danger = Color(0xFFDC2626);
  static const Color info = Color(0xFF0EA5E9);

  // Light theme
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color text = Color(0xFF0F172A);
  static const Color border = Color(0xFFE2E8F0);

  // Dark theme
  static const Color backgroundDark = Color(0xFF0F172A);
  static const Color surfaceDark = Color(0xFF1E293B);
  static const Color textDark = Color(0xFFF8FAFC);
  static const Color borderDark = Color(0xFF334155);
}
