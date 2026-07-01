import 'package:flutter/material.dart';

import 'package:anufit/core/constants/app_branding.dart';
import 'package:anufit/core/extensions/responsive_extension.dart';

/// Responsive app logo used on splash, onboarding, and branding surfaces.
class AppLogo extends StatelessWidget {
  const AppLogo({
    this.size,
    this.foreground = false,
    this.semanticLabel = 'Step Counter app logo',
    super.key,
  });

  final double? size;
  final bool foreground;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    final resolvedSize = size ??
        context.responsive(
          phone: 160,
          tablet: 200,
          desktop: 220,
        );

    return Semantics(
      label: semanticLabel,
      image: true,
      child: Image.asset(
        foreground ? AppBranding.logoForegroundAsset : AppBranding.logoAsset,
        width: resolvedSize,
        height: resolvedSize,
        fit: BoxFit.contain,
        filterQuality: FilterQuality.high,
      ),
    );
  }
}
