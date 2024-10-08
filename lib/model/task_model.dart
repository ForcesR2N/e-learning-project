class TaskModel {
  // task model itu struktur data column2 nya
  int? id;
  String title;
  String description;
  bool isCompleted;

  TaskModel({
    this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
  });

  // Convert a Task object into a Map object
  // untuk inserting data ke database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }

  // Convert a Map object into a Task object
  // dari database ke UI dalam bentuk object
  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      isCompleted: map['isCompleted'] == 1,
    );
  }
}
