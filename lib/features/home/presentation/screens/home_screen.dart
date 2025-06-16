import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:v2g/features/automation/presentation/screens/automation_screen.dart';
import 'package:v2g/features/home/application/home_controller.dart';
import 'package:v2g/features/home/presentation/screens/home_page.dart';
import 'package:v2g/features/settings/presentation/screens/settings_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final controller = PageController(initialPage: 1);
  @override
  Widget build(BuildContext context) {
  final homeController = ref.watch(homeControllerProvider);

    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) => Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView(
              controller: controller,
              children: [
                SettingsScreen(constraints: constraints, homeController: homeController,),
                HomePage(constraints: constraints, homeController: homeController),
                AutomationListScreen(constraints: constraints, homeController: homeController),
              ],
            ),
            Positioned(
              bottom: constraints.minHeight * 0.05,
              child: SmoothPageIndicator(
                controller: controller,
                count: 3,
                effect: WormEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  activeDotColor: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
