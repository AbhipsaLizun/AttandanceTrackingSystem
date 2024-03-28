
import 'package:attendance_system/app/modules/Employee/Report/Controller/report_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../shared/constants/color_constants.dart';
import '../../ColorsGallary/color_section.dart';
import '../../Commons/screensize.dart';
import '../../Commons/text_string.dart';
import 'circular_chart.dart';
import 'employee_data.dart';

class ReportScreen extends StatelessWidget {
  ReportScreen({super.key});

  static String? selectedPassDate;

  final ReportController controller = Get.put(ReportController());

  String hour = "00:00";
  String time = "09:30 AM";


  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: Stack(
                children: [
                  SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: SvgPicture.asset(
                      'assets/images/svg/ScreenBG_White.svg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(10),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 10, top: 10),
                            child: Text(
                              "Attendance",
                              style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: ColorSection.textColorBlack,
                                  letterSpacing: 0.5),
                            ),
                          ),

                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Present
                              attendanceCard(
                                  context: context,
                                  tittle: 'Present',
                                  total:
                                  controller.presentCount.value == null  ? "0" :
                                  controller.presentCount.value == 0 ? "0" : controller.presentCount.value.toString(),
                                  //controller.presentCount.value.toString() : "11",
                                      // "10",
                                  cardColor: Colors.green.withOpacity(0.25),
                                  texColor: const Color(0xFF02570B)),
                              // Absent
                              attendanceCard(
                                  context: context,
                                  tittle: 'Absent',
                                  total:
                                  controller.absentCount.value == null  ? "0" :
                                  controller.absentCount.value == 0 ? "0" : controller.absentCount.value.toString(),
                                    //  "2",
                                  cardColor: Colors.redAccent.withOpacity(0.25),
                                  texColor: const Color(0xFF760101)),
                              // Leave
                              attendanceCard(
                                  context: context,
                                  tittle: 'Leave',
                                  total:
                                  controller.absentCount.value == null  ? "0" :
                                  controller.absentCount.value == 0 ? "0" : controller.absentCount.value.toString(),
                                      // "1",
                                  cardColor: Colors.yellow.withOpacity(0.25),
                                  texColor: const Color(0xFF788200))
                            ],
                          ),

                          SizedBox(
                            height: AppDimension.height(context) * 0.27,
                            child: CircularChartView(),
                          ),

                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            // height: 100,
                            padding: const EdgeInsets.all(05),
                            decoration: BoxDecoration(
                              color: LightColor.primary.withOpacity(0.22),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, top: 10, bottom: 10),
                                  child: Text(
                                    "Regularization Requests",
                                    style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: ColorSection.textColorBlack,
                                        letterSpacing: 0.5),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    regularizationCard(
                                        context: context,
                                        tittle: "Approved",
                                        texColor: Colors.black38,
                                        total: "2",
                                        cardColor: LightColor.whitecolor),
                                    regularizationCard(
                                        context: context,
                                        tittle: "Pending",
                                        texColor: Colors.black38,
                                        total: "1",
                                        cardColor: LightColor.whitecolor)
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                )
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: 20,
                          ),
                          //Punching Details.................//
                          Card(
                            elevation: 5,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: ColorSection.containerbgColor,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        TextString.repStatusText,
                                        style: GoogleFonts.poppins(
                                            color: ColorSection.textColorBlack,
                                            fontSize: 16),
                                      ),
                                      SizedBox(
                                        height: AppDimension.height(context) *
                                            0.002,
                                      ),
                                      Text(
                                        "$hour Hrs",
                                        style: GoogleFonts.poppins(
                                            color: ColorSection.primaryColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      ),
                                      SizedBox(
                                        height: AppDimension.height(context) *
                                            0.002,
                                      ),
                                      Text(
                                        "Punch in at $time",
                                        style: GoogleFonts.poppins(
                                            color: ColorSection.textColorBlack,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (controller.text.value == "") {
                                        controller.calendarController
                                            .selectedDate = DateTime.now();
                                        print("NOw");
                                        print(controller
                                            .calendarController.selectedDate);
                                      } else {
                                        print(
                                            "Selected${controller.calendarController.selectedDate}");
                                      }
                                      selectedPassDate = controller.calendarController.selectedDate.toString();

                                      // final Map<String, dynamic> selDate = {
                                      //   'selectedDate': controller
                                      //       .calendarController.selectedDate,
                                      // };
                                      Get.toNamed("/MonthlyAttendanceReport",

                                          //arguments: selDate
                                      );

                                      // ReportScreen.selectedDate = controller
                                      //     .calendarController.selectedDate
                                      //     .toString();
                                     // Get.toNamed("/MonthlyAttendanceReport");
                                    },
                                    child: Card(
                                      elevation: 5,
                                      shadowColor: Colors.grey,
                                      color: ColorSection.containerbgColor,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          TextString.repViewDetail,
                                          style: GoogleFonts.poppins(
                                              color: ColorSection.primaryColor,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),

                          SizedBox(
                            height: AppDimension.height(context) * 0.02,
                          ),

                          //CALENDAR..........................//
                          Container(
                            width: AppDimension.width(context),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 3,
                                    blurRadius: 7,
                                    offset: const Offset(0,
                                        3), // changes the position of the shadow
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.symmetric(horizontal: 0),
                            //margin: const EdgeInsets.fromLTRB(12, 0, 12, 10),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SfCalendar(
                                controller: controller.calendarController,

                                onTap: controller.calendarTapped,
                                cellEndPadding: 5,
                                //dataSource: MeetingDataSource(getDataSource()),
                                onSelectionChanged: (value) {},
                                selectionDecoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    // borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                        color: ColorSection.primaryColor)
                                    // color: Colors.yellow
                                    ),
                                backgroundColor: Colors.white,

                                todayHighlightColor: ColorSection.primaryColor,

                                headerHeight: 45,
                                // headerDateFormat: ,
                                showNavigationArrow: true,
                                showDatePickerButton: true,
                                headerStyle: const CalendarHeaderStyle(
                                    textStyle: TextStyle(
                                        color: Colors.black, fontSize: 16)),
                                cellBorderColor: Colors.grey[200],
                                view: CalendarView.month,
                                monthViewSettings: const MonthViewSettings(
                                    appointmentDisplayMode:
                                        MonthAppointmentDisplayMode
                                            .appointment),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )),
      ),
    );
  }

