import 'dart:convert';

import 'package:attendance_system/app/modules/Admin/EmployeesAttendanceReport/controllers/employee_attendance_report_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../../ApiServices/api_end_points.dart';
import '../../Home/controllers/admin_home_screen_controller.dart';
import '../models/attendance_history.dart';

class WeeklyAttendanceReportScreenController extends GetxController {

  RxInt selectedIndex = RxInt(0);
  DateTime now = DateTime.now();
  late DateTime lastDayOfMonth;
  DateTime? selectedDate;
  final AdminHomeScreenController adminHomeScreenController =
      Get.find<AdminHomeScreenController>();
  final EmployeeAttendanceReportScreenController
      employeeAttendanceReportScreenController =
      Get.find<EmployeeAttendanceReportScreenController>();
  final RxList<AttendanceHistory> attendanceHistoryList =
      <AttendanceHistory>[].obs;
  final RxString errorMessage = ''.obs; // Add an error message variable
  RxBool isLoading = false.obs; // Add an isLoading variable
  final ScrollController scrollController = ScrollController();
  final ScrollController dateScrollController = ScrollController(); // Add ScrollController
  final double itemWidth = 42.0; // Replace with the actual width of each date item
  final double spacing = 16.0; // Replace with the actual spacing between date items

  @override
  void onInit() {
    super.onInit();
    lastDayOfMonth = DateTime(now.year, now.month + 1, 0);

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      // This code will be executed after the frame has been built
      dateScrollController.animateTo(
        selectedIndex.value * (itemWidth + spacing),
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  void selectDate(int index) {
    selectedIndex.value = index;
    selectedDate = DateTime(now.year, now.month, index + 1);
    loadData(); // Call the method to load data when the date is selected
    print(employeeAttendanceReportScreenController.selectedUserId.value
        .toString());
    dateScrollController.animateTo(selectedIndex.value * (itemWidth + spacing),
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  Future<void> loadData() async {
    isLoading.value = true; // Start loading
    attendanceHistoryList.clear(); // Clear the existing list
    print(selectedDate?.toString());
    errorMessage.value = '';
    final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate!);
    print(formattedDate);
    try {
      final url = Uri.parse(
          '${ApiEndPoints.CommonBaseUrl}${AuthEndPoints.checkIncheckOutDayWeekMonth}UserId=${employeeAttendanceReportScreenController.selectedUserId.value.toString()}&finYear=1&branchId=${adminHomeScreenController.selectedBranchId.value.toString()}&ttype=week1&indate='+formattedDate);
      final response = await http.post(url);
      print(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(response.body);
        if (data['isSuccess'] == true) {
          final result = data['result'] as List;
          final employeesList = result.map((e) => AttendanceHistory.fromJson(e)).toList();
          attendanceHistoryList.assignAll(employeesList);

        } else {
          errorMessage.value = data['errorMessage'].isNotEmpty
              ? data['errorMessage'][0]
              : 'An error occurred.';
        }
      } else {
        throw Exception('Failed to load employee data');
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
      print(e);
    }finally {
      isLoading.value = false; // Finish loading
    }
  }

}
