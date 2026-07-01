import 'package:flutter/material.dart';

/// Shared branding assets and colors derived from [app_logo.png].
abstract final class AppBranding {
  static const String logoAsset = 'assets/images/app_logo.png';
  static const String logoForegroundAsset = 'assets/images/app_icon_foreground.png';

  /// Primary green from the app icon artwork.
  static const Color brandGreen = Color(0xFF09AA6C);

  static const Color splashBackground = brandGreen;
}
