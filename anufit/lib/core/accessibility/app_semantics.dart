import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

abstract final class AppSemantics {
  static Widget labeled({
    required String label,
    required Widget child,
    String? hint,
    bool button = false,
  }) {
    return Semantics(
      label: label,
      hint: hint,
      button: button,
      child: child,
    );
  }

  static void announce(BuildContext context, String message) {
    SemanticsService.announce(message, Directionality.of(context));
  }
}
