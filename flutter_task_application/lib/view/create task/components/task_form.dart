import 'package:flutter/material.dart';
import 'package:flutter_task_application/res/app_color.dart';
import 'package:flutter_task_application/view%20model/controller/task_controller.dart';
import 'package:flutter_task_application/view/create%20task/components/from_datetime_row.dart';
import 'package:flutter_task_application/view/create%20task/components/to_datetime_row.dart';
import 'package:flutter_task_application/view/signup/components/text_field.dart';
import 'package:get/get.dart';
import 'package:multiselect/multiselect.dart';

class TaskForm extends StatelessWidget {
  TaskForm({super.key});
  final controller = Get.put(TaskContoller());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 40,
        ),
        const Text(
          '  Title',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 17),
        ),
        const SizedBox(
          height: 10,
        ),
        Obx(
          () => InputField(
            onTap: () => controller.onFocusTitle(),
            focus: controller.titleFocus.value,
            hint: "Enter Title",
            controller: controller.title.value,
            correct: controller.correctTitle.value,
            onChange: controller.validateTitle,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          '  Message',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 17),
        ),
        const SizedBox(
          height: 10,
        ),
        Obx(() => InputField(
              maxLines: 4,
              onTap: () => controller.onFocusMessage(),
              focus: controller.messageFocus.value,
              hint: "Enter text",
              controller: controller.message.value,
              correct: controller.correctMessage.value,
              onChange: controller.validateMessage,
            )),
        const SizedBox(
          height: 20,
        ),
        Padding(
            padding: const EdgeInsets.all(10.0),
            child: Obx(() => DropDownMultiSelect(
                  onChanged: (List<String> x) {
                    controller.setMultiSelect(x);
                  },
                  options:
                      controller.usersList.map((item) => item.email).toList(),
                  selectedValues: controller.selected.toList(),
                  whenEmpty: 'Select Employee',
                  selectedValuesStyle: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: primaryColor,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none),
                    hoverColor: Colors.pinkAccent,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 12),
                  ),
                ))),
        const SizedBox(
          height: 20,
        ),
        FromDateTimeRow(),
        const SizedBox(
          height: 20,
        ),
        ToDateTimeRow(),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
