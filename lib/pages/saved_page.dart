import 'package:e_learning/component/my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_learning/database/task_controller.dart';
import 'package:e_learning/component/my_color.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class SavedPage extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Saved Tasks", style: TextStyle(color: Colors.white)),
        backgroundColor: AppColor.primaryBlue,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Obx(() {
        var savedTasks = taskController.getSavedTasks();

        if (savedTasks.isEmpty) {
          return _buildEmptyState();
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12.0),
          itemCount: savedTasks.length,
          itemBuilder: (context, index) {
            final task = savedTasks[index];
            return Card(
              color: AppColor.backgroundColor,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                contentPadding: const EdgeInsets.all(12.0),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: task.image != null
                      ? Image.asset(
                          task.image!,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/image/landing_page.png',
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                ),
                title: Text(
                  task.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColor.textColor,
                  ),
                ),
                subtitle: Text(
                  task.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    taskController.deleteTask(task.id!);
                    CustomSnackbar.showSnackbar(
                      title: 'Removed',
                      message: 'Task "${task.title}" removed from saved',
                      backgroundColor: Colors.redAccent,
                      icon: Icons.delete,
                    );
                  },
                ),
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.task_alt_outlined,
            size: 80,
            color: AppColor.primaryBlue.withOpacity(0.6),
          ),
          SizedBox(height: 20),
          Text(
            "No saved tasks",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColor.textColor.withOpacity(0.7),
            ),
          ),
          SizedBox(height: 10),
          Text(
            "You haven't saved any tasks yet.",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
