import 'package:flutter/material.dart';

class CustomInputDecoration {
  static InputDecoration textFieldDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      labelStyle:const TextStyle(
          color: Colors.black, fontSize: 15) ,
      errorStyle: const TextStyle(fontSize: 13,fontWeight: FontWeight.w500),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    );
  }
}
