import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_learning/database/task_controller.dart';
import 'package:e_learning/model/task_model.dart';
import 'package:e_learning/model/data.json.dart';

class LikeDislikeWidget extends StatefulWidget {
  final Data data;

  LikeDislikeWidget({required this.data});

  @override
  _LikeDislikeWidgetState createState() => _LikeDislikeWidgetState();
}

class _LikeDislikeWidgetState extends State<LikeDislikeWidget> {
  final TaskController taskController = Get.put(TaskController());
  bool isLiked = false;
  bool isDisliked = false;
  bool? isSaved;
  int? savedTaskId;

  @override
  void initState() {
    super.initState();
    checkIfSaved(); // Check if the task is saved on widget init
  }

  // Check if the task is already saved in the database
  void checkIfSaved() async {
    print('DEBUG: Checking if task "${widget.data.title}" is saved...');

    try {
      TaskModel? savedTask =
          await taskController.getTaskByTitle(widget.data.title);

      setState(() {
        if (savedTask != null) {
          print(
              'DEBUG: Task found: ${savedTask.title}, isCompleted (Saved Status): ${savedTask.isCompleted}');
          isSaved = savedTask.isCompleted; // Update UI sesuai database
          savedTaskId = savedTask.id;
        } else {
          print('DEBUG: Task not found in database. Setting isSaved to false.');
          isSaved = false;
          savedTaskId = null;
        }
      });
    } catch (e) {
      print('ERROR: Error checking saved state: $e');
      setState(() {
        isSaved = false;
        savedTaskId = null;
      });
    }
  }

  // Toggle the saved/unsaved state
  void toggleSaved() async {
    if (isSaved == true && savedTaskId != null) {
      // Hapus status saved
      await taskController.updateTaskStatus(savedTaskId!, 0);
      Get.snackbar('Removed', 'Task "${widget.data.title}" removed from saved',
          duration: Duration(seconds: 1), snackPosition: SnackPosition.BOTTOM);
      setState(() {
        isSaved = false;
      });
    } else if (isSaved == false) {
      // Simpan status saved
      TaskModel task = TaskModel(
        title: widget.data.title,
        description: widget.data.description,
        image: widget.data.image,
        isCompleted: true, // Mark as saved
      );
      savedTaskId = await taskController.addTask(task);
      Get.snackbar('Saved', 'Task "${widget.data.title}" added to saved',
          duration: Duration(seconds: 1), snackPosition: SnackPosition.BOTTOM);
      setState(() {
        isSaved = true;
      });
    }
  }

  // Toggle like/dislike status
  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
      if (isLiked) {
        isDisliked = false;
      }
    });
  }

  void toggleDislike() {
    setState(() {
      isDisliked = !isDisliked;
      if (isDisliked) {
        isLiked = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          iconSize: 30,
          onPressed: toggleLike,
          icon: Icon(
            CupertinoIcons.hand_thumbsup_fill,
            color: isLiked ? Colors.blue : Colors.grey,
          ),
        ),
        IconButton(
          iconSize: 30,
          onPressed: toggleDislike,
          icon: Icon(Icons.thumb_down,
              color: isDisliked ? Colors.red : Colors.grey),
        ),
        Spacer(),
        IconButton(
          iconSize: 35,
          onPressed: toggleSaved,
          icon: isSaved == null
              ? Icon(Icons
                  .hourglass_empty) // Loading state while checking saved status
              : isSaved == true
                  ? Icon(Icons.bookmark) // Saved icon
                  : Icon(Icons.bookmark_border), // Unsaved icon
          color: isSaved == true ? Colors.blue : Colors.grey,
        ),
      ],
    );
  }
}
