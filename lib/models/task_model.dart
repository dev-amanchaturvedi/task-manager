class TaskModel {
  int? id;
  String title;
  String description;
  String priority;
  String date;
  int completed;

  TaskModel({
    this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.date,
    required this.completed,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'priority': priority,
      'date': date,
      'completed': completed,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      priority: map['priority'],
      date: map['date'],
      completed: map['completed'],
    );
  }
}
