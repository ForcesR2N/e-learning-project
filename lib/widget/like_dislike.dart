import 'package:e_learning/database/task_controller.dart';
import 'package:e_learning/model/data.json.dart';
import 'package:e_learning/model/task_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

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
  bool isSaved = false;

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

  void toggleSaved() {
    setState(
      () {
        isSaved = !isSaved;

        if (isSaved) {
          TaskModel task = TaskModel(
              title: widget.data.title, description: widget.data.description);
          taskController.addTask(task);
          Get.snackbar('Saved', 'Task "${widget.data.title}" added to saved');
        }
      },
    );
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
          icon: Icon(
            isSaved ? Icons.bookmark : Icons.bookmark_border,
            color: isSaved ? Colors.blue : Colors.grey,
          ),
        )
      ],
    );
  }
}
