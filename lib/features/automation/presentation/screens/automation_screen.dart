import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:v2g/features/automation/application/providers/automation_provider.dart';
import 'package:v2g/features/automation/domain/automation.dart';
import 'package:v2g/features/home/application/home_controller.dart';
import 'automation_builder_screen.dart';

class AutomationListScreen extends ConsumerWidget {
  final BoxConstraints constraints;
  final HomeController homeController;

  const AutomationListScreen({super.key, required this.homeController, required this.constraints});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final automations = ref.watch(automationListProvider);
    final notifier = ref.read(automationListProvider.notifier);

    return Stack(
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
        Padding(
          padding: EdgeInsets.only(top: constraints.maxHeight * 0.1),
          child: Text(
            "My Automations",
            style: ShadTheme.of(context).textTheme.h3,
          ),
        ),
        Positioned(
          top: constraints.maxHeight * 0.2,
          child: ShadCard(
            width: constraints.maxWidth * 0.9,
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              height: constraints.maxHeight * 0.66,
              child: automations.isEmpty
                  ? const Center(
                      child: Text(
                        "No automations yet. Tap + to add one!",
                        textAlign: TextAlign.center,
                      ),
                    )
                  : ListView.builder(
                      itemCount: automations.length,
                      itemBuilder: (context, index) {
                        final automation = automations[index];
                        return automationListItem(
                          automation: automation,
                          context: context,
                          index: index,
                          onEdit: (i) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AutomationBuilderScreen(
                                  initialAutomation: automation,
                                  indexToUpdate: index,
                                ),
                              ),
                            );
                          },
                          onDelete: (i) async {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Delete Automation"),
                                content: const Text(
                                    "Are you sure you want to delete this automation?"),
                                actions: [
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, false),
                                      child: const Text("Cancel")),
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, true),
                                      child: const Text("Delete")),
                                ],
                              ),
                            );
                            if (confirm == true) {
                              notifier.delete(i);
                            }
                          },
                        );
                      },
                    ),
            ),
          ),
        ),
        Positioned(
          bottom: constraints.maxHeight * 0.12,
          right: constraints.maxWidth * 0.1,
          child: ShadButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AutomationBuilderScreen(),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}

Widget automationListItem({
  required Automation automation,
  required BuildContext context,
  required int index,
  required void Function(int index) onDelete,
  required void Function(int index) onEdit,
}) {
  final isActive = automation.isActive;

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    child: Material(
      color: Colors.transparent,
      child: ShadCard(
        padding: EdgeInsets.zero,
        title: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            color: isActive ? Colors.green : Colors.red,
            alignment: Alignment.center,
            child: Text(
              isActive ? "Active" : "Unactive",
              style: ShadTheme.of(context).textTheme.list,
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                automation.toReadableString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.white),
                  onPressed: () => onEdit(index),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.white),
                  onPressed: () => onDelete(index),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
