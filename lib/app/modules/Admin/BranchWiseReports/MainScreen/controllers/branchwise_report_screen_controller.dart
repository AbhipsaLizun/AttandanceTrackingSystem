
import 'package:attendance_system/app/shared/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BranchWiseReportController extends GetxController {
  final RxList<IconData> icons = [
    Icons.schedule,
    Icons.rounded_corner,
  ].obs;

  final RxList<String> texts = [
    'Regularization Reports',
    'Leave Reports',
  ].obs;

  final RxList<Color> cardColors = [
    LightColor.primary, // You can customize the colors as needed
    LightColor.primary,
  ].obs;
}