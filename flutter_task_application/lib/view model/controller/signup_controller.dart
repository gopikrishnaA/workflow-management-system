import 'package:flutter/material.dart';
import 'package:flutter_task_application/network/user_services.dart';
import 'package:flutter_task_application/utils/utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  RxBool nameFocus = false.obs;
  RxBool emailFocus = false.obs;
  RxBool passwordFocus = false.obs;
  RxBool correctEmail = false.obs;
  RxBool correctName = false.obs;
  RxBool showPassword = true.obs;
  RxBool loading = false.obs;
  // final FirebaseServices firebase=FirebaseServices();
  final email = TextEditingController().obs;
  final name = TextEditingController().obs;
  final password = TextEditingController().obs;
  void validateEmail() {
    correctEmail.value = Utils.validateEmail(email.value.text.toString());
  }

  void validateName() {
    correctName.value = name.value.text.toString().length > 2;
  }

  void setLoading(bool value) {
    loading.value = value;
  }

  void createAccount() {
    if (!correctName.value) {
      Utils.showSnackBar(
          'Warning',
          'Enter Username',
          const Icon(
            FontAwesomeIcons.triangleExclamation,
            color: Colors.pink,
          ));
      return;
    }
    if (!correctEmail.value) {
      Utils.showSnackBar(
          'Warning',
          'Enter Email',
          const Icon(
            FontAwesomeIcons.triangleExclamation,
            color: Colors.pink,
          ));
      return;
    }
    if (password.value.text.toString().length < 6) {
      Utils.showSnackBar(
          'Warning',
          'Password length should greater than 5',
          const Icon(
            FontAwesomeIcons.triangleExclamation,
            color: Colors.pink,
          ));
      return;
    }

    UserServices.createAccount();
  }

  void onFocusEmail() {
    emailFocus.value = true;
    nameFocus.value = false;
    passwordFocus.value = false;
  }

  void onFocusName() {
    emailFocus.value = false;
    nameFocus.value = true;
    passwordFocus.value = false;
  }

  void onFocusPassword() {
    emailFocus.value = false;
    nameFocus.value = false;
    passwordFocus.value = true;
  }

  void onTapOutside(BuildContext context) {
    emailFocus.value = false;
    nameFocus.value = false;
    passwordFocus.value = false;
    FocusScope.of(context).unfocus();
  }

  final selected = "EMPLOYEE".obs;

  var listType = <String>['EMPLOYEE', 'MANAGER'];

  void setSelected(String value) {
    selected.value = value;
  }

  void clearData() {
    email.value.text = '';
    name.value.text = '';
    password.value.text = '';
    emailFocus.value = false;
    nameFocus.value = false;
    passwordFocus.value = false;
    correctEmail.value = false;
    correctName.value = false;
    showPassword.value = true;
    loading.value = false;
    selected.value = 'EMPLOYEE';
  }
}
