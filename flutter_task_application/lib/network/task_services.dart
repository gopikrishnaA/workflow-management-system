import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_task_application/model/tasks_list.dart';
import 'package:flutter_task_application/network/endpoints.dart';
import 'package:flutter_task_application/res/routes/routes.dart';
import 'package:flutter_task_application/store/shared_pref.dart';
import 'package:flutter_task_application/utils/utils.dart';
import 'package:flutter_task_application/view%20model/controller/home_controller.dart';
import 'package:flutter_task_application/view%20model/controller/task_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TaskServices {
  static final taskController = Get.put(TaskContoller());
  static final homeController = Get.put(HomeController());

  static Future<void> createTask() async {
    try {
      taskController.setLoading(true);
      final selectedUsers = taskController.selected.toList();
      final totalUsers = taskController.usersList.toList();
      final startTime =
          '${taskController.fromDate.value.toString()} ${taskController.fromTime.value.toString()}';
      final endTime =
          '${taskController.toDate.value.toString()} ${taskController.toTime.value.toString()}';
      List<int> users = totalUsers
          .where((user) => selectedUsers.contains(user.email))
          .map((item) => item.id)
          .toList();
      final user = await UserPref.getUser();
      final response = await http.post(Uri.parse(Endpoints.createTask),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${user['TOKEN']}'
          },
          body: jsonEncode(<String, dynamic>{
            'task': {
              'name': taskController.title.value.text.toString(),
              'description': taskController.message.value.text.toString(),
              'startTime': startTime,
              'deadline': endTime,
              'createdBy': user['UID'],
              'status': 'OPEN'
            },
            'user': users,
            'managerId': user['UID']
          }));
      if (response.statusCode == 200) {
        Utils.showSnackBar(
            'Task Created',
            "Successfully Task created",
            const Icon(
              Icons.done,
              color: Colors.white,
            ));
        homeController.loadTasks();
        Get.toNamed(Routes.homePage);
      } else {
        Utils.showSnackBar(
            'Error',
            'Something went wrong',
            const Icon(
              FontAwesomeIcons.triangleExclamation,
              color: Colors.red,
            ));
      }

      taskController.setLoading(false);
    } catch (e) {
      Utils.showSnackBar(
          'Error',
          e.toString(),
          const Icon(
            FontAwesomeIcons.triangleExclamation,
            color: Colors.red,
          ));
      taskController.setLoading(false);
    }
  }

  static Future<void> updateTask() async {
    try {
      taskController.setLoading(true);
      final selectedUsers = taskController.selected.toList();
      final totalUsers = taskController.usersList.toList();
      final startTime =
          '${taskController.fromDate.value.toString()} ${taskController.fromTime.value.toString()}';
      final endTime =
          '${taskController.toDate.value.toString()} ${taskController.toTime.value.toString()}';
      List<int> users = totalUsers
          .where((user) => selectedUsers.contains(user.email))
          .map((item) => item.id)
          .toList();
      final user = await UserPref.getUser();
      final response = await http.post(Uri.parse(Endpoints.updateTask),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${user['TOKEN']}'
          },
          body: jsonEncode(<String, dynamic>{
            'id': taskController.taskId.value,
            'name': taskController.title.value.text.toString(),
            'description': taskController.message.value.text.toString(),
            'startTime': startTime,
            'deadline': endTime,
            'users': users,
          }));
      if (response.statusCode == 200) {
        Utils.showSnackBar(
            'Task Created',
            "Successfully Task created",
            const Icon(
              Icons.done,
              color: Colors.white,
            ));
        homeController.loadTasks();
        Get.toNamed(Routes.homePage);
      } else {
        Utils.showSnackBar(
            'Error',
            'Something went wrong',
            const Icon(
              FontAwesomeIcons.triangleExclamation,
              color: Colors.red,
            ));
      }

      taskController.setLoading(false);
    } catch (e) {
      Utils.showSnackBar(
          'Error',
          e.toString(),
          const Icon(
            FontAwesomeIcons.triangleExclamation,
            color: Colors.red,
          ));
      taskController.setLoading(false);
    }
  }

  static Future<List<Task>?> getTasksByManager() async {
    try {
      final user = await UserPref.getUser();
      final response = await http.get(
          Uri.parse('${Endpoints.getAllTaskByManager}/${user['UID']}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${user['TOKEN']}'
          });
      if (response.statusCode == 200) {
        TasksList tasksList = TasksList.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
        return tasksList.taskList;
      } else {
        Utils.showSnackBar(
            'Error',
            'Something went wrong',
            const Icon(
              FontAwesomeIcons.triangleExclamation,
              color: Colors.red,
            ));
      }
    } catch (e) {
      Utils.showSnackBar(
          'Error',
          e.toString(),
          const Icon(
            FontAwesomeIcons.triangleExclamation,
            color: Colors.red,
          ));
    }
    return [];
  }

  static Future<Task?> getOneTaskByManager(int id) async {
    try {
      final user = await UserPref.getUser();
      final response = await http
          .get(Uri.parse('${Endpoints.getTask}/$id'), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${user['TOKEN']}'
      });
      if (response.statusCode == 200) {
        Task task =
            Task.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
        return task;
      } else {
        Utils.showSnackBar(
            'Error',
            'Something went wrong',
            const Icon(
              FontAwesomeIcons.triangleExclamation,
              color: Colors.red,
            ));
      }
    } catch (e) {
      Utils.showSnackBar(
          'Error',
          e.toString(),
          const Icon(
            FontAwesomeIcons.triangleExclamation,
            color: Colors.red,
          ));
    }
    return null;
  }

  static Future<Task?> getTaskByEmployee(int id) async {
    try {
      final user = await UserPref.getUser();
      final response = await http.get(
          Uri.parse('${Endpoints.getTaskByEmployee}/${user['UID']}/$id'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${user['TOKEN']}'
          });
      if (response.statusCode == 200) {
        Task task =
            Task.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
        return task;
      } else {
        Utils.showSnackBar(
            'Error',
            'Something went wrong',
            const Icon(
              FontAwesomeIcons.triangleExclamation,
              color: Colors.red,
            ));
      }
    } catch (e) {
      Utils.showSnackBar(
          'Error',
          e.toString(),
          const Icon(
            FontAwesomeIcons.triangleExclamation,
            color: Colors.red,
          ));
    }
    return null;
  }

  static Future<List<Task>?> getTasksByEmployee() async {
    try {
      final user = await UserPref.getUser();
      final response = await http.get(
          Uri.parse('${Endpoints.getAllTaskByUser}/${user['UID']}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${user['TOKEN']}'
          });
      if (response.statusCode == 200) {
        TasksList tasksList = TasksList.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
        return tasksList.taskList;
      } else {
        Utils.showSnackBar(
            'Error',
            'Something went wrong',
            const Icon(
              FontAwesomeIcons.triangleExclamation,
              color: Colors.red,
            ));
      }
    } catch (e) {
      Utils.showSnackBar(
          'Error',
          e.toString(),
          const Icon(
            FontAwesomeIcons.triangleExclamation,
            color: Colors.red,
          ));
    }
    return [];
  }

  static Future<void> updateTaskStatus() async {
    try {
      taskController.setLoading(true);
      final user = await UserPref.getUser();
      final response = await http.post(Uri.parse(Endpoints.updateTaskStatus),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${user['TOKEN']}'
          },
          body: jsonEncode(<String, dynamic>{
            'id': taskController.taskId.value,
            'uid': user['UID'],
            'status': 'COMPLETE'
          }));
      if (response.statusCode == 200) {
        Utils.showSnackBar(
            'Task Updated',
            "Successfully Task Status Updated",
            const Icon(
              Icons.done,
              color: Colors.white,
            ));
        homeController.loadEmpTasks();
        Get.toNamed(Routes.employeePage);
      } else {
        Utils.showSnackBar(
            'Error',
            'Something went wrong',
            const Icon(
              FontAwesomeIcons.triangleExclamation,
              color: Colors.red,
            ));
      }

      taskController.setLoading(false);
    } catch (e) {
      Utils.showSnackBar(
          'Error',
          e.toString(),
          const Icon(
            FontAwesomeIcons.triangleExclamation,
            color: Colors.red,
          ));
      taskController.setLoading(false);
    }
  }
}
