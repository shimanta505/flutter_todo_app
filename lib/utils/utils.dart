import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Utils {
  static void getSnackBar(String title, String message) {
    Get.isDarkMode
        ? Get.snackbar(title, message, backgroundColor: Colors.teal)
        : Get.snackbar(title, message, backgroundColor: Colors.blue);
  }
}
