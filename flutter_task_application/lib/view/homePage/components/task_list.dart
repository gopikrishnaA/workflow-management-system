import 'package:flutter/material.dart';
import 'package:flutter_task_application/model/tasks_list.dart';
import 'package:flutter_task_application/network/task_services.dart';
import 'package:flutter_task_application/res/routes/routes.dart';
import 'package:flutter_task_application/store/shared_pref.dart';
import 'package:flutter_task_application/view%20model/controller/home_controller.dart';
import 'package:flutter_task_application/view%20model/controller/task_controller.dart';
import 'package:get/get.dart';

class TaskList extends StatelessWidget {
  TaskList({super.key});
  final controller = Get.put(HomeController());
  final taskController = Get.put(TaskContoller());

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index, Task item) async {
    var user = await UserPref.getUser();
    if (user['ROLE'] == 'ROLE_MANAGER') {
      var task = await TaskServices.getOneTaskByManager(item.id);
      taskController.setSelectedItem(task);
      Get.toNamed(Routes.createTasKScreen);
    } else {
      var task = await TaskServices.getTaskByEmployee(item.id);
      taskController.setSelectedItem(task);
      Get.toNamed(Routes.taskDetailsScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Observe the controller's variables
      if (controller.loading.value) {
        return const Center(child: CircularProgressIndicator());
      } else {
        return Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align text to the start
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Tasks', // Text to display above the ListView
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: controller.taskList.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'No Tasks created yet',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ))
                  : ListView.builder(
                      key: UniqueKey(),
                      shrinkWrap: true,
                      itemCount: controller.taskList.length,
                      itemBuilder: (context, index) {
                        var item = controller.taskList[index];
                        return Container(
                          key: UniqueKey(),
                          decoration: BoxDecoration(
                            color: Colors
                                .pink[300], // Set background color for the tile
                            borderRadius:
                                BorderRadius.circular(8), // Rounded corners
                          ),
                          margin: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8), // Margin for spacing
                          child: ListTile(
                            key: UniqueKey(),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            leading: const Icon(Icons.task,
                                color: Colors.white), // Add an icon to the left
                            title: Text(
                              item.name, // Title from your data
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.description, // Description from your data
                                  style: TextStyle(color: Colors.brown[50]),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4), // Add some spacing
                                Row(
                                  children: [
                                    const Icon(Icons.arrow_right_alt,
                                        size: 16, color: Colors.white),
                                    const SizedBox(width: 4),
                                    Text(
                                      "From: ${item.startTime.split(' ')[0]}",
                                      style: TextStyle(color: Colors.brown[50]),
                                    ),
                                    const SizedBox(width: 16),
                                    Text(
                                      "To: ${item.deadline.split(' ')[0]}",
                                      style: TextStyle(color: Colors.brown[50]),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            trailing: const Icon(
                              Icons.more_vert,
                              color: Colors.white,
                            ), // Optional trailing icon
                            onTap: () {
                              _onItemTapped(index, item);
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        );
      }
    });
  }
}
