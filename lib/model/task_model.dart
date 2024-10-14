class TaskModel {
  int? id;
  String title;
  String description;
  bool isCompleted;
  String? image;

  TaskModel({
    this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.image,
  });

  // Convert a Task object into a Map object
  Map<String, dynamic> toMap() {
    print('DEBUG: Converting TaskModel to Map: $title, isCompleted: $isCompleted');
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted ? 1 : 0,  // Pastikan nilai yang benar dikirim
      'image': image,
    };
  }

  // Convert a Map object into a Task object
  factory TaskModel.fromMap(Map<String, dynamic> map) {
    print('DEBUG: Converting Map to TaskModel: ${map['title']}, isCompleted: ${map['isCompleted']}');
    return TaskModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      isCompleted: map['isCompleted'] == 1,  // Convert integer from SQLite to bool
      image: map['image'],
    );
  }
}
