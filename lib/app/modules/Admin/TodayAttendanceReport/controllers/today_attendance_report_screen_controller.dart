import 'dart:convert';

import 'package:attendance_system/app/modules/Admin/Home/controllers/admin_home_screen_controller.dart';
import 'package:attendance_system/app/shared/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../../../ApiServices/api_end_points.dart';
import '../../../../shared/widgets/custom_loading_dialog.dart';
import '../../EmployeesAttendanceReport/controllers/employee_attendance_report_screen_controller.dart';
import '../models/attendance.dart';
import '../models/regularization.dart';

class TodayAttendanceReportScreenController extends GetxController {

  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxList<Attendance> attendanceList = <Attendance>[].obs;
  final EmployeeAttendanceReportScreenController
      employeeAttendanceReportScreenController =
      Get.find<EmployeeAttendanceReportScreenController>();

  final AdminHomeScreenController adminHomeScreenController =
      Get.find<AdminHomeScreenController>();
  RxString errorMessage = ''.obs;
  RxString regularizationErorMessage = ''.obs;
  RxList<Regularization> regularizationList = <Regularization>[].obs;
  final box = GetStorage();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchAttendanceData();
    print(employeeAttendanceReportScreenController.selectedUserId.value
        .toString());

    fetchRegularizationData();
    print(selectedDate.value.toLocal());
  }

  Future<void> fetchAttendanceData() async {
    try {
      final url = Uri.parse(
          '${ApiEndPoints.attendanceReportBaseUrl}${AuthEndPoints.GetCheckInOutByIDWithHour}?InputDate=${selectedDate.value.toLocal()}&UId=${employeeAttendanceReportScreenController.selectedUserId.value.toString()}&FinYear=1&branchId=${adminHomeScreenController.selectedBranchId.value.toString()}');
      final response = await http.post(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final IsSuccess = data['isSuccess'] as bool;

        if (IsSuccess) {
          final attendances = (data['result'] as List<dynamic>)
              .map((item) => Attendance.fromJson(item))
              .toList();
          attendanceList.assignAll(attendances);

        } else {
          errorMessage.value = data['errorMessage'].isNotEmpty
              ? data['errorMessage'][0]
              : 'An error occurred.';
        }
      } else {
        // Handle other HTTP status codes
        errorMessage.value = 'Failed to fetch data. Please try again.';
      }
    } catch (e) {
      // Handle other errors
      errorMessage.value = 'Error: $e';
    }
  }

  Future<void> fetchRegularizationData() async {
    try {
      final url = Uri.parse(
          '${ApiEndPoints.regularizationsBaseUrl}${AuthEndPoints.getRegulizationByID}UserId=${employeeAttendanceReportScreenController.selectedUserId.value.toString()}');
      final response = await http.post(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final IsSuccess = data['isSuccess'] as bool;

        if (IsSuccess) {
          final regularizations = (data['result'] as List<dynamic>)
              .map((item) => Regularization.fromJson(item))
              .toList();
          regularizationList.assignAll(regularizations);
        } else {
          regularizationErorMessage.value = data['errorMessage'].isNotEmpty
              ? data['errorMessage'][0]
              : 'An error occurred.';
        }
      } else {
        // Handle other HTTP status codes
        regularizationErorMessage.value =
            'Failed to fetch regularization data. Please try again.';
      }
    } catch (e) {
      // Handle other errors
      regularizationErorMessage.value = 'Error: $e';
    }
  }

  void showRegularizationDetailsDialog(Regularization regularization) {
    Get.defaultDialog(
      title: 'Regularization Details',
      content: Container(
        width: 1000,
        // constraints: BoxConstraints(minWidth: 1500), // Adjust the maxWidth as needed
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              color: LightColor.lightBlue200,
              height: 1,
            ),
            // const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 7,
                child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        SizedBox(height: 16),
                        buildIconTextRow(
                          icon: Icons.calendar_today,
                          iconColor: LightColor.primary,
                          label: 'From Date',
                          text: regularization.fromDate.toString(),
                        ),
                        SizedBox(height: 16),
                        buildIconTextRow(
                          icon: Icons.calendar_today,
                          iconColor: LightColor.primary,
                          label: 'To Date',
                          text: regularization.toDate.toString(),
                        ),
                        SizedBox(height: 16),
                        buildIconTextRow(
                          icon: Icons.comment,
                          iconColor: LightColor.primary,
                          label: 'Remarks',
                          text: regularization.remarks,
                        ),
                        SizedBox(height: 16),
                        buildIconTextRow(
                          icon: Icons.check_circle,
                          iconColor: LightColor.primary,
                          label: 'Status',
                          text: regularization.regFullStatus,
                        ),
                        SizedBox(height: 16),
                        buildIconTextRow(
                          icon: Icons.person,
                          iconColor: LightColor.primary,
                          label: 'Reporting Manager',
                          text: regularization.reportingManager,
                        ),
                        SizedBox(height: 16),
                        buildIconTextRow(
                          icon: Icons.date_range,
                          iconColor: LightColor.primary,
                          label: 'Applied Date',
                          text: regularization.appliedDate.toString(),
                        ),
                        SizedBox(height: 16),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
      actions: _buildRegularizationActions(regularization),
    );
  }

  Widget buildIconTextRow({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String text,
  }) {
    return Row(
      children: [
        Icon(icon, color: iconColor),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(text),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> _buildRegularizationActions(Regularization regularization) {
    Color getButtonColor(String status) {
      switch (status) {
        case 'Pending':
          return Colors.orange.withOpacity(0.5);
        case 'Approved':
          return Colors.green.withOpacity(0.5);
        case 'Cancel':
          return Colors.red.withOpacity(0.5);
        case 'Reject':
          return Colors.red;
        case 'Hold':
          return Colors.yellow.withOpacity(0.5);
        default:
          return Colors.grey;
      }
    }

    Widget buildActionButton(
        String status, String buttonText, VoidCallback onPressed) {
      return Padding(
        padding: const EdgeInsets.all(0.0), // Adjust the padding as needed
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            primary: getButtonColor(status),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  8.0), // Adjust the border radius as needed
            ),
            minimumSize: Size(50, 30), // Adjust the button size as needed
          ),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 8, // Adjust the font size as needed
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      );
    }

    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (regularization.regFullStatus != 'Pending') ...[
            buildActionButton('Pending', 'Pending', () {
              // Handle Pending button click
              // You can call a function to handle the action here
              handleRegularizationAction('Pending', regularization);
            }),
            SizedBox(width: 5), // Adjust the space between buttons
          ],
          if (regularization.regFullStatus != 'Approved') ...[
            buildActionButton('Approved', 'Approved', () {
              // Handle Approved button click
              // You can call a function to handle the action here
              handleRegularizationAction('Approved', regularization);
            }),
            SizedBox(width: 5), // Adjust the space between buttons
          ],
          if (regularization.regFullStatus != 'Cancel') ...[
            buildActionButton('Cancel', 'Cancel', () {
              // Handle Cancel button click
              // You can call a function to handle the action here
              handleRegularizationAction('Cancel', regularization);
            }),
            SizedBox(width: 5), // Adjust the space between buttons
          ],
          if (regularization.regFullStatus != 'Reject') ...[
            buildActionButton('Reject', 'Reject', () {
              // Handle Reject button click
              // You can call a function to handle the action here
              handleRegularizationAction('Reject', regularization);
            }),
            SizedBox(width: 5), // Adjust the space between buttons
          ],
          if (regularization.regFullStatus != 'Hold') ...[
            buildActionButton('Hold', 'Hold', () {
              // Handle Hold button click
              // You can call a function to handle the action here
              handleRegularizationAction('Hold', regularization);
            }),
          ],
        ],
      ),
    ];
  }

  void handleRegularizationAction(
      String regStatus, Regularization regularization) async {
    try {
      Get.dialog(
        const CustomLoadingDialog(message: 'Please wait ...'),
        barrierDismissible: false,
      );
      final response =
          await updateRegularizationDetails(regStatus, regularization);

      if (response['isSuccess']) {
        Get.back();
        Get.back();
        fetchRegularizationData();
      } else {
        Get.snackbar('Error', response['errorMessage'][0],
            snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while processing your request.',
          snackPosition: SnackPosition.TOP);
    }
  }

  Future<Map<String, dynamic>> updateRegularizationDetails(
      String regStatus, Regularization regularization) async {
    DateTime now = DateTime.now().toLocal();
    String formattedDate =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(now);

    String fromDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
        .format(regularization.fromDate);
    String toDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
        .format(regularization.toDate);

    final url = Uri.parse(
        'http://3.111.234.227/api/Regularizations/UpdateRegularizationDetails');

    print(formattedDate);
    final Map<String, dynamic> requestBody = {
      "reglarId": regularization.reglarId,
      "userId": employeeAttendanceReportScreenController.selectedUserId.value,
      "reportingManagerId": regularization.reportingManagerId,
      "remarks": regularization.remarks,
      "location": '',
      "regStaus": getRegStatusValue(regStatus),
      "reportingManagerRemarks": 'Congratulations anonymous',
      "createdBy": box.read("firstName"),
      "createdOn": formattedDate,
      "modifiedBy": box.read("firstName"),
      "modifiedOn": formattedDate,
      "fromDate": fromDate,
      "toDate": toDate,
    };

    final String jsonBody = jsonEncode(requestBody);

    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final response = await http.post(
      url,
      headers: headers,
      body: jsonBody,
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to update regularization details.');
    }
  }

  int getRegStatusValue(String regStatus) {
    switch (regStatus) {
      case 'Pending':
        return 1;
      case 'Approved':
        return 2;
      case 'Cancel':
        return 3;
      case 'Hold':
        return 4;
      case 'Reject':
        return 5;
      default:
        return 0; // Default value if regStatus is unknown
    }
  }

/*
  List<Widget> _buildRegularizationActions(Regularization regularization) {
    if (regularization.regFullStatus == 'Pending') {
      return [
        ElevatedButton(
          onPressed: () {
            // Handle accept button click
            // You can call a function to handle the acceptance logic here
            Get.back(); // Close the dialog
          },
          style: ElevatedButton.styleFrom(primary: Colors.green),
          child: Text('Accept'),
        ),
        ElevatedButton(
          onPressed: () {
            // Handle reject button click
            // You can call a function to handle the rejection logic here
            Get.back(); // Close the dialog
          },
          style: ElevatedButton.styleFrom(primary: Colors.red),
          child: Text('Reject'),
        ),
      ];
    } else {
      // Display a close button for other statuses
     return[SizedBox.shrink()] ;
    */
/*  return [
        ElevatedButton(
          onPressed: () {
            Get.back(); // Close the dialog
          },
          style: ElevatedButton.styleFrom(primary: Colors.blue),
          child: Text('Close'),
        ),
      ];*/ /*

    }
  }
*/

  // Function to open the date picker
  void openDatePicker(BuildContext context) async {
    final selectedDateValue = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor:
                LightColor.primary, // Change this to your desired color
          ),
          child: child!,
        );
      },
    );

    if (selectedDateValue != null) {
      selectedDate.value = selectedDateValue;
    }
  }
}
