import 'package:attendance_system/app/modules/Employee/Leave/screens/leave_report_list.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'app/themes/app_theme.dart';

void main() {
  runApp(const MyApp());

  // runApp(DevicePreview(
  //   enabled: !kReleaseMode,
  //   builder: (context) => MyApp(), // Wrap your app
  // ));

  SystemChannels.textInput.invokeMethod('TextInput.hide');

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    // Initial setup of status bar style
    //AppTheme.setStatusBarStyle(ThemeMode.system);
    AppTheme.setStatusBarStyle(ThemeMode.system);

    return GetMaterialApp(
      title: 'Attendance System',
      debugShowCheckedModeBanner: false,


      getPages: getPages,

      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      //theme: Themes.lightTheme,
      theme: AppTheme.lightTheme,
      // Set the default light theme
      // darkTheme: AppTheme.darkTheme, // Set the default dark theme
      themeMode: ThemeMode.system,


      initialRoute: '/',
      // initialRoute: '/LeaveReport',


      defaultTransition: Transition.fadeIn,
      //  You can choose a different transition here
      //transitionDuration: Duration(milliseconds: 500),
      transitionDuration: Get.defaultTransitionDuration,
      //  opaqueRoute: Get.isOpaqueRouteDefault,
      //  popGesture: Get.isPopGestureEnable,
    );
  }
}
