// providers/automation_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:v2g/features/automation/domain/automation.dart';

class AutomationListNotifier extends StateNotifier<List<Automation>> {
  AutomationListNotifier() : super([]);

  void add(Automation automation) {
    state = [...state, automation];
  }

  void update(int index, Automation updated) {
    final list = [...state];
    list[index] = updated;
    state = list;
  }

  void delete(int index) {
    state = [...state]..removeAt(index);
  }
}

final automationListProvider =
    StateNotifierProvider<AutomationListNotifier, List<Automation>>(
        (ref) => AutomationListNotifier());