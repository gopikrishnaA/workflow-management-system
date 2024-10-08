import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_task_application/res/app_color.dart';

class Utils {
  static bool validateEmail(String email) {
    return EmailValidator.validate(email);
  }

  static void showSnackBar(String title, String message, Widget icon) {
    Get.showSnackbar(GetSnackBar(
      backgroundColor: primaryColor.withOpacity(.4),
      title: title,
      isDismissible: true,
      duration: const Duration(milliseconds: 2000),
      icon: icon,
      message: message,
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 20,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      snackStyle: SnackStyle.GROUNDED,
      barBlur: 30,
    ));
  }

  static String formateDate(DateTime date) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    return formattedDate;
  }

  static String getDaysDiffirece(String dateString) {
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    DateTime date = dateFormat.parse(dateString);
    DateTime now = DateTime.now();
    Duration difference = now.difference(date);
    return '${-1 * difference.inDays} days';
  }

  static Future<void> showWarningDailog(
      BuildContext context, VoidCallback onConfirm) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Remove Task'),
          content: const Text('Are you sure you want to delete this Task?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Remove'),
              onPressed: () {
                onConfirm();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
