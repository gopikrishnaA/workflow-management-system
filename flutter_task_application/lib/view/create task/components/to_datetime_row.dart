import 'package:flutter/material.dart';
import 'package:flutter_task_application/view%20model/controller/task_controller.dart';
import 'package:flutter_task_application/view/create%20schedule/components/date_time_container.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ToDateTimeRow extends StatelessWidget {
  final controller = Get.put(TaskContoller());
  ToDateTimeRow({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'To Date',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(() => DateTimeContainer(
                  text: controller.toDate.value.isEmpty
                      ? 'dd/mm/yyyy'
                      : controller.toDate.value,
                  icon: const Icon(
                    FontAwesomeIcons.calendar,
                    color: Colors.white24,
                    size: 20,
                  ),
                  onTap: () {
                    controller.pickToDate(context);
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
                  text: controller.toDate.value.isEmpty
                      ? 'hh/mm'
                      : controller.toTime.value,
                  icon: const Icon(
                    Icons.watch,
                    color: Colors.white24,
                    size: 20,
                  ),
                  onTap: () {
                    controller.picToTime(context);
                  },
                ))
          ],
        )
      ],
    );
  }
}
