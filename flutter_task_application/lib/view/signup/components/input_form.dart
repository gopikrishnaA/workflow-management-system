import 'package:flutter/material.dart';
import 'package:flutter_task_application/view/signup/components/select_field.dart';
import 'package:get/get.dart';
import '../../../view model/controller/signup_controller.dart';
import 'text_field.dart';

class InputForm extends StatelessWidget {
  const InputForm({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
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
        Obx(
          () => InputField(
            onTap: () => controller.onFocusName(),
            focus: controller.nameFocus.value,
            hint: "Enter Username",
            controller: controller.name.value,
            correct: controller.correctName.value,
            onChange: controller.validateName,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          '  Email',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 17),
        ),
        const SizedBox(
          height: 10,
        ),
        Obx(() => InputField(
              onTap: () => controller.onFocusEmail(),
              focus: controller.emailFocus.value,
              hint: "Enter Email",
              controller: controller.email.value,
              correct: controller.correctEmail.value,
              onChange: controller.validateEmail,
            )),
        const SizedBox(
          height: 20,
        ),
        const Text(
          '  Role',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 17),
        ),
        const SizedBox(
          height: 10,
        ),
        Obx(() => Dropdown(
            onChange: (val) {
              controller.setSelected(val);
            },
            hint: 'Select Role',
            value: controller.selected.value,
            items: controller.listType)),
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
