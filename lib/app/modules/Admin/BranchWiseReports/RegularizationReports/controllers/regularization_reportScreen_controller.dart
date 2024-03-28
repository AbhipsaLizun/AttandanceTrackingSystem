import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegularizationReportScreenController extends GetxController {
  final tabs = ['Pending', 'Approved', 'Cancel', 'Hold', 'Reject'].obs;
  final selectedTabIndex = 0.obs; // Track the selected tab index
}