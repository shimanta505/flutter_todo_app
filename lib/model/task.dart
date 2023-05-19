class Task {
  int? id;
  String? title;
  String? note;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? color;
  int? remind;
  String? repeat;

  Task({
    this.id,
    this.title,
    this.note,
    this.isCompleted,
    this.date,
    this.startTime,
    this.endTime,
    this.color,
    this.remind,
    this.repeat,
  });

  Task.fromJson(Map<String, dynamic> json) {
    id = json[Key.id];
    title = json[Key.title];
    note = json[Key.note];
    isCompleted = json[Key.isCompleted];
    date = json[Key.date];
    startTime = json[Key.startTime];
    endTime = json[Key.endTime];
    color = json[Key.color];
    remind = json[Key.remind];
    repeat = json[Key.repeat];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[Key.id] = id;
    data[Key.title] = title;
    data[Key.note] = note;
    data[Key.isCompleted] = isCompleted;
    data[Key.date] = date;
    data[Key.startTime] = startTime;
    data[Key.endTime] = endTime;
    data[Key.color] = color;
    data[Key.remind] = remind;
    data[Key.repeat] = repeat;

    return data;
  }
}

class Key {
  static const String id = "id";
  static const String title = "title";
  static const String note = "note";
  static const String isCompleted = "isCompleted";
  static const String date = "date";
  static const String startTime = "startTime";
  static const String endTime = "endTime";
  static const String color = "color";
  static const String remind = "remind";
  static const String repeat = "repeat";
}
