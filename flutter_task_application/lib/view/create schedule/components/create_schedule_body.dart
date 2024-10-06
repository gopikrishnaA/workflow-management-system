import 'package:flutter/material.dart';
import 'package:flutter_task_application/view%20model/controller/schedule_controller.dart';
import 'package:flutter_task_application/view/create%20schedule/components/appbar.dart';
import 'package:flutter_task_application/view/create%20schedule/components/schedule_form.dart';
import 'package:flutter_task_application/view/signup/components/button.dart';
import 'package:get/get.dart';

class CreateScheduleBody extends StatelessWidget {
  CreateScheduleBody({super.key});
  final controller = Get.put(ScheduleController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(
          height: 30,
        ),
        CustomAppBar(
            title:
                controller.isEdit.value ? 'Edit Schedule' : 'Create Schedule'),
        ScheduleForm(),
        Obx(
          () => AccountButton(
            text: controller.isEdit.value ? 'Update' : 'Create',
            loading: controller.loading.value,
            onTap: () {
              controller.isEdit.value
                  ? controller.updateSchedule()
                  : controller.createSchedule();
            },
          ),
        ),
      ]),
    ));
  }
}
