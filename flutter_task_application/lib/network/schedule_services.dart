import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_task_application/model/schedules_list.dart';
import 'package:flutter_task_application/network/endpoints.dart';
import 'package:flutter_task_application/res/routes/routes.dart';
import 'package:flutter_task_application/store/shared_pref.dart';
import 'package:flutter_task_application/utils/utils.dart';
import 'package:flutter_task_application/view%20model/controller/home_controller.dart';
import 'package:flutter_task_application/view%20model/controller/schedule_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ScheduleServices {
  static final scheduleController = Get.put(ScheduleController());
  static final homeController = Get.put(HomeController());

  static Future<void> createSchedule() async {
    try {
      scheduleController.setLoading(true);
      final selectedUsers = scheduleController.selected.toList();
      final totalUsers = scheduleController.usersList.toList();
      final startTime =
          '${scheduleController.fromDate.value.toString()} ${scheduleController.fromTime.value.toString()}';
      final endTime =
          '${scheduleController.toDate.value.toString()} ${scheduleController.toTime.value.toString()}';
      List<int> users = totalUsers
          .where((user) => selectedUsers.contains(user.email))
          .map((item) => item.id)
          .toList();
      final user = await UserPref.getUser();
      final response = await http.post(
          Uri.parse('${Endpoints.createSchedule}/${user['UID']}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${user['TOKEN']}'
          },
          body: jsonEncode(<String, dynamic>{
            'name': scheduleController.title.value.text.toString(),
            'description': scheduleController.message.value.text.toString(),
            'users': users,
            'startTime': startTime,
            'endTime': endTime
          }));
      if (response.statusCode == 200) {
        Utils.showSnackBar(
            'Schedule Created',
            "Successfully schedule created",
            const Icon(
              Icons.done,
              color: Colors.white,
            ));
        homeController.loadSchedules();
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

      scheduleController.setLoading(false);
    } catch (e) {
      Utils.showSnackBar(
          'Error',
          e.toString(),
          const Icon(
            FontAwesomeIcons.triangleExclamation,
            color: Colors.red,
          ));
      scheduleController.setLoading(false);
    }
  }

  static Future<void> updateSchedule() async {
    try {
      scheduleController.setLoading(true);
      final selectedUsers = scheduleController.selected.toList();
      final totalUsers = scheduleController.usersList.toList();
      final startTime =
          '${scheduleController.fromDate.value.toString()} ${scheduleController.fromTime.value.toString()}';
      final endTime =
          '${scheduleController.toDate.value.toString()} ${scheduleController.toTime.value.toString()}';
      List<int> users = totalUsers
          .where((user) => selectedUsers.contains(user.email))
          .map((item) => item.id)
          .toList();
      final user = await UserPref.getUser();
      final response = await http.post(
          Uri.parse(
              '${Endpoints.updateSchedule}/${user['UID']}/${scheduleController.pid}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${user['TOKEN']}'
          },
          body: jsonEncode(<String, dynamic>{
            'name': scheduleController.title.value.text.toString(),
            'description': scheduleController.message.value.text.toString(),
            'users': users,
            'startTime': startTime,
            'endTime': endTime
          }));
      if (response.statusCode == 200) {
        Utils.showSnackBar(
            'Schedule Updated',
            "Successfully schedule updated",
            const Icon(
              Icons.done,
              color: Colors.white,
            ));
        homeController.loadSchedules();
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

      scheduleController.setLoading(false);
    } catch (e) {
      Utils.showSnackBar(
          'Error',
          e.toString(),
          const Icon(
            FontAwesomeIcons.triangleExclamation,
            color: Colors.red,
          ));
      scheduleController.setLoading(false);
    }
  }

  static Future<List<Schedules>?> getSchedulesByManager() async {
    try {
      final user = await UserPref.getUser();
      final response = await http.get(
          Uri.parse('${Endpoints.getAllProgramByAdmin}/${user['UID']}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${user['TOKEN']}'
          });
      if (response.statusCode == 200) {
        SchedulesList schedulesList = SchedulesList.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
        return schedulesList.programs;
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

  static Future<List<Schedules>?> getSchedulesByEmployee() async {
    try {
      final user = await UserPref.getUser();
      final response = await http.get(
          Uri.parse('${Endpoints.getAllProgramByUser}/${user['UID']}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${user['TOKEN']}'
          });
      if (response.statusCode == 200) {
        SchedulesList schedulesList = SchedulesList.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
        return schedulesList.programs;
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

  static Future<Schedules?> getOneSchedulesByManager(int pid) async {
    try {
      final user = await UserPref.getUser();
      final response = await http.get(
          Uri.parse('${Endpoints.getProgramByAdmin}/${user['UID']}/$pid'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${user['TOKEN']}'
          });
      if (response.statusCode == 200) {
        Schedules schedule = Schedules.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
        return schedule;
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
}
