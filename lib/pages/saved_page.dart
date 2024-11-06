import 'package:e_learning/component/my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_learning/database/task_controller.dart';
import 'package:e_learning/component/my_color.dart';
import 'package:e_learning/utils/responsive_layout.dart';

class SavedPage extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController());

  SavedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryBlue,
      body: Responsive(
        mobile: _buildSavedContent(context),
        tablet: _buildSavedContent(context, isTablet: true),
      ),
    );
  }

  Widget _buildSavedContent(BuildContext context, {bool isTablet = false}) {
    return SafeArea(
      child: Column(
        children: [
          _buildAppBar(context, isTablet),
          Expanded(
            child: Obx(() {
              var savedTasks = taskController.getSavedTasks();
              if (savedTasks.isEmpty) {
                return _buildEmptyState(isTablet);
              }
              return _buildTasksList(context, savedTasks, isTablet);
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, bool isTablet) {
    return Container(
      padding: EdgeInsets.all(context.spacing),
      color: AppColor.primaryBlue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Saved Tasks",
            style: TextStyle(
              color: Colors.white,
              fontSize: isTablet ? 24.0 : 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTasksList(BuildContext context, List savedTasks, bool isTablet) {
    return ListView.builder(
      padding: EdgeInsets.all(context.spacing),
      itemCount: savedTasks.length,
      itemBuilder: (context, index) {
        final task = savedTasks[index];
        return Card(
          color: AppColor.backgroundColor,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.radius),
          ),
          margin: EdgeInsets.only(bottom: context.spacing),
          child: ListTile(
            contentPadding: EdgeInsets.all(context.spacing),
            leading: ClipRRect(
              child: task.image != null
                  ? Image.asset(
                      task.image!,
                      width: isTablet ? 60 : 55,
                      height: isTablet ? 60 : 50,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/image/landing_page.png',
                      width: isTablet ? 60 : 50,
                      height: isTablet ? 60 : 50,
                      fit: BoxFit.cover,
                    ),
            ),
            title: Text(
              task.title,
              maxLines: 1,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: context.fontSize,
                color: AppColor.textColor,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            subtitle: Text(
              task.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: context.fontSize - 2,
              ),
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
                size: context.iconSize,
              ),
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
  }

  Widget _buildEmptyState(bool isTablet) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.task_alt_outlined,
            size: isTablet ? 100 : 80,
            color: AppColor.primaryBlue.withOpacity(0.6),
          ),
          SizedBox(height: isTablet ? 30 : 20),
          Text(
            "No saved tasks",
            style: TextStyle(
              fontSize: isTablet ? 22 : 18,
              fontWeight: FontWeight.bold,
              color: AppColor.textColor.withOpacity(0.7),
            ),
          ),
          SizedBox(height: isTablet ? 15 : 10),
          Text(
            "You haven't saved any tasks yet.",
            style: TextStyle(
              fontSize: isTablet ? 18 : 16,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
