import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../shared/constants/color_constants.dart';
import '../../../../shared/widgets/no_recor_widget.dart';
import '../../EmployeesAttendanceReport/controllers/employee_attendance_report_screen_controller.dart';
import '../controllers/weekly_attendance_report_screen_controller.dart';

class WeeklyAttendanceReportScreen extends StatelessWidget {

  final WeeklyAttendanceReportScreenController
      weeklyAttendanceReportScreenController =
      Get.put(WeeklyAttendanceReportScreenController());
  final EmployeeAttendanceReportScreenController
  employeeAttendanceReportScreenController =
  Get.find<EmployeeAttendanceReportScreenController>();

  WeeklyAttendanceReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double cWidth = MediaQuery.of(context).size.width * 0.4;
    final DateTime now = DateTime.now();
    final currentMonthDate = DateFormat('MMMM y').format(now);

    if (weeklyAttendanceReportScreenController.selectedDate == null) {
      weeklyAttendanceReportScreenController.selectDate(now.day - 1);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Weekly Report"),
      ),
      body: Stack(
        children: [
          SvgPicture.asset(
            'assets/images/svg/ScreenBG_White.svg',
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: cWidth,
                      decoration: const BoxDecoration(
                        color: LightColor.primary, // Customize the color
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      padding: const EdgeInsets.all(8),
                      child:  Center(
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
                        // Simulate loading data when the date is changed
                      //  weeklyAttendanceReportScreenController.loadData();
                      },
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
                const SizedBox(
                  height: 15,
                ),
                Text(
                  currentMonthDate,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: SingleChildScrollView(
                    controller: weeklyAttendanceReportScreenController.dateScrollController, // Set the ScrollController
                    scrollDirection: Axis.horizontal,
                    physics: const ClampingScrollPhysics(),
                    child: Row(
                      children: List.generate(
                        weeklyAttendanceReportScreenController
                            .lastDayOfMonth.day,
                        (index) {
                          final currentDate =
                              DateTime(now.year, now.month, index + 1);
                          final dayName =
                              DateFormat('EEEE').format(currentDate);
                          return Padding(
                            padding: EdgeInsets.only(
                              left: index == 0 ? 16.0 : 0.0,
                              right: 16.0,
                            ),
                            child: GestureDetector(
                              onTap: () =>
                                  weeklyAttendanceReportScreenController
                                      .selectDate(index),
                              child: Obx(() {
                                return Container(
                                  decoration: BoxDecoration(
                                    color:
                                        weeklyAttendanceReportScreenController
                                                    .selectedIndex.value ==
                                                index
                                            ? LightColor.primary
                                            : Colors.transparent,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 42.0,
                                        width: 42.0,
                                        alignment: Alignment.center,
                                        child: Text(
                                          dayName.substring(0, 3),
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color:
                                                weeklyAttendanceReportScreenController
                                                            .selectedIndex
                                                            .value ==
                                                        index
                                                    ? Colors.white
                                                    : Colors.black54,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8.0),
                                      Text(
                                        "${index + 1}",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color:
                                              weeklyAttendanceReportScreenController
                                                          .selectedIndex
                                                          .value ==
                                                      index
                                                  ? Colors.white
                                                  : Colors.black54,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ),
                          );
                        },
                      ),
                    ),

                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: Card(
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
                            'Report',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
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
                            if (weeklyAttendanceReportScreenController
                                .isLoading.value) {
                              // If isLoading is true, show a circular loading indicator
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (weeklyAttendanceReportScreenController
                                .errorMessage.isNotEmpty) {
                              // If errorMessage is not empty, show the error message
                              return Center(
                                child: NoRecordWidget(
                                  errorMessage:
                                  weeklyAttendanceReportScreenController.errorMessage.value,
                                ),
                              );
                            } else {
                              // Display the ListView.builder data
                              return Expanded(
                                child: ListView.builder(
                                  itemCount:
                                      weeklyAttendanceReportScreenController
                                          .attendanceHistoryList.length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  physics: const ScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final history =
                                        weeklyAttendanceReportScreenController
                                            .attendanceHistoryList[index];
                                    final checkInTime = history.timeIn;
                                    final checkOutTime = history.timeOut;
                                    //  final inDate = history.inDateTime;
                                    final inDate = DateFormat('yyyy-MM-dd')
                                        .format(history.inDateTime);

                                    return Padding(
                                      padding: const EdgeInsets.only(top: 16.0),
                                      child: Column(
                                        children: [
                                          Row(
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
                                                    DateFormat('HH:mm').format(history.timeIn),
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
                                                    'Check Out',
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Text(
                                                    DateFormat('HH:mm').format(history.timeOut),
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                      color: LightColor.primary,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );
                            }
                          }),
/*
                          Obx(() {
                            if (weeklyAttendanceReportScreenController
                                .errorMessage.isNotEmpty) {
                              // If errorMessage is not empty, show the error message
                              return Center(
                                child: Text(
                                  weeklyAttendanceReportScreenController
                                      .errorMessage.value,
                                  style: AppTextStyles.customTextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            }else{
                              if (weeklyAttendanceReportScreenController
                                  .attendanceHistoryList.isEmpty) {
                                // If the employees list is empty, show a loading indicator
                                return Center(child: CircularProgressIndicator());
                              } else {
                                // Display the ListView.builder data
                                return ListView.builder(
                                  itemCount:
                                  weeklyAttendanceReportScreenController.attendanceHistoryList.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    final history =
                                    weeklyAttendanceReportScreenController.attendanceHistoryList[index];
                                    final checkInTime = history.timeIn;
                                    final checkOutTime = history.timeOut;
                                    //  final inDate = history.inDateTime;
                                    final inDate = DateFormat('yyyy-MM-dd').format(history.inDateTime);

                                    return Padding(
                                      padding: const EdgeInsets.only(top: 16.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                inDate,
                                                style: const TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
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
                                                    checkInTime,
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
                                                    'Check Out',
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Text(
                                                    checkOutTime,
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                      color: LightColor.primary,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }

                            }
                          })
*/
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
