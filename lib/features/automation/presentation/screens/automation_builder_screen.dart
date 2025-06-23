import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:v2g/features/automation/application/providers/automation_provider.dart';
import 'package:v2g/features/automation/domain/automation.dart';

int? parseInt(String? val) {
  if (val == null) return null;

  try {
    int i = int.parse(val);
    if (i <= 100 && i >= 0) {
      return i;
    }
  } catch (e) {
    return null;
  }
  return null;
}

class AutomationNotifier extends StateNotifier<Automation> {
  AutomationNotifier() : super(Automation());

  void setName(String name) {
    state = state.copyWith(name: name);
  }

  void toggleOneTime(bool val) {
    state =
        state.copyWith(occurrence: state.occurrence.copyWith(isOneTime: val));
  }

  void setDate(DateTime? date) {
    if (date == null) return;

    state = state.copyWith(
        occurrence: state.occurrence.copyWith(
            datetime: state.occurrence.datetime
                .copyWith(year: date.year, month: date.month, day: date.day)));
  }

  void setTime(ShadTimeOfDay? time) {
    if (time == null) return;

    state = state.copyWith(
        occurrence: state.occurrence.copyWith(
            datetime: state.occurrence.datetime.copyWith(
                hour: time.hour, minute: time.minute, second: time.second)));
  }

  void setActionType(ActionType type) {
    state = state.copyWith(action: state.action.copyWith(type: type));
  }

  void setChargeIfPriceBelow(String val) {
    int? n = parseInt(val);

    if (n != null) {
      state =
          state.copyWith(action: state.action.copyWith(chargeIfPriceBelow: n));
    }
  }

  void setDischargeIfPriceAbove(String val) {
    int? n = parseInt(val);

    if (n != null) {
      state = state.copyWith(
          action: state.action.copyWith(dischargeIfPriceAbove: n));
    }
  }

  void toggleChargeIfPriceBelowSelected(bool val) {
    state = state.copyWith(
        action: state.action.copyWith(chargeIfPriceBelowSelected: val));
  }

  void toggleDischargeIfPriceAboveSelected(bool val) {
    state = state.copyWith(
        action: state.action.copyWith(dischargeIfPriceAboveSelected: val));
  }

  void setBatteryCharge(String? val) {
    int? n = parseInt(val);

    if (n != null) {
      state = state.copyWith(action: state.action.copyWith(batteryCharge: n));
    }
  }

  void toggleActive(bool val) {
    state = state.copyWith(isActive: val);
  }

  void setWeekDay(WeekDays day, bool val) {
    state = state.copyWith(
      occurrence: state.occurrence.copyWith(
        days: {
          ...state.occurrence.days,
          day: val,
        },
      ),
    );
  }

  void setRepetition(Repetition? repetition) {
    state = state.copyWith(
      occurrence: state.occurrence.copyWith(repetition: repetition),
    );
  }

  void setIsDayOfWeek(bool val) {
    state = state.copyWith(
      occurrence: state.occurrence.copyWith(isDayOfWeek: val),
    );
  }

  void setOccurrenceType(OccurrenceType? type) {
    state = state.copyWith(
      occurrence: state.occurrence.copyWith(type: type),
    );
  }

  void setUntil(DateTime? until) {
    state = state.copyWith(
      occurrence: state.occurrence.copyWith(until: until),
    );
  }

  void setRepeatNTimes(String? val) {
    int? n = parseInt(val);

    if (n == null) return;

    state = state.copyWith(
      occurrence: state.occurrence.copyWith(repeatNTimes: n),
    );
  }

  void setDayOfMonth(int? val) {
    if (val == null) return;

    state = state.copyWith(
      occurrence: state.occurrence.copyWith(dayOfMonth: val),
    );
  }

  void clear() {
    state = Automation();
  }
}

