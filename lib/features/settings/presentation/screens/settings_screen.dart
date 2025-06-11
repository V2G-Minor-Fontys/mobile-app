import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:v2g/features/home/application/home_controller.dart';

class SettingsScreen extends ConsumerWidget {
  final BoxConstraints constraints;
  final HomeController homeController;

  const SettingsScreen({
    super.key,
    required this.homeController,
    required this.constraints,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
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
            padding: EdgeInsets.only(top: constraints.maxHeight * 0.1),
            child: Text(
              "Settings",
              style: ShadTheme.of(context).textTheme.h3,
            ),
          ),
        ),
        Positioned(
          top: constraints.maxHeight * 0.2,
          child: ShadCard(
            width: constraints.maxWidth * 0.9,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              children: [
                _buildSettingsTile(
                  context,
                  icon: Icons.notifications,
                  title: 'Enable Notifications',
                  trailing: Consumer(
                    builder: (context, ref, _) {
                      final state = ref.watch(_notificationsProvider);
                      return ShadSwitch(
                        value: state,
                        onChanged: (val) {
                          ref.read(_notificationsProvider.notifier).state = val;
                        },
                      );
                    },
                  ),
                ),
                const Divider(),
                _buildSettingsTile(
                  context,
                  icon: Icons.lock,
                  title: 'Privacy',
                  subtitle: 'Manage your privacy settings',
                  onTap: () {},
                ),
                const Divider(),
                _buildSettingsTile(
                  context,
                  icon: Icons.language,
                  title: 'Language',
                  subtitle: 'Select app language',
                  onTap: () {
                    // Navigate to language settings
                  },
                ),
                const Divider(),
                _buildSettingsTile(
                  context,
                  icon: Icons.info,
                  title: 'About',
                  onTap: () {
                    showAboutDialog(
                      context: context,
                      applicationName: 'My App',
                      applicationVersion: '1.0.0',
                      applicationIcon: const Icon(Icons.settings),
                      children: const [
                        Text('This is a demo app for the settings page.'),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    VoidCallback? onTap,
    Widget? trailing,
  }) {
    return Material(
      child: ListTile(
        leading: Icon(icon, color: ShadTheme.of(context).colorScheme.primary),
        title: Text(title, style: ShadTheme.of(context).textTheme.small),
        subtitle: subtitle != null ? Text(subtitle) : null,
        onTap: onTap,
        trailing: trailing,
      ),
    );
  }
}

final _notificationsProvider = StateProvider<bool>((ref) => true);
