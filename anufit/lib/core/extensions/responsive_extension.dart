import 'package:flutter/material.dart';

import 'package:anufit/core/constants/breakpoints.dart';

extension ResponsiveExtension on BuildContext {
  Size get screenSize => MediaQuery.sizeOf(this);

  double get screenWidth => screenSize.width;

  double get screenHeight => screenSize.height;

  DeviceType get deviceType {
    final width = screenWidth;
    if (width < Breakpoints.phone) return DeviceType.phone;
    if (width < Breakpoints.tablet) return DeviceType.tablet;
    return DeviceType.desktop;
  }

  bool get isPhone => deviceType == DeviceType.phone;

  bool get isTablet => deviceType == DeviceType.tablet;

  bool get isDesktop => deviceType == DeviceType.desktop;

  /// Returns a value based on current [DeviceType].
  T responsive<T>({
    required T phone,
    T? tablet,
    required T desktop,
  }) {
    return switch (deviceType) {
      DeviceType.phone => phone,
      DeviceType.tablet => tablet ?? desktop,
      DeviceType.desktop => desktop,
    };
  }

  /// Horizontal padding that scales with device type.
  double get horizontalPadding => responsive<double>(
        phone: 16,
        tablet: 24,
        desktop: 32,
      );

  /// Max content width for centered layouts on large screens.
  double get maxContentWidth => responsive<double>(
        phone: screenWidth,
        tablet: 720,
        desktop: 1200,
      );
}
