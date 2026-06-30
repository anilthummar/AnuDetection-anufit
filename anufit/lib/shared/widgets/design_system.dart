import 'package:anufit/core/accessibility/app_semantics.dart';
import 'package:anufit/app/theme/app_colors.dart';
import 'package:flutter/material.dart';

enum AppButtonVariant { primary, secondary, text }

class AppButton extends StatelessWidget {
  const AppButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final bool isLoading;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final child = isLoading
        ? const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : Text(label);

    final button = switch (variant) {
      AppButtonVariant.primary => FilledButton(onPressed: isLoading ? null : onPressed, child: child),
      AppButtonVariant.secondary => OutlinedButton(onPressed: isLoading ? null : onPressed, child: child),
      AppButtonVariant.text => TextButton(onPressed: isLoading ? null : onPressed, child: child),
    };

    if (!expand) {
      return AppSemantics.labeled(label: label, button: true, child: button);
    }
    return SizedBox(
      width: double.infinity,
      child: AppSemantics.labeled(label: label, button: true, child: button),
    );
  }
}

class AppCard extends StatelessWidget {
  const AppCard({
    required this.child,
    super.key,
    this.onTap,
    this.padding = const EdgeInsets.all(16),
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final card = Card(
      child: Padding(padding: padding, child: child),
    );
    if (onTap == null) return card;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: card,
    );
  }
}

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.suffix,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        suffixIcon: suffix,
      ),
    );
  }
}

class AppProgressIndicator extends StatelessWidget {
  const AppProgressIndicator({
    required this.currentStep,
    required this.totalSteps,
    super.key,
  });

  final int currentStep;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    final progress = currentStep / totalSteps;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LinearProgressIndicator(
          value: progress,
          backgroundColor: AppColors.border,
          borderRadius: BorderRadius.circular(4),
        ),
        const SizedBox(height: 8),
        Text('Step $currentStep of $totalSteps'),
      ],
    );
  }
}

abstract final class AppSnackBar {
  static void show(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  static void showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.danger,
      ),
    );
  }
}
