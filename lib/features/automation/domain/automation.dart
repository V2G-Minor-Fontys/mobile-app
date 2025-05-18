

enum RuleType { weather, carBattery, gridPrice}
enum ConditionOperator { equals, notEquals, greaterThan, lessThan }
enum ActionType { startDischarging, stopCharging }

final ruleTypeLabels = {
  RuleType.weather: "Weather",
  RuleType.carBattery: "Car Battery",
  RuleType.gridPrice: "Grid Price",
};

final conditionLabels = {
  ConditionOperator.equals: "is",
  ConditionOperator.notEquals: "is not",
  ConditionOperator.greaterThan: ">",
  ConditionOperator.lessThan: "<",
};

final actionLabels = {
  ActionType.startDischarging: "Start Discharging",
  ActionType.stopCharging: "Stop Discharging",
};

class Rule {
  final RuleType type;
  final ConditionOperator operator;
  final String value;
  final String? logicalOperator; // NEW

  Rule({
    required this.type,
    required this.operator,
    required this.value,
    this.logicalOperator,
  });
}
class Automation {
  List<Rule> rules;
  ActionType action;

  Automation({
    required this.rules,
    required this.action,
  });
}

extension AutomationFormatter on Automation {
  String toReadableString() {
    if (rules.isEmpty) return 'IF - THEN ${actionLabels[action]}';

    final buffer = StringBuffer('IF ');

    for (var i = 0; i < rules.length; i++) {
      final rule = rules[i];
      final ruleStr =
          "${ruleTypeLabels[rule.type]} ${conditionLabels[rule.operator]} ${rule.value}";

      if (i == 0) {
        buffer.write(ruleStr);
      } else {
        buffer.write(" ${rule.logicalOperator ?? 'AND'} $ruleStr");
      }
    }

    buffer.write(' THEN ${actionLabels[action]}');
    return buffer.toString();
  }
}