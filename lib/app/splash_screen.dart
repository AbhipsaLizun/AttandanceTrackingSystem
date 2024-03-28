import 'package:attendance_system/app/modules/Employee/Commons/screensize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'modules/CommonScreen/controllers/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  final SplashScreenController splashController =
      Get.put(SplashScreenController());

  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          SvgPicture.asset(
            'assets/images/svg/ScreenBG.svg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),

          // Your Logo or other widgets
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Lottie.asset(
                //   'assets/lottie/app_logo.json',
                //   fit: BoxFit.cover,
                //   width: splashController
                //       .scaledWidth(300.0), // Increase the image width
                // ),
                Image.asset(
                  "assets/images/png/track_logo.png",
                  height: AppDimension.width(context) / 1.3,
                  width: AppDimension.width(context) / 1.3,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: splashController.scaledHeight(16.0)),
                Text(
                  'Attendance Tracking \n System',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: splashController.scaledWidth(24.0),
                    // Increase the font size
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Alkatra-Medium',
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: splashController.scaledHeight(9.0)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
