import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackbar {
  static void showSnackbar({
    required String title,
    required String message,
    Color backgroundColor = Colors.blueAccent,
    Color textColor = Colors.white,
    IconData? icon = Icons.info,
    Duration duration = const Duration(seconds: 2),
  }) {
    Get.snackbar(
      title,
      message,
      duration: duration,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: backgroundColor,
      colorText: textColor,
      icon: icon != null ? Icon(icon, color: textColor) : null,
      borderRadius: 10,
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      boxShadows: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
      ],
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
      messageText: Text(message, maxLines: 1, overflow: TextOverflow.ellipsis,),
    );
  }
}
