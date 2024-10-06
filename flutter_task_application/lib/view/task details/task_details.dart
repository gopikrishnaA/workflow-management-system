import 'package:flutter/material.dart';
import 'package:flutter_task_application/view/task%20details/components/task_details_body.dart';

class TaskDetails extends StatelessWidget {
  const TaskDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: TaskDetailsBody(),
      ),
    );
  }
}
