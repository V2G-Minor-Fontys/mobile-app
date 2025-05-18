// screens/automation_list_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:v2g/features/automation/application/providers/automation_provider.dart';
import 'package:v2g/features/automation/domain/automation.dart';
import 'automation_builder_screen.dart';

class AutomationListScreen extends ConsumerWidget {
  const AutomationListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final automations = ref.watch(automationListProvider);
    final notifier = ref.read(automationListProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('My Automations')),
      body: automations.isEmpty
          ? const Center(child: Text("No automations yet. Tap + to add one!"))
          : ListView.builder(
              itemCount: automations.length,
              itemBuilder: (context, index) {
                final automation = automations[index];

                return ListTile(
                  title: GestureDetector(
                    onTap: () async {
                      await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: Text(automation.toReadableString()),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text("Close")),
                          ],
                        ),
                      );
                    },
                    child: Text(
                      automation.toReadableString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
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
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
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
                            notifier.delete(index);
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  const AutomationBuilderScreen(), // <- no initialAutomation
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
