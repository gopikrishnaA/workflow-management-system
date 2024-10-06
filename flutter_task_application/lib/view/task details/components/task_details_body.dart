import 'package:flutter/material.dart';
import 'package:flutter_task_application/view%20model/controller/task_controller.dart';
import 'package:flutter_task_application/view/create%20schedule/components/appbar.dart';
import 'package:flutter_task_application/view/signup/components/button.dart';
import 'package:flutter_task_application/view/task%20details/components/task_details_form.dart';
import 'package:get/get.dart';

class TaskDetailsBody extends StatelessWidget {
  TaskDetailsBody({super.key});
  final controller = Get.put(TaskContoller());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(
          height: 30,
        ),
        const CustomAppBar(title: 'Task Details'),
        TaskDetailsForm(),
        Obx(
          () => AccountButton(
            text: controller.taskStatus.value == 'OPEN'
                ? 'Complete'
                : 'Completed',
            loading: controller.loading.value,
            isDisabled: controller.taskStatus.value == 'COMPLETE' ||
                (controller.taskStatus.value == 'OPEN' &&
                    !controller.isCompleted.value),
            onTap: () {
              controller.updateTaskStatus();
            },
          ),
        ),
      ]),
    ));
  }
}
