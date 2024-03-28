import 'package:flutter/material.dart';

class MyPageTransitions {
  // ignore: prefer_function_declarations_over_variables
  static final RouteTransitionsBuilder slideRight = (context, animation, secondaryAnimation, child) {
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0)).animate(animation),
      child: child,
    );
  };

  // ignore: prefer_function_declarations_over_variables
  static final RouteTransitionsBuilder slideLeft = (context, animation, secondaryAnimation, child) {
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(-1, 0), end: const Offset(0, 0)).animate(animation),
      child: child,
    );
  };

  // ignore: prefer_function_declarations_over_variables
  static final RouteTransitionsBuilder fadeIn = (context, animation, secondaryAnimation, child) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  };
}