import 'package:flutter/material.dart';

import 'package:anufit/core/constants/breakpoints.dart';
import 'package:anufit/core/extensions/responsive_extension.dart';

typedef ResponsiveWidgetBuilder = Widget Function(
  BuildContext context,
  DeviceType deviceType,
);

/// Builds different layouts per breakpoint without hardcoding widths.
class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({
    required this.builder,
    super.key,
  });

  final ResponsiveWidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return builder(context, context.deviceType);
      },
    );
  }
}

/// Centers content and constrains max width on tablet/desktop.
class ResponsiveContainer extends StatelessWidget {
  const ResponsiveContainer({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: context.maxContentWidth),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.horizontalPadding),
          child: child,
        ),
      ),
    );
  }
}
