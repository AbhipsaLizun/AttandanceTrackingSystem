import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomToast {
  static void showToast(String message, {Color? backgroundColor}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor ?? Colors.green, // Use the provided color or default to green
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }


}