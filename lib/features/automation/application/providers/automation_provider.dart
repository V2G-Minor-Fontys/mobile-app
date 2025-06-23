import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:v2g/features/automation/domain/automation.dart';

class AutomationListNotifier extends StateNotifier<List<Automation>> {
  AutomationListNotifier() : super([]) {
    fetch();
  }

  Future<void> fetch() async {
    try {} catch (e) {}
  }

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

  void reorder(int oldIndex, int newIndex) {
    final list = [...state];
    final item = list.removeAt(oldIndex);
    list.insert(newIndex, item);
    state = list;
  }
}

final automationListProvider =
    StateNotifierProvider<AutomationListNotifier, List<Automation>>(
        (ref) => AutomationListNotifier());
