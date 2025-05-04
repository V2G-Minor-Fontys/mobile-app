import 'package:flutter/material.dart';
import 'package:v2g/core/utils/theming.dart';

class OutlinedTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool obscureText;
  final ValueChanged<String>? onChanged;

  const OutlinedTextField({
    super.key,
    this.hintText,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(8);
    final disabledColor = context.colorScheme.onSurface.withValues(alpha: .3);

    return TextField(
      controller: controller,
      obscureText: obscureText,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: context.hintColor),
        prefixIcon: prefixIcon != null ? Icon(prefixIcon, size: 20, color: context.colorScheme.onSurface) : null,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        filled: true,
        fillColor: context.surface,
        border: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: disabledColor, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: disabledColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: context.colorScheme.primary, width: 1.5),
        ),
      ),
    );
  }
}