import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color_constants.dart';

class AppTextStyles {

  static TextStyle customTextStyle({
    Color color = Colors.black,
    double fontSize = 16.0,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return GoogleFonts.poppins(
      textStyle: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }


  static TextStyle titleStyle(BuildContext context) {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.width * 0.05,
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontFamily: 'Roboto',
    );
  }

  static TextStyle description(BuildContext context) {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.width * 0.04,
      color: Colors.grey,
      fontStyle: FontStyle.italic,
    );
  }

  static TextStyle headline1(BuildContext context) {
    return TextStyle(
      color: Colors.white,
      fontSize: MediaQuery.of(context).size.width * 0.06, // Responsive font size
      fontFamily: 'Poppins',
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle headline2(BuildContext context) {
    return TextStyle(
      color: Colors.white,
      fontSize: MediaQuery.of(context).size.width * 0.06, // Responsive font size
      fontFamily: 'Poppins',
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle bodyText1(BuildContext context) {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.width * 0.045, // Responsive font size
      color: LightColor.primary,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle bodyText1normal(BuildContext context) {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.width * 0.045, // Responsive font size
      color: LightColor.primary,
      fontFamily: 'Poppins',
    );
  }

  static TextStyle bodyText2(BuildContext context) {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.width * 0.042, // Responsive font size
      color: LightColor.primary,
      fontFamily: 'Poppins',
    );
  }

  static TextStyle bodyText2black(BuildContext context) {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.width * 0.042, // Responsive font size
      color: LightColor.textcolor,
      fontFamily: 'Poppins',
    );
  }

  static TextStyle buttonText(BuildContext context) {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.width * 0.055, // Responsive font size
      fontFamily: 'Poppins',
    );
  }


  static TextStyle headlineText(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: MediaQuery.of(context).size.width * 0.038, // Responsive font size
      fontWeight: FontWeight.w500
    );
  }
}