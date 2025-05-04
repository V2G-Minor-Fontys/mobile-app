import 'package:flutter/material.dart';
import 'package:v2g/core/utils/theming.dart';

class StyledTextButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool enabled;

  const StyledTextButton({
    super.key,
    required this.label,
    this.onPressed,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = context.colorScheme.primary;
    final disabledTextColor = textColor.withValues(alpha: .5);

    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: enabled ? textColor : disabledTextColor,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      onPressed: enabled ? onPressed : null,
      child: Text(label),
    );
  }
}