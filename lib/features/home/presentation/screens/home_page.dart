import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:v2g/features/home/application/home_controller.dart';
import 'package:v2g/features/home/presentation/widgets/state_management_card.dart';
import 'package:v2g/features/home/presentation/widgets/usage_line_charg.dart';

class HomePage extends StatelessWidget {
  final BoxConstraints constraints;
  final HomeController homeController;


  const HomePage({
    super.key,
    required this.homeController,
    required this.constraints,
  });
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: homeController,
      builder: (context, child) => Stack(
        alignment: Alignment.topCenter,
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            left: 0,
            top: constraints.maxHeight * 0.2,
            height:
                homeController.isDischarging ? constraints.maxHeight * 0.7 : 0,
            width: homeController.isDischarging ? 7 : 0,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              opacity: homeController.isDischarging ? 1 : 0,
              child: ClipRRect(
                borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(16),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.4),
                    borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(16),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Colors.green.withOpacity(1),
                        Colors.green.withOpacity(0.2),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            right: 0,
            top: constraints.maxHeight * 0.2,
            height:
                homeController.isDischarging ? constraints.maxHeight * 0.7 : 0,
            width: homeController.isDischarging ? 7 : 0,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              opacity: homeController.isDischarging ? 1 : 0,
              child: ClipRRect(
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(10),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.4),
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(16),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Colors.green.withOpacity(1),
                        Colors.green.withOpacity(0.2),
                      ],
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(
                top: constraints.maxHeight * 0.1,
              ),
              child:
                  Text("Dashboard", style: ShadTheme.of(context).textTheme.h3),
            ),
          ),
          Positioned(
              top: constraints.maxHeight * 0.2,
              child: StateManagementCard(
                  constraints: constraints, homeController: homeController)),
          Positioned(
              top: constraints.maxHeight * 0.48,
              child: ShadCard(
                  width: constraints.maxWidth * 0.9,
                  padding: EdgeInsets.symmetric(
                      horizontal: constraints.maxWidth * 0.1, vertical: 16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Time To Discharge:",
                            style: ShadTheme.of(context).textTheme.small,
                          ),
                          const Spacer(),
                          Text(
                            "1H 30M",
                            style: ShadTheme.of(context).textTheme.small,
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.electric_car, color: Colors.white),
                          const SizedBox(width: 8),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.sizeOf(context).width * 0.5,
                            ),
                            child: const ShadProgress(value: 0.5),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.battery_full, color: Colors.white),
                        ],
                      ),
                    ],
                  ))),
          Positioned(
              bottom: constraints.minHeight * 0.1,
              child: ShadCard(
                width: constraints.maxWidth * 0.9,
                padding: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth * 0.1, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const Spacer(),
                        Text(
                          "Power Production/Consumption",
                          style: ShadTheme.of(context).textTheme.small,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 170,
                      child: UsageLineChart(),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildLegendItem('Home', Colors.green),
                        const SizedBox(width: 20),
                        _buildLegendItem('EV', Colors.red),
                        const SizedBox(width: 20),
                        _buildLegendItem('Grid', Colors.blue),
                      ],
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

Widget _buildLegendItem(String label, Color color) {
  return Row(
    children: [
      Container(
        width: 12,
        height: 4,
        color: color,
      ),
      const SizedBox(width: 4),
      Text(
        label,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 12,
        ),
      ),
    ],
  );
}
