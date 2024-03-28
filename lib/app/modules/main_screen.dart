import 'package:attendance_system/app/modules/Employee/ColorsGallary/color_section.dart';
import 'package:attendance_system/app/modules/Employee/Commons/screensize.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../core/app_drawer.dart';
import '../shared/constants/color_constants.dart';
import 'Employee/Report/screens/report_screen.dart';
import 'Employee/Home/controllers/employee_home_controller.dart';
import 'Employee/Home/screens/employee_home_screen.dart';

class MainScreen extends StatelessWidget {
  final EmployeeHomeController controller = Get.put(EmployeeHomeController());
  final box = GetStorage();

  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var userId = box.read('userId') ?? '';
    var loginType = box.read('LoginType') ?? '';
    var arguments = Get.arguments;
    int initialTabIndex =
        arguments != null && arguments['initialTabIndex'] != null
            ? arguments['initialTabIndex']
            : 0;
    controller.changePage(initialTabIndex);
    // controller.changePage(1);

    print(userId);

    return Scaffold(
      appBar: AppBar(
        title:  Text("Oasys Tech Solution Pvt. Ltd",style: TextStyle(fontSize: AppDimension.width(context) < 370 ? 17 :20),
        ),
        centerTitle: true,
      ),
      drawer: AppDrawer(),
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text('Tap back again to leave'),
        ),
        child: Obx(
          () => IndexedStack(
            index: controller.currentIndex.value,
           // index: 1,
            children: [
              // First tab: Home
              EmployeeHomeScreen(),
              // Second tab: Calendar
              ReportScreen()
              /*Center(
                child: Text("Calendar Screen"),
              ),*/
              // Add more screens for additional tabs
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          elevation: 50,
          currentIndex: controller.currentIndex.value,
          onTap: (index) {
            controller.changePage(index);
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Report',
            ),
            // Add more items for additional tabs
          ],
          selectedItemColor: LightColor.primary,
          // Selected icon color
          unselectedItemColor: Colors.grey,
          // Unselected icon color
          selectedFontSize: 16,
          // Selected item font size
          unselectedFontSize: 12,
          // Unselected item font size
          showSelectedLabels: true,
          // Show labels for selected items
          showUnselectedLabels: true,
          // Show labels for unselected items
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
