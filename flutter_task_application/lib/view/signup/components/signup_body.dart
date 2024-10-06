import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task_application/res/routes/routes.dart';
import 'package:flutter_task_application/view%20model/controller/signup_controller.dart';

import 'appbar.dart';
import 'button.dart';
import 'input_form.dart';

class SignupBody extends StatelessWidget {
  const SignupBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            const SignUpBar(),
            const SizedBox(
              height: 50,
            ),
            const InputForm(),
            Obx(
              () => AccountButton(
                text: "Create Account",
                loading: controller.loading.value,
                onTap: () {
                  controller.createAccount();
                },
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () => Get.toNamed(Routes.signInScreen),
                  child: RichText(
                      text: const TextSpan(children: [
                    TextSpan(
                        text: 'Already have an account? ',
                        style: TextStyle(
                          color: Colors.grey,
                        )),
                    TextSpan(
                        text: 'Login',
                        style: TextStyle(
                          color: Colors.white,
                        ))
                  ])),
                ))
          ],
        ),
      ),
    );
  }
}
