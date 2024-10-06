import 'package:flutter/material.dart';
import 'package:flutter_task_application/view%20model/controller/signup_controller.dart';
import 'package:flutter_task_application/view/common%20widgets/back_button.dart';
import 'package:get/get.dart';

class SignUpBar extends StatelessWidget {
  const SignUpBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Row(
      children: [
        CustomBackButton(
          onPressed: () {
            controller.clearData();
            Get.back();
          },
        ),
        const SizedBox(
          width: 20,
        ),
        const Text(
          'Sign up',
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        )
      ],
    );
  }
}
