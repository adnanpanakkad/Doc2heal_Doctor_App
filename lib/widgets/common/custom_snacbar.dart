import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackbar {
  static void show({
    required String title,
    required String description,
    required Color backgroundColor,
    required Icon icon,
    SnackPosition snackPosition = SnackPosition.TOP,
    Color colorText = Colors.white,
    double borderRadius = 8.0,
    EdgeInsets margin = const EdgeInsets.all(10),
    bool shouldIconPulse = false,
    List<BoxShadow> boxShadows = const [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 8,
        offset: Offset(0, 2),
      ),
    ],
    Duration duration = const Duration(seconds: 3),
    bool isDismissible = true,
    SnackStyle snackStyle = SnackStyle.FLOATING,
  }) {
    Get.snackbar(
      title,
      description,
      snackPosition: snackPosition,
      backgroundColor: backgroundColor.withOpacity(0.8),
      colorText: colorText,
      borderRadius: borderRadius,
      margin: margin,
      icon: icon,
      shouldIconPulse: shouldIconPulse,
      boxShadows: boxShadows,
      duration: duration,
      isDismissible: isDismissible,
      snackStyle: snackStyle,
    );
  }
}
