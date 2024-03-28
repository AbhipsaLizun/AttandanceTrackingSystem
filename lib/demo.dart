
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
// import 'detector_painters.dart';
// import 'utils.dart';
import 'package:flutter/services.dart';

class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key});

  @override
  State<DemoScreen> createState() => DemoScreenState();
}

class DemoScreenState extends State<DemoScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.height,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[350]
            ),
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Text(
                    "Abhipsa Moharana hwfuygrygf hjbcuyeru hwebfyugrfyu buyfyrhuyguyghuyhuogyohg njiuniuhiubuybn",
                  //       style: TextStyle(
                  //         fontSize: 2.2 * (SizeConfig.blockSizeVertical ?? 5.0
                  //         ),
                  // ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? blockSizeHorizontal;
  static double? blockSizeVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    blockSizeHorizontal = screenWidth! / 50;
    blockSizeVertical = screenHeight! / 100;
  }
}
