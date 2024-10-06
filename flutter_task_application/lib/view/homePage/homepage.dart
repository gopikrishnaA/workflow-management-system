import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_task_application/res/app_color.dart';
import 'package:flutter_task_application/res/assets/app_icons.dart';
import 'package:flutter_task_application/res/routes/routes.dart';
import 'package:flutter_task_application/view%20model/controller/home_controller.dart';
import 'package:flutter_task_application/view%20model/controller/schedule_controller.dart';
import 'package:flutter_task_application/view%20model/controller/task_controller.dart';
import 'package:flutter_task_application/view/common%20widgets/back_button.dart';
import 'package:flutter_task_application/view/homePage/components/expandable_fab_button.dart';
import 'package:flutter_task_application/view/homePage/components/schedules_list.dart';
import 'package:flutter_task_application/view/homePage/components/task_list.dart';
import 'package:get/get.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Homepage> {
  final controller = Get.put(HomeController());
  final scheduleController = Get.put(ScheduleController());
  final taskController = Get.put(TaskContoller());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static const _actionTitles = ['Create Task', 'Create Schdule'];

  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    SchedulesList(),
    TaskList()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      controller.loadSchedules();
    }
    if (index == 1) {
      controller.loadTasks();
    }
  }

  void _openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  void _showAction(BuildContext context, int index) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(_actionTitles[index]),
          actions: [
            TextButton(
              onPressed: () {
                // Close the dialog
                Get.back();
                if (index == 0) {
                  taskController.cleanFormData();
                  Get.toNamed(Routes.createTasKScreen);
                } else if (index == 1) {
                  scheduleController.cleanFormData();
                  Get.toNamed(Routes.createScheduleScreen);
                }
                // Navigate to the appropriate screen based on the index
                // Get.toNamed(
                //     ? Routes.createTasKScreen
                //     : Routes.createScheduleScreen);
              },
              child: const Text('Create'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> items = ['Schedules', 'Tasks'];
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: black,
        floatingActionButton: ExpandableFab(
          distance: 100,
          children: [
            ActionButton(
              onPressed: () => _showAction(context, 0),
              icon: const Icon(Icons.task),
            ),
            ActionButton(
              onPressed: () => _showAction(context, 1),
              icon: const Icon(Icons.schedule),
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: SvgPicture.asset(
                        AppIcon.menu,
                        color: Colors.white,
                        height: 30,
                        width: 30,
                      ),
                      onPressed: _openDrawer,
                    ),
                    Column(
                      children: [
                        Obx(
                          () => Text(
                            'Hi, ${controller.name}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                        Obx(() => Text(
                              'Role: ${controller.role.value}',
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13),
                            )),
                      ],
                    ),
                    CustomBackButton(
                      height: 40,
                      width: 40,
                      radius: 40,
                      onPressed: () {
                        controller.logout(context);
                      },
                      widget: const Center(
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.logout,
                            color: Colors.white70,
                            size: 18,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 80,
                child: _widgetOptions[_selectedIndex],
              ),
            ],
          ),
        ),
        drawer: Drawer(
            child: Column(children: <Widget>[
          const SizedBox(
              height: 64.0,
              width: double.infinity,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.pink,
                ),
                child: Text('WorkFlow management',
                    style: TextStyle(color: Colors.white, fontSize: 18)),
              )),
          Expanded(
              child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  items[index], // Display the current item from the list
                  style: TextStyle(
                    color: _selectedIndex == index ? Colors.pink : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                selected: _selectedIndex == index,
                onTap: () {
                  // Update the state of the app
                  _onItemTapped(index);
                  // Then close the drawer
                  Navigator.pop(context);
                },
              );
            },
          ))
        ])),
        // Disable opening the drawer with a swipe gesture.
        drawerEnableOpenDragGesture: false);
  }
}
