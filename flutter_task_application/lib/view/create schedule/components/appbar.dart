import 'package:flutter/material.dart';
import 'package:flutter_task_application/view/common%20widgets/back_button.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomBackButton(
          onPressed: () {
            Get.back();
          },
        ),
        const SizedBox(
          width: 20,
        ),
        Text(
          title, // Now you can use the dynamic title here
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
