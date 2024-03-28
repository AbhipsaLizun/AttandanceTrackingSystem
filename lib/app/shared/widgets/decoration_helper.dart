import 'package:flutter/material.dart';

class DecorationHelper {
  static InputDecoration get roundedBoxDecoration {
    return InputDecoration(
      errorMaxLines: 5,
      errorStyle: const TextStyle(fontSize: 13,fontWeight: FontWeight.w500),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      hintStyle: const TextStyle(
          color: Colors.black, fontSize: 16),

    );
  }


}