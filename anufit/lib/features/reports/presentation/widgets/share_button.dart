import 'package:flutter/material.dart';

import 'package:anufit/shared/widgets/design_system.dart';

class ShareButton extends StatelessWidget {
  const ShareButton({required this.onPressed, super.key});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      onPressed: onPressed,
      label: 'Share Report',
      variant: AppButtonVariant.secondary,
    );
  }
}
