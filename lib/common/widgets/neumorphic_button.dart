// neumorphic_button.dart
// A minimalistic neumorphic-style button for Flutter applications with loading state.

import 'package:flutter/material.dart';
import 'package:v2g/core/utils/theming.dart';

/// A neumorphic button with press animation and loading indicator.
///
/// - [child]: content inside the button (e.g., Text or Icon).
/// - [onPressed]: callback when tapped.
/// - [isLoading]: shows a circular indicator when true.
/// - [width], [height]: dimensions of the button.
class NeumorphicButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double width;
  final double height;

  const NeumorphicButton({
    super.key,
    required this.child,
    this.onPressed,
    this.isLoading = false,
    this.width = 100,
    this.height = 50,
  });

  @override
  _NeumorphicButtonState createState() => _NeumorphicButtonState();
}

class _NeumorphicButtonState extends State<NeumorphicButton> {
  bool _isPressed = false;

  void _onTapDown(TapDownDetails details) {
    if (!widget.isLoading) {
      setState(() {
        _isPressed = true;
        
      });
    }
  }

  void _onTapUp(TapUpDetails details) {
    if (!widget.isLoading) {
      setState(() => _isPressed = false);
      widget.onPressed?.call();
    }
  }

  void _onTapCancel() {
    if (!widget.isLoading) setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final baseColor = context.colorScheme.surface;
    final isDark = theme.brightness == Brightness.dark;

    // Shadow and highlight colors adapt to theme
    final shadowColor = isDark
        ? Colors.black.withValues(alpha: .6)
        : context.colorScheme.onSurface.withValues(alpha: .15);
    final highlightColor = isDark
        ? Colors.white.withValues(alpha: .1)
        : Colors.white.withValues(alpha: .7);
    final offset = _isPressed ? 2.0 : 6.0;
    final shadowBlur = _isPressed ? 4.0 : 12.0;
    final highlightBlur = isDark
        ? (_isPressed ? 2.0 : 6.0)
        : shadowBlur;
    final scale = _isPressed ? 0.96 : 1.0;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: widget.width,
        height: widget.height,
        transform: Matrix4.identity()..scale(scale, scale),
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(widget.height / 3),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              offset: Offset(offset, offset),
              blurRadius: shadowBlur,
            ),
            BoxShadow(
              color: highlightColor,
              offset: Offset(-offset, -offset),
              blurRadius: highlightBlur,
            ),
          ],
        ),
        child: Center(
          child: widget.isLoading
              ? SizedBox(
                  width: widget.height * 0.5,
                  height: widget.height * 0.5,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(context.colorScheme.primary),
                  ),
                )
              : widget.child,
        ),
      ),
    );
  }
}