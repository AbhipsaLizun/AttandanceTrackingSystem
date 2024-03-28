import 'dart:convert';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart'as http;

import '../../../../ApiServices/api_end_points.dart';
import '../../EmployeesAttendanceReport/controllers/employee_attendance_report_screen_controller.dart';
import '../../Home/controllers/admin_home_screen_controller.dart';
import '../models/MonthlyReportAttendanceData.dart';

class MonthlyAttendanceReportScreenController extends GetxController {
  late DateTime focusedDay;
  late CalendarFormat calendarFormat;
  Rx<DateTime?> selectedDay = Rx<DateTime?>(null);
  RxBool isLoading = RxBool(false);
  RxList<MonthlyReportAttendanceData> reportList = <MonthlyReportAttendanceData >[].obs;
  final RxString errorMessage = ''.obs;
  final EmployeeAttendanceReportScreenController
  employeeAttendanceReportScreenController =
  Get.find<EmployeeAttendanceReportScreenController>();
  final AdminHomeScreenController adminHomeScreenController =
  Get.find<AdminHomeScreenController>();
  @override
  void onInit() {
    super.onInit();
    focusedDay = DateTime.now();
    calendarFormat = CalendarFormat.month;
  }

  void setCalendarFormat(CalendarFormat format) {
    calendarFormat = format;
    update();
  }

  void onPageChanged(DateTime newFocusedDay) {
    focusedDay = newFocusedDay;
    update();
  }

  void onDaySelected(DateTime selected) {
    selectedDay.value = selected;
    focusedDay = selected;
    update();
    loadData(selected);

  }

  Future<void> loadData(DateTime selectedDate) async {
    isLoading.value = true;
    reportList.clear(); // Clear the existing list
    errorMessage.value = '';
    try {
      final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
      print(formattedDate);


      final url = Uri.parse(
          '${ApiEndPoints.CommonBaseUrl}${AuthEndPoints.checkIncheckOutDayWeekMonth}UserId=${employeeAttendanceReportScreenController.selectedUserId.value.toString()}&finYear=1&branchId=${adminHomeScreenController.selectedBranchId.value.toString()}&ttype=month1&indate=$formattedDate');
      final response = await http.post(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['isSuccess'] == true) {
          final result = data['result'] as List;
          final data1 = result.map((item) => MonthlyReportAttendanceData.fromJson(item)).toList();
          reportList.assignAll(data1);
        } else {
          errorMessage.value = data['errorMessage'].isNotEmpty
              ? data['errorMessage'][0]
              : 'An error occurred.';
        }
      } else {
        errorMessage.value = 'Failed to load data. HTTP Error';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }
}