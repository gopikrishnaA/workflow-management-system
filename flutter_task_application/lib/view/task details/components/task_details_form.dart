import 'package:flutter/material.dart';
import 'package:flutter_task_application/utils/utils.dart';
import 'package:flutter_task_application/view%20model/controller/task_controller.dart';
import 'package:get/get.dart';

class TaskDetailsForm extends StatelessWidget {
  TaskDetailsForm({super.key});
  final controller = Get.put(TaskContoller());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 40,
        ),
        Obx(
          () => RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: ' Title: ', // The static part
                  style: TextStyle(
                    fontWeight: FontWeight.bold, // Making "Title:" bold
                    color: Colors.grey, // White color
                    fontSize: 15,
                  ),
                ),
                TextSpan(
                  text: controller.title.value.text
                      .toString(), // The dynamic part
                  style: const TextStyle(
                    fontWeight: FontWeight.w400, // Regular font weight
                    color: Colors.white, // White color
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Obx(
          () => RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: ' Desciption: ', // The static part
                  style: TextStyle(
                    fontWeight: FontWeight.bold, // Making "Title:" bold
                    color: Colors.grey, // White color
                    fontSize: 15,
                  ),
                ),
                TextSpan(
                  text: controller.message.value.text
                      .toString(), // The dynamic part
                  style: const TextStyle(
                    fontWeight: FontWeight.w400, // Regular font weight
                    color: Colors.white, // White color
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Obx(
          () => RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: ' Starts at: ', // The static part
                  style: TextStyle(
                    fontWeight: FontWeight.bold, // Making "Title:" bold
                    color: Colors.grey, // White color
                    fontSize: 15,
                  ),
                ),
                TextSpan(
                  text: '${controller.fromDate} ${controller.fromTime}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w400, // Regular font weight
                    color: Colors.white, // White color
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Obx(
          () => RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: ' Ends at: ', // The static part
                  style: TextStyle(
                    fontWeight: FontWeight.bold, // Making "Title:" bold
                    color: Colors.grey, // White color
                    fontSize: 15,
                  ),
                ),
                TextSpan(
                  text: '${controller.toDate} ${controller.toDate}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w400, // Regular font weight
                    color: Colors.white, // White color
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Obx(
          () => RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: ' Expires in: ', // The static part
                  style: TextStyle(
                    fontWeight: FontWeight.bold, // Making "Title:" bold
                    color: Colors.grey, // White color
                    fontSize: 15,
                  ),
                ),
                TextSpan(
                  text: Utils.getDaysDiffirece(controller.toDate.toString()),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, // Regular font weight
                      color: Colors.white, // White color
                      fontSize: 15,
                      fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Obx(
          // Use Obx to listen for changes in the controller's state
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Left Text
              Text(
                'Pending', // Text on the left
                style: TextStyle(
                  fontSize: 16,
                  color:
                      controller.isCompleted.value ? Colors.grey : Colors.pink,
                  fontWeight: !controller.isCompleted.value
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
              // The Switch widget
              Switch(
                value: controller.isCompleted.value,
                onChanged: (value) {
                  controller.taskStatus.value == 'OPEN'
                      ? controller.toggle()
                      : null;
                },
                activeColor: Colors.pink, // Switch color when ON
                inactiveThumbColor: Colors.white, // Switch color when OFF
              ),
              // Right Text
              Text(
                controller.taskStatus.value == 'OPEN'
                    ? 'Complete'
                    : 'Completed', // Text on the right
                style: TextStyle(
                  fontSize: 16,
                  color:
                      controller.isCompleted.value ? Colors.pink : Colors.grey,
                  fontWeight: controller.isCompleted.value
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
