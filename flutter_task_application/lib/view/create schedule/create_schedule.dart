import 'package:flutter/material.dart';
import 'package:flutter_task_application/view/create%20schedule/components/create_schedule_body.dart';

class CreateSchedule extends StatelessWidget {
  const CreateSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: CreateScheduleBody(),
      ),
    );
  }
}
