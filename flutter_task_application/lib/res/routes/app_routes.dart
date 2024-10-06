import 'package:flutter_task_application/res/routes/routes.dart';
import 'package:flutter_task_application/view/create%20schedule/create_schedule.dart';
import 'package:flutter_task_application/view/create%20task/create_task.dart';
import 'package:flutter_task_application/view/employeePage/employee_page.dart';
import 'package:flutter_task_application/view/homePage/homepage.dart';
import 'package:flutter_task_application/view/sign%20in/sign_in.dart';
import 'package:flutter_task_application/view/signup/signup.dart';
import 'package:flutter_task_application/view/task%20details/task_details.dart';
import 'package:get/get.dart';

class AppRoutes {
  static List<GetPage> routes() {
    return [
      GetPage(name: Routes.splashScreen, page: () => const SignIn()),
      GetPage(name: Routes.signInScreen, page: () => const SignIn()),
      GetPage(name: Routes.signUpScreen, page: () => const SignUp()),
      GetPage(name: Routes.homePage, page: () => const Homepage()),
      GetPage(name: Routes.employeePage, page: () => const EmployeePage()),
      GetPage(
          name: Routes.createScheduleScreen,
          page: () => const CreateSchedule()),
      GetPage(name: Routes.createTasKScreen, page: () => const CreateTask()),
      GetPage(name: Routes.taskDetailsScreen, page: () => const TaskDetails()),
    ];
  }
}
