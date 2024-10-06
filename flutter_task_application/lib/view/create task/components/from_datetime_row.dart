import 'package:flutter/material.dart';
import 'package:flutter_task_application/view%20model/controller/task_controller.dart';
import 'package:flutter_task_application/view/create%20schedule/components/date_time_container.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class FromDateTimeRow extends StatelessWidget {
  final controller = Get.put(TaskContoller());
  FromDateTimeRow({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'From Date',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(() => DateTimeContainer(
                  text: controller.fromDate.value.isEmpty
                      ? 'dd/mm/yyyy'
                      : controller.fromDate.value,
                  icon: const Icon(
                    FontAwesomeIcons.calendar,
                    color: Colors.white24,
                    size: 20,
                  ),
                  onTap: () {
                    controller.pickFromDate(context);
                  },
                ))
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: const TextSpan(children: [
              TextSpan(
                text: 'Time',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
              TextSpan(
                text: '   (optional)',
                style: TextStyle(color: Colors.white30, fontSize: 13),
              )
            ])),
            const SizedBox(
              height: 10,
            ),
            Obx(() => DateTimeContainer(
                  text: controller.fromTime.value.isEmpty
                      ? 'hh/mm'
                      : controller.fromTime.value,
                  icon: const Icon(
                    Icons.watch,
                    color: Colors.white24,
                    size: 20,
                  ),
                  onTap: () {
                    controller.picFromTime(context);
                  },
                ))
          ],
        )
      ],
    );
  }
}
