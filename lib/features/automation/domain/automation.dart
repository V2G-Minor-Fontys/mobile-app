enum ActionType { min, max, remainAt, automatic }

enum OccurrenceType { forever, until, repeatNTimes }

enum WeekDays { mon, tue, wed, thu, fri, sat, sun }

extension WeekDaysExtension on WeekDays {
  String get label {
    switch (this) {
      case WeekDays.mon:
        return "Mon";
      case WeekDays.tue:
        return "Tue";
      case WeekDays.wed:
        return "Wed";
      case WeekDays.thu:
        return "Thu";
      case WeekDays.fri:
        return "Fri";
      case WeekDays.sat:
        return "Sat";
      case WeekDays.sun:
        return "Sun";
    }
  }
}

enum Repetition { every, one, two, three, four, last }

extension RepetitionExtension on Repetition {
  String get label {
    switch (this) {
      case Repetition.every:
        return "Every";
      case Repetition.one:
        return "On the 1st";
      case Repetition.two:
        return "On the 2nd";
      case Repetition.three:
        return "On the 3rd";
      case Repetition.four:
        return "On the 4th";
      case Repetition.last:
        return "Last";
    }
  }
}

extension RuleTypeExtension on ActionType {
  String get label {
    switch (this) {
      case ActionType.min:
        return "Min";
      case ActionType.max:
        return "Max";
      case ActionType.remainAt:
        return "Remain at";
      case ActionType.automatic:
        return "Automatic";
    }
  }
}

class Automation {
  String name;
  bool isActive;
  Occurrence occurrence;
  ChargingAction action;

  Automation({
    this.name = "",
    this.isActive = true,
    ChargingAction? action,
    Occurrence? occurrence,
    DateTime? date,
  })  : action = action ?? ChargingAction(type: ActionType.automatic),
        occurrence = occurrence ?? Occurrence();

  Automation copyWith({
    String? name,
    bool? isActive,
    ChargingAction? action,
    Occurrence? occurrence,
  }) =>
      Automation(
        name: name ?? this.name,
        isActive: isActive ?? this.isActive,
        action: action ?? this.action,
        occurrence: occurrence ?? this.occurrence,
      );

  get description {
    return "$action $occurrence";
  }
}

class ChargingAction {
  ActionType type;
  int batteryCharge;
  num chargeIfPriceBelow;
  num dischargeIfPriceAbove;
  bool chargeIfPriceBelowSelected = false;
  bool dischargeIfPriceAboveSelected = false;

  ChargingAction({
    required this.type,
    this.batteryCharge = 0,
    this.chargeIfPriceBelow = 0.1,
    this.dischargeIfPriceAbove = 0,
    this.chargeIfPriceBelowSelected = true,
    this.dischargeIfPriceAboveSelected = false,
  });

  ChargingAction copyWith({
    ActionType? type,
    int? batteryCharge,
    int? chargeIfPriceBelow,
    int? dischargeIfPriceAbove,
    bool? chargeIfPriceBelowSelected,
    bool? dischargeIfPriceAboveSelected,
  }) =>
      ChargingAction(
        type: type ?? this.type,
        batteryCharge: batteryCharge ?? this.batteryCharge,
        chargeIfPriceBelow: chargeIfPriceBelow ?? this.chargeIfPriceBelow,
        dischargeIfPriceAbove:
            dischargeIfPriceAbove ?? this.dischargeIfPriceAbove,
        chargeIfPriceBelowSelected:
            chargeIfPriceBelowSelected ?? this.chargeIfPriceBelowSelected,
        dischargeIfPriceAboveSelected:
            dischargeIfPriceAboveSelected ?? this.dischargeIfPriceAboveSelected,
      );

  @override
  String toString() {
    String desc = "";
    if (type == ActionType.automatic) {
      desc = "Automatic charging";
      bool hasSettings =
          chargeIfPriceBelowSelected || dischargeIfPriceAboveSelected;

      if (hasSettings) {
        desc += ":";
      }

      if (chargeIfPriceBelowSelected) {
        desc += "\n - charge if price is below $chargeIfPriceBelow€";
      }
      if (dischargeIfPriceAboveSelected) {
        desc += "\n - discharge if price is above $dischargeIfPriceAbove€";
      }

      if (hasSettings) {
        desc += "\n";
      }
    } else {
      desc = "Keep charge ";
      switch (type) {
        case ActionType.min:
          desc += "at least";
          break;
        case ActionType.max:
          desc += "at most";
          break;
        case ActionType.remainAt:
          desc += "at";
          break;
        default:
          throw Exception("Unknown type");
      }
      desc += " $batteryCharge%";
    }

    return desc;
  }
}

class Occurrence {
  bool isOneTime;
  Map<WeekDays, bool> days;
  int? repeatNTimes;
  Repetition repetition;
  DateTime? until;
  DateTime datetime;
  bool isDayOfWeek;
  int? dayOfMonth;
  OccurrenceType type;

  Occurrence({
    this.isOneTime = false,
    this.isDayOfWeek = false,
    this.until,
    this.repeatNTimes,
    this.repetition = Repetition.every,
    this.type = OccurrenceType.forever,
    this.dayOfMonth = 1,
    DateTime? dt,
    Map<WeekDays, bool>? days,
  })  : days = days ??
            <WeekDays, bool>{
              WeekDays.mon: false,
              WeekDays.tue: false,
              WeekDays.wed: false,
              WeekDays.thu: false,
              WeekDays.fri: false,
              WeekDays.sat: false,
              WeekDays.sun: false,
            },
        datetime = dt ?? DateTime.now();

  Occurrence copyWith({
    bool? isOneTime,
    Map<WeekDays, bool>? days,
    int? repeatNTimes,
    Repetition? repetition,
    DateTime? until,
    OccurrenceType? type,
    bool? isDayOfWeek,
    DateTime? datetime,
    int? dayOfMonth,
  }) =>
      Occurrence(
        isOneTime: isOneTime ?? this.isOneTime,
        days: days ?? this.days,
        repeatNTimes: repeatNTimes ?? this.repeatNTimes,
        type: type ?? this.type,
        repetition: repetition ?? this.repetition,
        isDayOfWeek: isDayOfWeek ?? this.isDayOfWeek,
        until: until ?? this.until,
        dt: datetime ?? this.datetime,
        dayOfMonth: dayOfMonth ?? this.dayOfMonth,
      );

  @override
  String toString() {
    String desc = "on ";
    String dateLabel = datetime.toString().split(" ")[0];
    String timeLabel =
        "${datetime.hour.toString().padLeft(2, "0")}:${datetime.minute.toString().padLeft(2, "0")}";

    if (isOneTime) {
      desc += dateLabel;
    } else if (isDayOfWeek) {
      if (repetition != Repetition.every) {
        desc += "${repetition.label.toLowerCase()} ";
      }
      desc += days.entries
          .where((entry) => entry.value)
          .map((entry) => entry.key.label)
          .join(", ");
    } else {
      desc +=
          "the $dayOfMonth${dayOfMonth == 1 ? "st" : dayOfMonth == 2 ? "nd" : dayOfMonth == 3 ? "rd" : "th"} day of the month";
    }

    desc += " at $timeLabel";

    if (type == OccurrenceType.until) {
      desc += " until ${until.toString().split(" ")[0]}";
    } else if (type == OccurrenceType.repeatNTimes) {
      desc += " for the next $repeatNTimes times";
    }

    return desc;
  }
}
