/// Layout breakpoints for responsive design.
/// Never hardcode pixel widths in widgets — use [Breakpoints] via context extensions.
abstract final class Breakpoints {
  /// Phone: width < 600
  static const double phone = 600;

  /// Tablet: 600 ≤ width < 1024
  static const double tablet = 1024;

  /// Desktop: width ≥ 1024
}

enum DeviceType {
  phone,
  tablet,
  desktop,
}
