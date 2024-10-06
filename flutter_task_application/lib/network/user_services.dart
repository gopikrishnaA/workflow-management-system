import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_task_application/model/login_response.dart';
import 'package:flutter_task_application/model/user_list.dart';
import 'package:flutter_task_application/network/endpoints.dart';
import 'package:flutter_task_application/res/routes/routes.dart';
import 'package:flutter_task_application/store/shared_pref.dart';
import 'package:flutter_task_application/utils/utils.dart';
import 'package:flutter_task_application/view%20model/controller/signin_controller.dart';
import 'package:flutter_task_application/view%20model/controller/signup_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UserServices {
  static final signInController = Get.put(SignInController());
  static final signupController = Get.put(SignupController());

  static Future<void> loginAccount(String username, String password) async {
    try {
      signInController.setLoading(true);
      final response = await http.post(Uri.parse(Endpoints.signIn),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'username': username.toString(),
            'password': password.toString()
          }));
      if (response.statusCode == 200) {
        Utils.showSnackBar(
            'Sign up',
            "Successfully Login. Welcome Back!",
            const Icon(
              Icons.done,
              color: Colors.white,
            ));
        LoginResponse res = LoginResponse.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
        var role = res.authorities[0].authority;
        UserPref.setUser(
            res.username, res.email, role, res.accessToken, res.id);
        if (role == 'ROLE_MANAGER') {
          Get.toNamed(Routes.homePage);
        }
        if (role == 'ROLE_EMPLOYEE') {
          Get.toNamed(Routes.employeePage);
        }
        signInController.clearData();
      } else if (response.statusCode == 401) {
        Utils.showSnackBar(
            'Error',
            "Not valid credentials!",
            const Icon(
              FontAwesomeIcons.triangleExclamation,
              color: Colors.red,
            ));
      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        Utils.showSnackBar(
            'Error',
            'Something went wrong',
            const Icon(
              FontAwesomeIcons.triangleExclamation,
              color: Colors.red,
            ));
      }
      signInController.setLoading(false);
    } catch (e) {
      Utils.showSnackBar(
          'Error',
          e.toString(),
          const Icon(
            FontAwesomeIcons.triangleExclamation,
            color: Colors.red,
          ));
      signInController.setLoading(false);
    }
  }

  static Future<void> createAccount() async {
    try {
      signupController.setLoading(true);
      final response = await http.post(Uri.parse(Endpoints.signUp),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'username': signupController.name.value.text.toString(),
            'password': signupController.password.value.text.toString(),
            'email': signupController.email.value.text.toString(),
            'name': signupController.name.value.text.toString(),
            'user': signupController.selected.value
          }));

      if (response.statusCode == 200) {
        Utils.showSnackBar(
            'Sign up',
            "Successfully Created Account. Please login!",
            const Icon(
              Icons.done,
              color: Colors.white,
            ));
        Get.toNamed(Routes.signInScreen);
        signupController.clearData();
      } else if (response.statusCode == 401) {
        Utils.showSnackBar(
            'Error',
            "Not valid data!",
            const Icon(
              FontAwesomeIcons.triangleExclamation,
              color: Colors.red,
            ));
      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        Utils.showSnackBar(
            'Error',
            response.body.toString(),
            const Icon(
              FontAwesomeIcons.triangleExclamation,
              color: Colors.red,
            ));
      }
      signupController.setLoading(false);
    } catch (e) {
      Utils.showSnackBar(
          'Error',
          e.toString(),
          const Icon(
            FontAwesomeIcons.triangleExclamation,
            color: Colors.red,
          ));
      signupController.setLoading(false);
    }
  }

  static Future<List<User>?> getEmployees() async {
    try {
      final user = await UserPref.getUser();
      final response = await http.get(
          Uri.parse('${Endpoints.getUsersByRole}/1'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${user['TOKEN']}'
          });
      Userlist userlist =
          Userlist.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      return userlist.users;
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
