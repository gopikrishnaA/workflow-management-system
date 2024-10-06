import 'package:flutter/material.dart';
import 'package:flutter_task_application/view/create%20task/components/create_task_body.dart';

class CreateTask extends StatelessWidget {
  const CreateTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: CreateTaskBody(),
      ),
    );
  }
}
