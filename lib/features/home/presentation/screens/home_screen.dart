import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:v2g/features/home/presentation/widgets/action_card.dart';
import 'package:v2g/features/home/presentation/widgets/battery_progress_bar.dart';
import 'package:v2g/features/home/presentation/widgets/usage_line_chart.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Percentage Display
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    '56%',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
              ),
              // Status Text
              Center(
                child: Text(
                  'Discharging',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              const SizedBox(height: 20),
              // Usage Line Chart
              Container(
                height: 220,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade800, width: 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Expanded(
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
                ),
              ),
              const Spacer(),
              // Remaining Time Display
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text('Remaining Time', 
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(width: 8),
                    Text('1h40m', 
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              // Battery Progress Indicator with icons
              Row(
                children: [
                  // Car icon (EV)
                  Icon(Icons.electric_car, color: Colors.white),
                  const SizedBox(width: 8),
                  // Progress bar
                  Expanded(child: BatteryProgressBar()),
                  const SizedBox(width: 8),
                  // Home icon
                  Icon(Icons.battery_full, color: Colors.white),
                ],
              ),
              // Line indicator outside progress bar
              Container(
                width: 2,
                height: 10,
                color: Colors.red,
                margin: const EdgeInsets.only(right: 200),
              ),
              // Percentage indicator below progress bar and line
              const Padding(
                padding: EdgeInsets.only(top: 4.0),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 75.0),
                      child: Text('20%', style: TextStyle(color: Colors.grey)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // User Actions Card - Contains Battery Stats and any actions
              ActionCard(),
              const SizedBox(height: 32),
              // Page Indicator Dots without Scrollbar
            ],
          ),
        ),
      ),
    );
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
}
