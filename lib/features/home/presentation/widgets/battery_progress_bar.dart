import 'package:flutter/material.dart';

class BatteryProgressBar extends StatelessWidget {
  const BatteryProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background bar
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        // Progress fill (20%)
        FractionallySizedBox(
          widthFactor: 0.6,
          child: Container(
            height: 8,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        // Left marker (white dot)
        Positioned(
          left: 0,
          top: -4,
          child: Container(
            width: 16,
            height: 16,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}