//    List<Meeting> getDataSource() {
//      final List<Meeting> meetings = <Meeting>[];
//      final DateTime today = DateTime.parse("2023-11-07");
//      final DateTime startTime =
//      DateTime(today.year, today.month, today.day, 9, 0, 0);
//      final DateTime endTime = startTime.add(const Duration(hours: 2));
//      meetings.add(Meeting(
//          'Conference', startTime, endTime, const Color(0xFFB00318), false));
//      return meetings;
//    }
//
// }

// class MeetingDataSource extends CalendarDataSource {
//   MeetingDataSource(List<Meeting> source) {
//     appointments = source;
//   }
//
//   @override
//   DateTime getStartTime(int index) {
//     return appointments![index].from;
//   }
//
//   @override
//   DateTime getEndTime(int index) {
//     return appointments![index].to;
//   }
//
//   @override
//   String getSubject(int index) {
//     return appointments![index].eventName;
//   }
//
//   @override
//   Color getColor(int index) {
//     return appointments![index].background;
//   }
//
//   @override
//   bool isAllDay(int index) {
//     return appointments![index].isAllDay;
//   }
// }

// class Meeting {
//   Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);
//
//   String eventName;
//   DateTime from;
//   DateTime to;
//   Color background;
//   bool isAllDay;
// }

  Card attendanceCard(
      {required BuildContext context,
      required String tittle,
      required String total,
      required Color cardColor,
      required Color texColor}) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
        //height: 30,
        width: MediaQuery.of(context).size.width * 0.27,
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: cardColor,
          //color: Colors.amber,
        ),
        child: EmployeeData(
          count: total,
          category: tittle,
          catClr: Colors.black,
          countClr: texColor,
        ),
      ),
    );
  }

  Card regularizationCard(
      {required BuildContext context,
      required String tittle,
      required String total,
      required Color cardColor,
      required Color texColor}) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(05.0)),
      child: Container(
        //height: 30,
        width: (MediaQuery.of(context).size.width * 0.425),
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: cardColor,
          //color: Colors.amber,
        ),
        child: EmployeeData(
          count: total,
          category: tittle,
          catClr: Colors.black,
          countClr: texColor,
        ),
      ),
    );
  }
}
