import 'package:flutter/material.dart';
import '../constants/color_constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: LightColor.primary,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(10.0), // Adjust the radius as needed
        ),
      ),
      child: Text(text),
    );
  }
}
