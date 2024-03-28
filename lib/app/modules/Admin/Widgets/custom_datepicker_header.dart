import 'package:flutter/material.dart';

class CustomDatePickerHeader extends StatelessWidget {
  final Color backgroundColor;
  final Widget child;

  const CustomDatePickerHeader({super.key, 
    required this.backgroundColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: child,
    );
  }
}