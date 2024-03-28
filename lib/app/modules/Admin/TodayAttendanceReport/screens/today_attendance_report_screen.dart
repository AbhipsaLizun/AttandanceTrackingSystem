import 'package:attendance_system/app/modules/Admin/EmployeesAttendanceReport/controllers/employee_attendance_report_screen_controller.dart';
import 'package:attendance_system/app/modules/Admin/TodayAttendanceReport/models/attendance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../shared/constants/color_constants.dart';
import '../../../../shared/widgets/no_recor_widget.dart';
import '../controllers/today_attendance_report_screen_controller.dart';

class TodayAttendanceReportScreen extends StatelessWidget {

  final TodayAttendanceReportScreenController
      todayAttendanceReportScreenController =
      Get.put(TodayAttendanceReportScreenController());

  final EmployeeAttendanceReportScreenController
      employeeAttendanceReportScreenController =
      Get.find<EmployeeAttendanceReportScreenController>();

  TodayAttendanceReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double cWidth = MediaQuery.of(context).size.width * 0.4;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Today"),
        //title: Obx(() => Text(_controller.selectedLocation.value)),
      ),
      body: Stack(
        children: [
          SvgPicture.asset(
            'assets/images/svg/ScreenBG_White.svg',
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        // height: 30,
                        width: cWidth,
                        decoration: const BoxDecoration(
                            color: LightColor.primary, // Customize the color
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        padding: const EdgeInsets.all(8),
                        child: Center(
                          child: Text(
                            employeeAttendanceReportScreenController
                                .selectedUserName.value,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          /*todayAttendanceReportScreenController
                              .openDatePicker(context);*/
                        },
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(
                                  () => Text(
                                    '${todayAttendanceReportScreenController.selectedDate.value.day}-${todayAttendanceReportScreenController.selectedDate.value.month}-${todayAttendanceReportScreenController.selectedDate.value.year}',
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                /*Text(
                                  "30-09-2023",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600),
                                ),*/
                                const SizedBox(
                                  width: 10,
                                ),
                                const Center(
                                  child: Icon(
                                    Icons.calendar_month,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      //SizedBox(height: 15), // Add spacing between cards
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Attendance Records',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Container(
                              width: 30,
                              color: LightColor.primary,
                              height: 1,
                            ),
                            const SizedBox(height: 8),
                            Obx(() {
                              if (todayAttendanceReportScreenController
                                  .errorMessage.isNotEmpty) {
                                // If errorMessage is not empty, show the error message
                                return Center(
                                  child: NoRecordWidget(
                                    errorMessage:
                                        todayAttendanceReportScreenController
                                            .errorMessage.value,
                                  ),
                                );
                              } else {
                                if (todayAttendanceReportScreenController
                                    .attendanceList.isEmpty) {
                                  // You can show a loading indicator here if needed
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  //  getTotalMonthlyHours();
                                  final totalDuration = calculateTotalTime(
                                      todayAttendanceReportScreenController
                                          .attendanceList);
                                  final totalHours = totalDuration.inHours;
                                  final totalMinutes =
                                      totalDuration.inMinutes.remainder(60);
                                  return Column(
                                    children: [
                                      Container(
                                        height: 300,
                                        child: ListView.builder(
                                          itemCount:
                                              todayAttendanceReportScreenController
                                                  .attendanceList.length,
                                          shrinkWrap: true,
                                          physics: ScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          itemBuilder: (context, index) {
                                            final attendance =
                                                todayAttendanceReportScreenController
                                                    .attendanceList[index];

                                            final checkedInTime =
                                                attendance.timeIn;
                                            final checkedOutTime =
                                                attendance.timeOut;

/*
                                        // Calculate the total time difference in hours and minutes
                                        final totalHoursAndMinutes =
                                        calculateTotalTime(checkedInTime, checkedOutTime);
*/

                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 16.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        'Checked In',
                                                        style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Text(
                                                        checkedInTime,
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                          color: LightColor
                                                              .primary,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        'Checked Out',
                                                        style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Text(
                                                        checkedOutTime,
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                          color: LightColor
                                                              .primary,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        'Total Time',
                                                        style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Text(
                                                        attendance.hours,
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                          color: LightColor
                                                              .primary,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Total Hour :",
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15,
                                                color: LightColor.textcolor),
                                          ),
                                          Text(
                                            " $totalHours:${totalMinutes.toString().padLeft(2, '0')} Hr",
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 15,
                                                color: LightColor.primary),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                }
                              }
                            })
                          ],
                        ),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Regularization',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: 30,
                            color: LightColor.primary,
                            height: 1,
                          ),
                          const SizedBox(height: 16),
                          Obx(() {
                            if (todayAttendanceReportScreenController
                                .regularizationErorMessage.isNotEmpty) {
                              return Center(
                                child: NoRecordWidget(
                                  errorMessage:
                                      todayAttendanceReportScreenController
                                          .regularizationErorMessage.value,
                                ),
                              );
                            } else {
                              if (todayAttendanceReportScreenController
                                  .regularizationList.isEmpty) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else {
                                return ListView.separated(
                                  itemCount:
                                      todayAttendanceReportScreenController
                                          .regularizationList.length,
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return Divider(
                                      color: Colors.grey,
                                      thickness: 1,
                                    );
                                  },
                                  itemBuilder: (context, index) {
                                    final regularization =
                                        todayAttendanceReportScreenController
                                            .regularizationList[index];
                                    final isPending =
                                        regularization.regStatus == 'Pending';
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 8),
                                        Text(
                                          '${DateFormat('dd-MM-yyyy').format(regularization.fromDate)} to ${DateFormat('dd-MM-yyyy').format(regularization.toDate)}',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Remarks: ${regularization.remarks}',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                todayAttendanceReportScreenController.showRegularizationDetailsDialog(regularization);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                primary: getColorForRegStatus(regularization.regFullStatus),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.visibility),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    regularization.regFullStatus,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                      ],
                                    );
                                  },
                                );
                              }
                            }
                          }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Color getColorForRegStatus(String regFullStatus) {
    switch (regFullStatus) {
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


  getTotalMonthlyHours() {
// Get the current date
    DateTime currentDate = DateTime.now();

// Get the number of days in the current month
    int daysInMonth = DateTime(currentDate.year, currentDate.month + 1, 0).day;

    int totalHours = daysInMonth * 9;
// Print the result
    print('The number of days in the current month is $daysInMonth');
    print('The number of Total Hours in the current month is $totalHours');
  }

  Duration calculateTotalTime(List<Attendance> attendanceList) {
    Duration totalDuration = Duration.zero;

    for (final attendance in attendanceList) {
      final timeComponents = attendance.hours.split(':');
      if (timeComponents.length == 2) {
        final hours = int.parse(timeComponents[0]);
        final minutes = int.parse(timeComponents[1]);
        totalDuration += Duration(hours: hours, minutes: minutes);
      }
    }

    return totalDuration;
  }
}
