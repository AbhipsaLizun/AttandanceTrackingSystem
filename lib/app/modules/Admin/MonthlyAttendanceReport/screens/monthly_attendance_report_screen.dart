import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../shared/constants/app_text_styles.dart';
import '../../../../shared/constants/color_constants.dart';
import '../../EmployeesAttendanceReport/controllers/employee_attendance_report_screen_controller.dart';
import '../controllers/monthly_attendance_report_screen_controller.dart';
import '../../TodayAttendanceReport/models/attendance_data.dart';

class MonthlyAttendanceReportScreen extends StatelessWidget {

  final MonthlyAttendanceReportScreenController _calendarController =
      Get.put(MonthlyAttendanceReportScreenController());
  final EmployeeAttendanceReportScreenController
      employeeAttendanceReportScreenController =
      Get.find<EmployeeAttendanceReportScreenController>();

  MonthlyAttendanceReportScreen({super.key}) {
    // Initialize the data for the current date when the page is loaded
    _calendarController.onDaySelected(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    double cWidth = MediaQuery.of(context).size.width * 0.4;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Monthly Report"),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(
            'assets/images/svg/ScreenBG_White.svg',
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: cWidth,
                      decoration: const BoxDecoration(
                        color: LightColor.primary,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
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
                      onTap: () {},
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "400/378",
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Obx(
                  () {
                    final selectedDay = _calendarController.selectedDay.value;
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 10,
                      child: TableCalendar(
                        calendarFormat: _calendarController.calendarFormat,
                        focusedDay: _calendarController.focusedDay,
                        firstDay: DateTime.utc(2000),
                        lastDay: DateTime.utc(2030),
                        selectedDayPredicate: (day) {
                          return isSameDay(selectedDay, day);
                        },
                        onDaySelected: (selectedDay, focusedDay) {
                          _calendarController.onDaySelected(selectedDay);
                        },
                        calendarStyle: const CalendarStyle(
                          selectedDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: LightColor.gray400,
                          ),
                          todayDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: LightColor.primary,
                          ),
                        ),
                        headerStyle: const HeaderStyle(
                          formatButtonVisible: false,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "Report",
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  width: 30,
                  color: LightColor.primary,
                  height: 1,
                ),
                Obx(() {
                  if (_calendarController.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: LightColor.primary,
                      ),
                    );
                  } else if (_calendarController.errorMessage.isNotEmpty) {
                    // If errorMessage is not empty, show the error message
                    return Center(
                      child: Text(
                        _calendarController.errorMessage.value,
                        style: AppTextStyles.customTextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: _calendarController.reportList.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {

                          final inDate = DateFormat('yyyy-MM-dd')
                              .format(_calendarController
                              .reportList[index].inDateTime);
                          return Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    inDate,
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'In',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        DateFormat('HH:mm').format(_calendarController
                                            .reportList[index].timeIn),
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: LightColor.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Out',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        DateFormat('HH:mm').format(_calendarController
                                            .reportList[index].timeOut),
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: LightColor.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
/*                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Checked In',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        _calendarController
                                            .reportList[index].timeIn,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: LightColor.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Checked Out',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        _calendarController
                                            .reportList[index].timeOut,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: LightColor.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Total Time',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        "1",
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: LightColor.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )*/
                            ),
                          );
                        },
                      ),
                    );
                  }
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
