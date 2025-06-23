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

  const AutomationListScreen(
      {super.key, required this.homeController, required this.constraints});

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
              borderRadius: const BorderRadius.horizontal(
                right: Radius.circular(16),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green.withAlpha(100),
                  borderRadius: const BorderRadius.horizontal(
                    right: Radius.circular(16),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Colors.green.withAlpha(255),
                      Colors.green.withAlpha(50),
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
          padding: EdgeInsets.only(top: constraints.maxHeight * 0.05),
          child: Text(
            "My Automations",
            style: ShadTheme.of(context).textTheme.h3,
          ),
        ),
        Positioned(
          top: constraints.maxHeight * 0.15,
          child: ShadCard(
            width: constraints.maxWidth,
            border: const Border(),
            padding: const EdgeInsets.all(16),
            child: Material(
              child: SizedBox(
                height: constraints.maxHeight * 0.7,
                child: automations.isEmpty
                    ? const Center(
                        child: Text(
                          "No automations yet. Tap + to add one!",
                          textAlign: TextAlign.center,
                        ),
                      )
                    : ReorderableListView.builder(
                        itemCount: automations.length,
                        onReorder: notifier.reorder,
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
        ),
        Positioned(
          bottom: constraints.maxHeight * 0.11,
          right: constraints.maxWidth * 0.03,
          child: ShadButton(
            backgroundColor: Colors.green.withAlpha(255),
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

  return ListTile(
    key: Key(index.toString()),
    title: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ShadCard(
        padding: EdgeInsets.zero,
        title: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            color: isActive ? Colors.green : Colors.red,
            child: Text(
              automation.name,
              style: ShadTheme.of(context).textTheme.list,
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                automation.description,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              spacing: 0,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.grey),
                  onPressed: () => onEdit(index),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
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
