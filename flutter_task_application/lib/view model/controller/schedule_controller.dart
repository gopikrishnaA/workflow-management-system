import 'package:flutter/material.dart';
import 'package:flutter_task_application/model/schedules_list.dart';
import 'package:flutter_task_application/model/user_list.dart';
import 'package:flutter_task_application/network/schedule_services.dart';
import 'package:flutter_task_application/network/user_services.dart';
import 'package:flutter_task_application/store/shared_pref.dart';
import 'package:flutter_task_application/utils/utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ScheduleController extends GetxController {
  RxBool titleFocus = false.obs;
  RxBool messageFocus = false.obs;
  RxBool correctMessage = false.obs;
  RxBool correctTitle = false.obs;
  RxBool loading = false.obs;
  RxBool isEdit = false.obs;
  RxInt pid = 0.obs;
  var selected = <String>[].obs;
  var usersList = <User>[].obs;
  RxString fromTime = ''.obs;
  RxString fromDate = ''.obs;
  RxString toTime = ''.obs;
  RxString toDate = ''.obs;
  final message = TextEditingController().obs;
  final title = TextEditingController().obs;

  @override
  void onInit() {
    super.onInit();
    loadEmployees(); // Call API when the controller is initialized
  }

  void loadEmployees() async {
    var user = await UserPref.getUser();
    if (user['ROLE'] == 'ROLE_MANAGER') {
      List<User>? items =
          await UserServices.getEmployees(); // Await the future to get the List
      setUserList(items!);
    }
  }

  void validateMessage() {
    correctMessage.value = message.value.text.toString().length > 5;
  }

  void validateTitle() {
    correctTitle.value = title.value.text.toString().length > 5;
  }

  void setLoading(bool value) {
    loading.value = value;
  }

  void setSelectedItem(Schedules? item) {
    final totalUsers = usersList.toList();
    final usersListInt = item!.users;
    List<String> users = totalUsers
        .where((user) => usersListInt!.contains(user.id))
        .map((user) => user.email)
        .toList();
    isEdit.value = true;
    correctMessage.value = true;
    correctTitle.value = true;
    title.value.text = item.name;
    message.value.text = item.description;
    selected.value = users;
    final startDate = item.startTime.split('T');
    fromDate.value = startDate[0];
    fromTime.value = startDate[1];
    final endDate = item.endTime.split('T');
    toDate.value = endDate[0];
    toTime.value = endDate[1];
    pid.value = item.id;
  }

  void cleanFormData() {
    isEdit.value = false;
    correctMessage.value = false;
    correctTitle.value = false;
    title.value.text = '';
    message.value.text = '';
    selected.value = [];
    fromDate.value = '';
    fromTime.value = '';
    toDate.value = '';
    toTime.value = '';
    messageFocus.value = false;
    titleFocus.value = false;
    pid.value = 0;
  }

  void setUserList(List<User> values) {
    usersList.value = values;
  }

  void setMultiSelect(List<String> values) {
    selected.value = values;
  }

  bool formValidations() {
    if (!correctTitle.value) {
      Utils.showSnackBar(
          'Warning',
          'Enter Title',
          const Icon(
            FontAwesomeIcons.triangleExclamation,
            color: Colors.pink,
          ));
      return true;
    }
    if (!correctMessage.value) {
      Utils.showSnackBar(
          'Warning',
          'Enter Message',
          const Icon(
            FontAwesomeIcons.triangleExclamation,
            color: Colors.pink,
          ));
      return true;
    }
    if (selected.isEmpty) {
      Utils.showSnackBar(
          'Warning',
          'Select atleast one Employee',
          const Icon(
            FontAwesomeIcons.triangleExclamation,
            color: Colors.pink,
          ));
      return true;
    }
    if (fromDate.value.isEmpty || fromTime.value.isEmpty) {
      Utils.showSnackBar(
          'Warning',
          'From date along with time required',
          const Icon(
            FontAwesomeIcons.triangleExclamation,
            color: Colors.pink,
          ));
      return true;
    }
    if (toDate.value.isEmpty || toTime.value.isEmpty) {
      Utils.showSnackBar(
          'Warning',
          'To date along with time required',
          const Icon(
            FontAwesomeIcons.triangleExclamation,
            color: Colors.pink,
          ));
      return true;
    }
    return false;
  }

  void createSchedule() {
    if (!formValidations()) {
      ScheduleServices.createSchedule();
    }
  }

  void updateSchedule() {
    if (!formValidations()) {
      ScheduleServices.updateSchedule();
    }
  }

  void onFocusMessage() {
    messageFocus.value = true;
    titleFocus.value = false;
  }

  void onFocusTitle() {
    messageFocus.value = false;
    titleFocus.value = true;
  }

  void onTapOutside(BuildContext context) {
    messageFocus.value = false;
    titleFocus.value = false;
    FocusScope.of(context).unfocus();
  }

  pickFromDate(BuildContext context) async {
    var pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2025),
    );
    if (pickedDate != null) {
      fromDate.value = Utils.formateDate(pickedDate);
    }
  }

  picFromTime(BuildContext context) async {
    TimeOfDay? pickedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (pickedTime != null) {
      DateFormat dateFormat = DateFormat('HH:mm');
      fromTime.value = dateFormat.format(DateTime(
        2323,
        1,
        1,
        pickedTime.hour,
        pickedTime.minute,
      ));
    }
  }

  pickToDate(BuildContext context) async {
    var pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2025),
    );
    if (pickedDate != null) {
      toDate.value = Utils.formateDate(pickedDate);
    }
  }

  picToTime(BuildContext context) async {
    TimeOfDay? pickedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (pickedTime != null) {
      DateFormat dateFormat = DateFormat('HH:mm');
      toTime.value = dateFormat.format(DateTime(
        2323,
        1,
        1,
        pickedTime.hour,
        pickedTime.minute,
      ));
    }
  }
}
