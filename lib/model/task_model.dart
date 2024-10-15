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

  Map<String, dynamic> toMap() {
    print(
        'DEBUG: Converting TaskModel to Map: $title, isCompleted: $isCompleted');
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted ? 1 : 0,
      'image': image,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      isCompleted:
          map['isCompleted'] == 1,
      image: map['image'],
    );
  }
}
