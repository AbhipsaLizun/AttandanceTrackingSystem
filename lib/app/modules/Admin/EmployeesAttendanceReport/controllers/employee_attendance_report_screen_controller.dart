import 'dart:convert';

import 'package:attendance_system/app/modules/Admin/EmployeesAttendanceReport/models/employee.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../ApiServices/api_end_points.dart';
import '../../Home/controllers/admin_home_screen_controller.dart';

class EmployeeAttendanceReportScreenController extends GetxController {
  final RxString selectedLocation = ''.obs;
  final RxList<Employee> employees = <Employee>[].obs;
  final AdminHomeScreenController adminHomeScreenController =
      Get.find<AdminHomeScreenController>();
  final RxString errorMessage = ''.obs; // Add an error message variable
  final RxString selectedUserId = ''.obs;
  final RxString selectedUserName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchEmployeeData();
    print(adminHomeScreenController.selectedBranchId.value.toString());
  }
  String calculateWorkingHours(String timeIn, String timeOut) {
    // Split time components and ensure at least two components
    List<String> inTimeComponents = timeIn.split(':');
    List<String> outTimeComponents = timeOut.split(':');

    // Ensure at least two components and pad with zeros if needed
    while (inTimeComponents.length < 2) {
      inTimeComponents.add('0');
    }

    while (outTimeComponents.length < 2) {
      outTimeComponents.add('0');
    }

    int inHours = int.tryParse(inTimeComponents[0]) ?? 0;
    int inMinutes = int.tryParse(inTimeComponents[1]) ?? 0;

    int outHours = int.tryParse(outTimeComponents[0]) ?? 0;
    int outMinutes = int.tryParse(outTimeComponents[1]) ?? 0;

    DateTime inTime = DateTime(1970, 1, 1, inHours, inMinutes);
    DateTime outTime = DateTime(1970, 1, 1, outHours, outMinutes);

    // Calculate the difference in hours and minutes
    Duration difference = outTime.difference(inTime);

    // Format the result as HH:mm
    String formattedDifference =
        '${difference.inHours.toString().padLeft(2, '0')}:${(difference.inMinutes % 60).toString().padLeft(2, '0')}';

    return formattedDifference;
  }

  Future<void> fetchEmployeeData() async {
    try {
      DateTime now = DateTime.now().toLocal();
      String formattedDate = "${now.year}-${now.month}-${now.day}";
      //${formattedDate}
      print(formattedDate);

      final url = Uri.parse('${ApiEndPoints.CommonBaseUrl}${AuthEndPoints.checkIncheckOutDayWeekMonth}?UserId=0&finYear=1&branchId=${adminHomeScreenController.selectedBranchId.value.toString()}&ttype=Tdate&indate=${formattedDate}');
      final response = await http.post(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['isSuccess'] == true) {
          final result = data['result'] as List;
          final employeesList =
          result.map((e) => Employee.fromJson(e)).toList();
          employees.assignAll(employeesList);
          update();
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
    }
  }



}
