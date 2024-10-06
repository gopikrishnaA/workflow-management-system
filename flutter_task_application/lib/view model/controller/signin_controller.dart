import 'package:flutter/material.dart';
import 'package:flutter_task_application/network/user_services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../utils/utils.dart';

class SignInController extends GetxController {
  RxBool usernameFocus = false.obs;
  RxBool passwordFocus = false.obs;
  RxBool correctUsername = false.obs;
  RxBool showPassword = true.obs;
  RxBool loading = false.obs;
  final username = TextEditingController().obs;
  final password = TextEditingController().obs;

  void loginAccount() {
    if (!correctUsername.value) {
      var msg = '';
      if (username.value.text.isEmpty) {
        msg = 'Enter Username';
      } else if (username.value.text.length <= 2) {
        msg = 'Enter Valid Usename';
      }
      Utils.showSnackBar(
          'Warning',
          msg,
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

    UserServices.loginAccount(username.value.text, password.value.text);
  }

  void setLoading(bool value) {
    loading.value = value;
  }

  void validateUsername() {
    correctUsername.value = username.value.text.length > 2;
  }

  void onFocusUsername() {
    usernameFocus.value = true;
    passwordFocus.value = false;
  }

  void onFocusPassword() {
    usernameFocus.value = false;
    passwordFocus.value = true;
  }

  void onTapOutside(BuildContext context) {
    usernameFocus.value = false;
    passwordFocus.value = false;
    FocusScope.of(context).unfocus();
  }

  void clearData() {
    username.value.text = '';
    password.value.text = '';
    usernameFocus.value = false;
    passwordFocus.value = false;
    correctUsername.value = false;
    showPassword.value = true;
    loading.value = false;
  }
}
