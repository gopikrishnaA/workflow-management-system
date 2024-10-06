import 'package:flutter/material.dart';
import 'package:flutter_task_application/view%20model/controller/signin_controller.dart';
import 'package:flutter_task_application/view/signup/components/text_field.dart';
import 'package:get/get.dart';

class SignInForm extends StatelessWidget {
  SignInForm({super.key});
  final controller = Get.put(SignInController());
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 40,
        ),
        const Text(
          '  Username',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 17),
        ),
        const SizedBox(
          height: 10,
        ),
        Obx(() => InputField(
              onTap: () => controller.onFocusUsername(),
              focus: controller.usernameFocus.value,
              hint: "Enter Username",
              controller: controller.username.value,
              correct: controller.correctUsername.value,
              onChange: controller.validateUsername,
            )),
        const SizedBox(
          height: 20,
        ),
        const Text(
          '  Password',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 17),
        ),
        const SizedBox(
          height: 10,
        ),
        Obx(
          () => InputField(
            onTap: () => controller.onFocusPassword(),
            focus: controller.passwordFocus.value,
            hint: "Enter Password",
            controller: controller.password.value,
            hideText: controller.showPassword.value,
            onChange: () {},
            showPass: () => controller.showPassword.toggle(),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
