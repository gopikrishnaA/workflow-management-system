import 'package:flutter/material.dart';
import 'package:flutter_task_application/view/signup/components/signup_body.dart';
import '../../res/app_color.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: black,
      body: SafeArea(
        child: SignupBody(),
      ),
    );
  }
}
