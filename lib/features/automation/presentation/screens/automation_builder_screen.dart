import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:v2g/features/automation/application/providers/automation_provider.dart';
import 'package:v2g/features/automation/domain/automation.dart';

const Map<RuleType, List<String>> ruleValues = {
  RuleType.weather: ['sunny', 'cloudy', 'rainy'],
  RuleType.carBattery: ['20', '40', '60', '80', '100'],
  RuleType.gridPrice: ['0.10', '0.20', '0.30'],
};

const Map<RuleType, List<ConditionOperator>> ruleOperators = {
  RuleType.weather: [
    ConditionOperator.equals,
    ConditionOperator.notEquals,
  ],
  RuleType.carBattery: [
    ConditionOperator.greaterThan,
    ConditionOperator.lessThan,
    ConditionOperator.equals,
  ],
  RuleType.gridPrice: [
    ConditionOperator.greaterThan,
    ConditionOperator.lessThan,
  ],
};

class AutomationNotifier extends StateNotifier<Automation> {
  AutomationNotifier()
      : super(
          Automation(
            rules: [
              Rule(
                type: RuleType.weather,
                operator: ConditionOperator.equals,
                value: 'cloudy',
              )
            ],
            action: ActionType.startDischarging,
          ),
        );

  void updateRule(int index, Rule rule) {
    final updatedRules = [...state.rules];
    updatedRules[index] = rule;
    state = Automation(
      rules: updatedRules,
      action: state.action,
    );
  }

  void addRule() {
    state = Automation(
      rules: [
        ...state.rules,
        Rule(
          type: RuleType.carBattery,
          operator: ConditionOperator.greaterThan,
          value: '40',
          logicalOperator: 'AND', // Default operator for the new rule
        )
      ],
      action: state.action,
    );
  }

  void updateAction(ActionType? newAction) {
    state = Automation(
      rules: state.rules,
      action: newAction ?? ActionType.startDischarging,
    );
  }

  void updateRuleLogicalOperator(int index, String? op) {
    final updatedRules = [...state.rules];
    final rule = updatedRules[index];
    updatedRules[index] = Rule(
      type: rule.type,
      operator: rule.operator,
      value: rule.value,
      logicalOperator: op ?? 'AND',
    );
    state = Automation(
      rules: updatedRules,
      action: state.action,
    );
  }

  void removeRule(int index) {
    final updatedRules = [...state.rules]..removeAt(index);
    state = Automation(
      rules: updatedRules,
      action: state.action,
    );
  }
}

final automationProvider =
    StateNotifierProvider<AutomationNotifier, Automation>((ref) {
  return AutomationNotifier();
});

// UI

class AutomationBuilderScreen extends ConsumerStatefulWidget {
  final Automation? initialAutomation;
  final int? indexToUpdate;

  const AutomationBuilderScreen({
    super.key,
    this.initialAutomation,
    this.indexToUpdate,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AutomationBuilderScreenState();
}

class _AutomationBuilderScreenState
    extends ConsumerState<AutomationBuilderScreen> {
  late AutomationNotifier notifier;

  @override
  void initState() {
    super.initState();
    if (widget.initialAutomation != null) {
      ref.read(automationProvider.notifier).state = widget.initialAutomation!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final automation = ref.watch(automationProvider);
    notifier = ref.read(automationProvider.notifier);
    final listNotifier = ref.read(automationListProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.indexToUpdate != null
            ? "Edit Automation"
            : "New Automation"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text("IF",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ...automation.rules.asMap().entries.map((entry) {
              final index = entry.key;
              final rule = entry.value;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (index != 0)
                    Row(
                      children: [
                        const Text("Logical Operator: "),
                        DropdownButton<String>(
                          value: rule.logicalOperator ?? 'AND',
                          items: ['AND', 'OR'].map((op) {
                            return DropdownMenuItem(value: op, child: Text(op));
                          }).toList(),
                          onChanged: (op) =>
                              notifier.updateRuleLogicalOperator(index, op),
                        ),
                      ],
                    ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // RULE TYPE
                      DropdownButton<RuleType>(
                        value: rule.type,
                        items: RuleType.values.map((rt) {
                          return DropdownMenuItem(
                            value: rt,
                            child: Text(ruleTypeLabels[rt] ?? ''),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            final defaultOperator = ruleOperators[val]!.first;
                            final defaultValue = ruleValues[val]!.first;
                            notifier.updateRule(
                              index,
                              Rule(
                                type: val,
                                operator: defaultOperator,
                                value: defaultValue,
                                logicalOperator: rule.logicalOperator,
                              ),
                            );
                          }
                        },
                      ),

                      const SizedBox(width: 10),

                      // OPERATOR
                      DropdownButton<ConditionOperator>(
                        value: rule.operator,
                        items: ruleOperators[rule.type]!.map((op) {
                          return DropdownMenuItem(
                            value: op,
                            child: Text(conditionLabels[op]!),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            notifier.updateRule(
                              index,
                              Rule(
                                type: rule.type,
                                operator: val,
                                value: rule.value,
                                logicalOperator: rule.logicalOperator,
                              ),
                            );
                          }
                        },
                      ),

                      const SizedBox(width: 10),

                      // VALUE
                      DropdownButton<String>(
                        value: rule.value,
                        items: ruleValues[rule.type]!.map((val) {
                          return DropdownMenuItem(
                            value: val,
                            child: Text(val),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            notifier.updateRule(
                              index,
                              Rule(
                                type: rule.type,
                                operator: rule.operator,
                                value: val,
                                logicalOperator: rule.logicalOperator,
                              ),
                            );
                          }
                        },
                      ),

                      const SizedBox(width: 10),

                      // REMOVE BUTTON
                      if (automation.rules.length > 1)
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => notifier.removeRule(index),
                          tooltip: "Remove condition",
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              );
            }),
            const SizedBox(height: 10),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: notifier.addRule,
              child: const Text("+ Add Condition"),
            ),
            const Divider(height: 30),
            const Text("THEN",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            DropdownButton<ActionType>(
              value: automation.action,
              items: ActionType.values.map((action) {
                return DropdownMenuItem(
                  value: action,
                  child: Text(actionLabels[action]!),
                );
              }).toList(),
              onChanged: notifier.updateAction,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final isEdit = widget.indexToUpdate != null;
                if (isEdit) {
                  listNotifier.update(widget.indexToUpdate!, automation);
                } else {
                  listNotifier.add(automation);
                }

                Navigator.pop(context);
              },
              child: const Text("✓ Save Automation"),
            ),
          ],
        ),
      ),
    );
  }
}
