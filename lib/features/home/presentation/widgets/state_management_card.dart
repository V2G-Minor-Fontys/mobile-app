import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:v2g/features/home/application/home_controller.dart';

class StateManagementCard extends StatelessWidget {
  final BoxConstraints constraints;
  final HomeController homeController;

  const StateManagementCard({
    super.key,
    required this.constraints,
    required this.homeController,
  });

  @override
  Widget build(BuildContext context) {
    return ShadCard(
      width: constraints.maxWidth * 0.9,
      padding: EdgeInsets.symmetric(
          horizontal: constraints.maxWidth * 0.1, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Spacer(),
              Text(
                "State Management",
                style: ShadTheme.of(context).textTheme.small,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "76%",
              style: ShadTheme.of(context).textTheme.h1Large,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: homeController.isDischarging
                  ? Text("Discharging", style: ShadTheme.of(context).textTheme.h3)
                  : Text("Ready to discharge", style: ShadTheme.of(context).textTheme.h3),
              ),
            ),
          const SizedBox(
            height: 20,
          ),
            ShadButton.outline(
              width: double.infinity,
              height: 48,
              decoration: ShadDecoration(
                border: ShadBorder.all(
                  color: homeController.isDischarging
                      ? Colors.red.shade500
                      : Colors.green.shade500,
                ),
              ),
              child: homeController.isDischarging
                  ? const Text("Stop Discharging")
                  : const Text("Start Discharging"),
              onPressed: () {
                homeController.updateIsDischarging();
              },
            ),
        ],
      ),
    );
  }
}
