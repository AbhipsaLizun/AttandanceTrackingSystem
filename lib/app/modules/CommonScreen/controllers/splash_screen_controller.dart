import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashScreenController extends GetxController {
  double screenWidth = 0.0;
  double screenHeight = 0.0;
  double referenceScreenWidth = 400.0;
  double referenceScreenHeight = 640.0;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    _updateScreenSize();
  }

  void _updateScreenSize() {
    final mediaQuery = MediaQuery.of(Get.context!);
    screenWidth = mediaQuery.size.width;
    screenHeight = mediaQuery.size.height;
    update(); // Notify listeners that screen size has changed
  }

  double scaledWidth(double width) {
    return screenWidth * (width / referenceScreenWidth);
  }

  double scaledHeight(double height) {
    return screenHeight * (height / referenceScreenHeight);
  }

  @override
  void onReady() {
    super.onReady();
    // Simulate token availability check or other async tasks
    // For example, you can check for a token here and navigate accordingly.
    Future.delayed(const Duration(seconds: 2), () {
      var userId = box.read('userId') ?? '';
      var loginType = box.read('LoginType') ?? '';

      if (userId!='' && loginType == 'Admin') {
        // Token available, navigate to AdminHomeScreen
        Get.offAllNamed('/AdminHomeScreen');
      } else if (userId!='') {
        // Token available, but loginType is not 'Admin', navigate to MainScreen
        Get.offAllNamed('/MainScreen');
      } else {
        // Token not available, navigate to LoginScreen
        Get.offAllNamed('/LoginScreen');
      }
    });


  }
}
