import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_learning/database/task_controller.dart';

class SavedPage extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Saved Tasks"),
      ),
      body: Obx(() {
        var savedTasks = taskController.getSavedTasks();  // Mengambil task yang tersimpan
        
        if (savedTasks.isEmpty) {
          return Center(child: Text("No saved tasks."));
        }
        
        return ListView.builder(
          itemCount: savedTasks.length,
          itemBuilder: (context, index) {
            final task = savedTasks[index];

            return ListTile(
              leading: task.image != null
                  ? Image.asset(task.image!, fit: BoxFit.cover)
                  : Image.asset('assets/image/landing_page.png'),
              title: Text(task.title),
              subtitle: Text(
                task.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  taskController.deleteTask(task.id!);  // Menghapus task
                  Get.snackbar('Deleted', 'Task "${task.title}" deleted.');
                },
              ),
            );
          },
        );
      }),
    );
  }
}
