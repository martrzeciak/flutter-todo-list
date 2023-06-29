class Task {
  int? id;
  String? title;
  String? description;
  String? date;
  String? startTime;
  String? endTime;
  int? priority;
  int? isCompleted;


  Task({
    this.id,
    this.title,
    this.description,
    this.date,
    this.startTime,
    this.endTime,
    this.priority,
    this.isCompleted
  });

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    priority = json['priority'];
    isCompleted = json['isCompleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['date'] = date;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['priority'] = priority;
    data['isCompleted'] = isCompleted;

    return data;
  }
}