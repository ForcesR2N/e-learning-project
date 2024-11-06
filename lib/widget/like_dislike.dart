import 'package:e_learning/component/my_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_learning/database/task_controller.dart';
import 'package:e_learning/model/task_model.dart';
import 'package:e_learning/model/data.json.dart';

class LikeDislikeWidget extends StatefulWidget {
  final Data data;

  const LikeDislikeWidget({super.key, required this.data});

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
    checkIfSaved();
  }

  void checkIfSaved() async {
    TaskModel? savedTask =
        await taskController.getTaskByTitle(widget.data.title);

    setState(
      () {
        if (savedTask != null) {
          isSaved = savedTask.isCompleted;
          savedTaskId = savedTask.id;
        } else {
          isSaved = false;
          savedTaskId = null;
        }
      },
    );
  }

  void toggleSaved() async {
    if (isSaved == true && savedTaskId != null) {
      await taskController.updateTaskStatus(savedTaskId!, 0);
      await taskController.deleteTask(savedTaskId!);
      CustomSnackbar.showSnackbar(
        title: 'Removed',
        message: 'Task "${widget.data.title}" removed from saved',
        backgroundColor: Colors.redAccent,
        icon: Icons.delete,
      );
      setState(() {
        isSaved = false;
      });
    } else if (isSaved == false) {
      TaskModel task = TaskModel(
        title: widget.data.title,
        description: widget.data.description,
        image: widget.data.image,
        isCompleted: true,
      );
      savedTaskId = await taskController.addTask(task);
      print('DEBUG: Task "${task.title}" added with ID: $savedTaskId');
      CustomSnackbar.showSnackbar(
        title: 'Saved',
        message: 'Task "${widget.data.title}" saved successfully',
        backgroundColor: Colors.green,
        icon: Icons.check,
      );

      setState(() {
        isSaved = true;
      });
    }
  }

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
              ? Icon(Icons.bookmark_border)
              : isSaved == true
                  ? Icon(Icons.bookmark)
                  : Icon(Icons.bookmark_border),
          color: isSaved == true ? Colors.blue : Colors.grey,
        ),
      ],
    );
  }
}
