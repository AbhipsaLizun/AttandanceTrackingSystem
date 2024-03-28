import 'package:attendance_system/app/shared/constants/color_constants.dart';
import 'package:flutter/material.dart';

import '../../modules/CommonScreen/controllers/login_controller.dart';

class AppDecoration {
  static InputDecoration textFieldInputDecoration(
      String label, IconData icon, LoginController loginController) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(
        icon,
        color: LightColor.textcolor,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    );
  }

  static InputDecoration passwordInputDecoration(LoginController loginController) {
    return InputDecoration(
      hintText: 'Password',
      prefixIcon: const Icon(
        Icons.lock,
        color:LightColor.primary,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    );
  }

  static InputDecoration textFieldDecoration() {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    );
  }
}
