import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static const Color primaryColor =  Color(0xff37C3C4);
  static const Color secondaryColor =  Color(0xff37C3C4);



  // Function to set the status bar style based on the theme mode
  static void setStatusBarStyle(ThemeMode mode) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: mode == ThemeMode.dark ? Colors.grey[900] : primaryColor,
      statusBarIconBrightness: mode == ThemeMode.dark ? Brightness.light : Brightness.light,
    ));
  }

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    appBarTheme: const AppBarTheme(
      color: primaryColor,
    ), colorScheme: const ColorScheme.light(primary: secondaryColor, secondary: secondaryColor).copyWith(secondary: secondaryColor),
    // Add more theme properties as needed
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    appBarTheme: const AppBarTheme(
      color: primaryColor,
    ), colorScheme: const ColorScheme.dark(primary: primaryColor, secondary: secondaryColor).copyWith(secondary: secondaryColor),
    // Add more theme properties as needed
  );

}