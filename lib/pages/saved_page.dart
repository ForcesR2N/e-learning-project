import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_learning/model/task_model.dart';
import 'package:e_learning/database/task_controller.dart';

class SavedPage extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Saved Tasks"),
      ),
      body: Obx(
        () {
          if (taskController.tasks.isEmpty) {
            return Center(
              child: Text("No saved tasks."),
            );
          }
          return ListView.builder(
            itemCount: taskController.tasks.length,
            itemBuilder: (context, index) {
              final task = taskController.tasks[index];
              return ListTile(
                title: Text(task.title),
                subtitle: Text(task.description),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    taskController.deleteTask(task.id!); 
                    Get.snackbar('Deleted', 'Task "${task.title}" deleted.');
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