final automationProvider =
    StateNotifierProvider<AutomationNotifier, Automation>(
        (ref) => AutomationNotifier());

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
  final TextEditingController _batteryChargecontroller =
      TextEditingController(text: "100");
  final _formKey = GlobalKey<ShadFormState>();
  bool isSetUp = false;

  _submit(Automation automation, AutomationListNotifier listNotifier) {
    if (!_formKey.currentState!.saveAndValidate()) return;

    final isEdit = widget.indexToUpdate != null;
    if (isEdit) {
      listNotifier.update(widget.indexToUpdate!, automation);
    } else {
      listNotifier.add(automation);
    }

    Navigator.pop(context);
    notifier.clear();
  }

  void setUp() {
    if (widget.initialAutomation != null) {
      ref.read(automationProvider.notifier).state = widget.initialAutomation!;
      _batteryChargecontroller.text =
          widget.initialAutomation!.action.batteryCharge.toString();
    }

    _batteryChargecontroller.addListener(
        () => notifier.setBatteryCharge(_batteryChargecontroller.text));
  }

  @override
  void dispose() {
    _batteryChargecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isSetUp) {
      setUp();
      isSetUp = true;
    }

    final automation = ref.watch(automationProvider);
    notifier = ref.read(automationProvider.notifier);
    final listNotifier = ref.read(automationListProvider.notifier);
    const space = SizedBox(height: 20);

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.indexToUpdate != null
              ? "Edit Automation"
              : "New Automation"),
        ),
        body: ShadForm(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShadInputFormField(
                    autofocus: true,
                    placeholder: const Text("Enter name"),
                    initialValue: automation.name,
                    textInputAction: TextInputAction.done,
                    onChanged: (value) => notifier.setName(value),
                    validator: (p0) => p0.isEmpty ? "Required" : null,
                  ),
                  space,
                  ShadSwitch(
                    value: automation.occurrence.isOneTime,
                    onChanged: notifier.toggleOneTime,
                    label: Text(
                      "One Time",
                      style: ShadTheme.of(context).textTheme.list,
                    ),
                  ),
                  space,
                  if (!automation.occurrence.isOneTime)
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShadTabs<String>(
                              value: automation.occurrence.isDayOfWeek
                                  ? "day_of_week"
                                  : "day_of_month",
                              scrollable: true,
                              onChanged: (value) => notifier
                                  .setIsDayOfWeek(value == "day_of_week"),
                              tabs: [
                                ShadTab(
                                  value: "day_of_week",
                                  content: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ...WeekDays.values.map((day) {
                                        return ShadCheckboxFormField(
                                          initialValue:
                                              automation.occurrence.days[day]!,
                                          inputLabel: Text(day.label),
                                          onChanged: (val) =>
                                              notifier.setWeekDay(day, val),
                                          validator: (p0) => !automation
                                                      .occurrence.isOneTime &&
                                                  automation
                                                      .occurrence.isDayOfWeek &&
                                                  automation
                                                      .occurrence.days.values
                                                      .every((value) => !value)
                                              ? "Select at least one day"
                                              : null,
                                        );
                                      }),
                                      space,
                                      ShadSelect<Repetition>(
                                        placeholder: const Text("How often?"),
                                        initialValue:
                                            automation.occurrence.repetition,
                                        options: Repetition.values
                                            .map((repetition) => ShadOption(
                                                value: repetition,
                                                child: Text(repetition.label)))
                                            .toList(),
                                        selectedOptionBuilder:
                                            (context, value) =>
                                                Text(value.label),
                                        onChanged: notifier.setRepetition,
                                      ),
                                    ],
                                  ),
                                  child: const Text("Day of Week"),
                                ),
                                ShadTab(
                                  value: "day_of_month",
                                  content: ShadSelect<int>(
                                    initialValue:
                                        automation.occurrence.dayOfMonth,
                                    options:
                                        List.generate(31, (index) => index + 1)
                                            .map((date) => ShadOption(
                                                value: date,
                                                child: Text(date.toString())))
                                            .toList(),
                                    selectedOptionBuilder: (context, value) =>
                                        Text(value.toString()),
                                    onChanged: notifier.setDayOfMonth,
                                  ),
                                  child: const Text("Day of month"),
                                ),
                              ]),
                          space,
                          ShadRadioGroup<OccurrenceType>(
                            initialValue: automation.occurrence.type,
                            onChanged: (value) {
                              if (value == OccurrenceType.repeatNTimes) {
                                notifier.setRepeatNTimes("1");
                              } else if (value == OccurrenceType.until) {
                                notifier.setUntil(DateTime.now().add(
                                  const Duration(days: 1),
                                ));
                              }
                              notifier.setOccurrenceType(value);
                            },
                            items: [
                              const ShadRadio(
                                label: Text('Forever'),
                                value: OccurrenceType.forever,
                              ),
                              const ShadRadio(
                                label: Text('Repeat N times'),
                                value: OccurrenceType.repeatNTimes,
                              ),
                              if (automation.occurrence.type ==
                                  OccurrenceType.repeatNTimes)
                                SizedBox(
                                  width: 50,
                                  child: ShadInput(
                                    autofocus: true,
                                    initialValue: automation
                                        .occurrence.repeatNTimes
                                        .toString(),
                                    keyboardType: TextInputType.number,
                                    onChanged: notifier.setRepeatNTimes,
                                  ),
                                ),
                              const ShadRadio(
                                label: Text('Until'),
                                value: OccurrenceType.until,
                              ),
                              if (automation.occurrence.type ==
                                  OccurrenceType.until)
                                ShadCalendar(
                                  selected: automation.occurrence.until,
                                  fromMonth: DateTime.now(),
                                  toMonth: DateTime.now().add(
                                    const Duration(days: 365),
                                  ),
                                  allowDeselection: false,
                                  selectableDayPredicate: (day) =>
                                      day.isAfter(DateTime.now()) ||
                                      day.isSameDay(DateTime.now()),
                                  onChanged: notifier.setUntil,
                                ),
                            ],
                          ),
                        ]),
                  if (automation.occurrence.isOneTime)
                    ShadCalendar(
                      selected: automation.occurrence.datetime,
                      fromMonth:
                          DateTime(automation.occurrence.datetime.year - 1),
                      toMonth:
                          DateTime(automation.occurrence.datetime.year, 12),
                      allowDeselection: false,
                      selectableDayPredicate: (day) =>
                          day.isAfter(DateTime.now()) ||
                          day.isSameDay(DateTime.now()),
                      onChanged: notifier.setDate,
                    ),
                  space,
                  ShadTimePickerFormField(
                    jumpToNextFieldWhenFilled: true,
                    initialValue: ShadTimeOfDay(
                        hour: automation.occurrence.datetime.hour,
                        minute: automation.occurrence.datetime.minute,
                        second: 0),
                    onChanged: notifier.setTime,
                    trailing: const Padding(
                      padding: EdgeInsets.only(left: 8, top: 14),
                      child: Icon(LucideIcons.clock4),
                    ),
                    validator: (v) => v == null ? 'A time is required' : null,
                  ),
                  space,
                  ShadTabs<ActionType>(
                    value: automation.action.type,
                    scrollable: true,
                    tabs: [
                      ActionType.automatic,
                      ActionType.remainAt,
                      ActionType.min,
                      ActionType.max,
                    ]
                        .map((e) => ShadTab(
                              value: e,
                              content: e == ActionType.automatic
                                  ? ShadCard(
                                      child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ShadSwitch(
                                          value: automation.action
                                              .chargeIfPriceBelowSelected,
                                          onChanged: notifier
                                              .toggleChargeIfPriceBelowSelected,
                                          label: const Text(
                                              "Charge if price is below "),
                                        ),
                                        space,
                                        if (automation
                                            .action.chargeIfPriceBelowSelected)
                                          ShadInputFormField(
                                            validator: (p0) {
                                              num val = 0;

                                              try {
                                                val = num.parse(p0);
                                              } catch (e) {
                                                return "Invalid number";
                                              }

                                              return val < 0
                                                  ? "Can't be negative"
                                                  : null;
                                            },
                                            trailing:
                                                const Icon(LucideIcons.euro),
                                            initialValue: automation
                                                .action.chargeIfPriceBelow
                                                .toString(),
                                            onChanged:
                                                notifier.setChargeIfPriceBelow,
                                            keyboardType: TextInputType.number,
                                          ),
                                        if (automation
                                            .action.chargeIfPriceBelowSelected)
                                          space,
                                        ShadSwitch(
                                          value: automation.action
                                              .dischargeIfPriceAboveSelected,
                                          onChanged: notifier
                                              .toggleDischargeIfPriceAboveSelected,
                                          label: const Text(
                                              "Discharge if price is above "),
                                        ),
                                        if (automation.action
                                            .dischargeIfPriceAboveSelected)
                                          space,
                                        if (automation.action
                                            .dischargeIfPriceAboveSelected)
                                          ShadInputFormField(
                                            validator: (p0) {
                                              num val = 0;

                                              try {
                                                val = num.parse(p0);
                                              } catch (e) {
                                                return "Invalid number";
                                              }

                                              return val < 0
                                                  ? "Can't be negative"
                                                  : null;
                                            },
                                            trailing:
                                                const Icon(LucideIcons.euro),
                                            initialValue: automation
                                                .action.dischargeIfPriceAbove
                                                .toString(),
                                            onChanged: notifier
                                                .setDischargeIfPriceAbove,
                                            keyboardType: TextInputType.number,
                                          ),
                                      ],
                                    ))
                                  : ShadInputFormField(
                                      validator: (p0) {
                                        int val = 0;

                                        try {
                                          val = int.parse(p0);
                                        } catch (e) {
                                          return "Invalid number";
                                        }

                                        return val < 0
                                            ? "Can't be negative"
                                            : val > 100
                                                ? "Can't be greater than 100"
                                                : null;
                                      },
                                      leading: const Text("Battery charge "),
                                      trailing: const Icon(LucideIcons.percent),
                                      controller: _batteryChargecontroller,
                                      keyboardType: TextInputType.number,
                                    ),
                              child: Text(e.label),
                            ))
                        .toList(),
                    onChanged: notifier.setActionType,
                  ),
                  space,
                  ShadCheckbox(
                    label: const Text("Activate automation"),
                    value: automation.isActive,
                    onChanged: notifier.toggleActive,
                  ),
                  space,
                  ShadButton(
                    onPressed: () => _submit(automation, listNotifier),
                    child: const Text("✓ Save"),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
