import 'package:flutter/material.dart';
import 'package:flutter_task_application/model/schedules_list.dart';
import 'package:flutter_task_application/model/tasks_list.dart';
import 'package:flutter_task_application/network/schedule_services.dart';
import 'package:flutter_task_application/network/task_services.dart';
import 'package:flutter_task_application/res/routes/routes.dart';
import 'package:flutter_task_application/store/shared_pref.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  RxMap userData = {}.obs;
  RxString name = ''.obs;
  RxString role = ''.obs;
  RxBool loading = false.obs;

  var scheduleList = <Schedules>[].obs;
  var taskList = <Task>[].obs;

  // final DbHelper db = DbHelper();
  RxList list = [].obs;
  HomeController() {
    // if name not loaded
    if (userData['NAME'] == null) {
      getUserData();
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() async {
    userData.value = await UserPref.getUser();
    if (userData['ROLE'] == 'ROLE_EMPLOYEE') {
      loadEmpSchedules();
    } else {
      loadSchedules();
    }
  }

  void loadSchedules() async {
    loading.value = true;
    List<Schedules>? items = await ScheduleServices
        .getSchedulesByManager(); // Await the future to get the List
    items?.sort((a, b) => a.startTime.compareTo(b.startTime));
    setScheduleList(items!);
    loading.value = false;
  }

  void loadTasks() async {
    loading.value = true;
    List<Task>? items = await TaskServices
        .getTasksByManager(); // Await the future to get the List
    items?.sort((a, b) => a.startTime.compareTo(b.startTime));
    setTaskList(items!);
    loading.value = false;
  }

  void loadEmpTasks() async {
    loading.value = true;
    List<Task>? items = await TaskServices
        .getTasksByEmployee(); // Await the future to get the List
    items?.sort((a, b) => a.startTime.compareTo(b.startTime));
    setTaskList(items!);
    loading.value = false;
  }

  void loadEmpSchedules() async {
    loading.value = true;
    List<Schedules>? items = await ScheduleServices
        .getSchedulesByEmployee(); // Await the future to get the List
    items?.sort((a, b) => a.startTime.compareTo(b.startTime));
    setScheduleList(items!);
    loading.value = false;
  }

  void setScheduleList(List<Schedules> values) {
    scheduleList.value = values;
  }

  void setTaskList(List<Task> values) {
    taskList.value = values;
  }

  void setLoading(bool value) {
    loading.value = value;
  }

  getUserData() async {
    userData.value = await UserPref.getUser();
    getName();
    getRole();
  }

  getName() {
    name.value = userData['NAME'] ?? '';
  }

  getRole() {
    var roleData = userData['ROLE'] ?? '';
    role.value = roleData.toString().split('_')[1];
  }

  void logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isClear = await prefs.clear();
    if (isClear) {
      Get.offAllNamed(Routes.signInScreen);
    }
  }
}
