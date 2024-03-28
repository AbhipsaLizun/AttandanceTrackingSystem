import 'package:attendance_system/app/modules/Employee/Regularization/screens/apply_reg_screen.dart';
import 'package:attendance_system/app/shared/constants/color_constants.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../../demo.dart';
import '../../../../shared/widgets/no_recor_widget.dart';
import '../../ColorsGallary/color_section.dart';
import '../../Commons/screensize.dart';
import '../../Commons/text_string.dart';
import '../../Regularization/screens/custom_dropdown.dart';
import '../model/monthly_attendance_response.dart';
import '../../Report/screens/report_screen.dart';
import '../controller/monthly_att_controller.dart';

class MonthlyAttendanceReport extends StatelessWidget {
  static String? datetpass;
  static String? totalHrpass;

  const MonthlyAttendanceReport({super.key});

  @override
  Widget build(BuildContext context) {
    final MonthlyAttendanceController controller =
        Get.put(MonthlyAttendanceController());

    final DateTime now = DateTime.now();
    controller.tag.value = "Daily";

    return Obx(
      () => Scaffold(
        backgroundColor: ColorConstants.scaffoldBackground,
        appBar: AppBar(
          backgroundColor: ColorSection.primaryColor,
          iconTheme: IconThemeData(color: ColorSection.textColorWhite),
        ),
        body: SafeArea(
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
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              // padding: const EdgeInsets.all(12),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 15, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${controller.tag.value} ${TextString.attendanceTitle}",
                        style: GoogleFonts.poppins(
                            color: ColorSection.primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              controller.date.value.toString(),
                              style: GoogleFonts.poppins(
                                  color: ColorSection.textColorBlack,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),

                          //...............Month Week Dropdown..................//

                          Expanded(
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8)),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  isExpanded: true,
                                  buttonPadding:
                                      const EdgeInsets.only(left: 5, right: 5),
                                  items: controller.calendarList.map((list) {
                                    return DropdownMenuItem(
                                      value: list.toString(),
                                      child: Text(
                                        list.toString(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? value) {
                                    controller.selectedType.value = value!;
                                    if (value == "Daily") {
                                      controller.monthContainerView.value = false;
                                      controller.dailyContainerView.value = true;
                                      controller.weekContainerView.value = false;
                                      controller.tag.value = "Daily";
                                      controller.fetchDailyAttendanceList(
                                          controller.currentDate);
                                    } else if (value == "Month") {
                                      controller.monthContainerView.value = true;
                                      controller.dailyContainerView.value = false;
                                      controller.weekContainerView.value = false;
                                      controller.tag.value = "Monthly";
                                      controller
                                          .fetchMonthlyWeeklyAttendanceReport();
                                    } else if (value == "Week") {
                                      controller.monthContainerView.value = false;
                                      controller.dailyContainerView.value = false;
                                      controller.weekContainerView.value = true;
                                      controller.tag.value = "Weekly";
                                      controller
                                          .fetchMonthlyWeeklyAttendanceReport();
                                    } else {
                                      controller.monthContainerView.value = false;
                                      controller.dailyContainerView.value = true;
                                      controller.weekContainerView.value = false;
                                    }
                                  },
                                  hint: Row(
                                    children: [
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Expanded(
                                        child: Obx(
                                          () => Text(
                                            controller.selectedType.toString(),
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: AppDimension.height(context) * 0.02,
                      ),

                      //.........Daily View...................//
                      Visibility(
                        visible: controller.dailyContainerView.value,
                        child: Obx(
                          () => ConstrainedBox(
                            constraints: const BoxConstraints(minHeight: 480),
                            child: Column(
                              children: [
                                EasyDateTimeLine(
                                  initialDate: controller.currentDate,
                                  onDateChange: (selectedDate) {
                                    print("SEC...$selectedDate");
                                    Future.delayed(const Duration(seconds: 2),
                                        () {
                                      controller.isLoading.value = true;
                                    });
                                    controller.attendanceResult.value.clear();
                                    controller
                                        .fetchDailyAttendanceList(selectedDate);
                                  },
                                  activeColor: const Color(0xff85A389),
                                  headerProps: const EasyHeaderProps(
                                    showMonthPicker: false,
                                    //monthPickerType: MonthPickerType.dropDown,
                                    selectedDateFormat:
                                        SelectedDateFormat.monthOnly,
                                  ),
                                  dayProps: const EasyDayProps(
                                    height: 56.0,
                                    width: 56.0,
                                    dayStructure: DayStructure.dayStrDayNum,
                                    activeDayStyle: DayStyle(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(30)),
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Color(0xff37C3C4),
                                            Color(0xff37C3C4),
                                          ],
                                        ),
                                      ),
                                    ),
                                    inactiveDayStyle: DayStyle(
                                      //borderRadius: 48.0,
                                      monthStrStyle:
                                          TextStyle(color: Colors.blue),
                                      dayNumStyle: TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ),
                                ),
                                //.........DAILY................
                                ConstrainedBox(
                                  constraints:
                                      const BoxConstraints(minHeight: 480),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.only(
                                        bottom: 15, top: 15),
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
                                        //border: Border.all(),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Padding(
                                        padding: const EdgeInsets.only(bottom: 5),
                                        child: createDataTable(controller, context)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      //.....Month View............
                      Visibility(
                        visible: controller.monthContainerView.value,
                        //controller.monthContainerView.value,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            minHeight: 500,
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(bottom: 15),
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
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 5,left: 8, right: 8),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  SizedBox(
                                    child: createMonthlyTableList(
                                        controller, context),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      //.....Week View............
                      Visibility(
                        visible: controller.weekContainerView.value,
                        //controller.monthContainerView.value,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            minHeight: 500,
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(bottom: 15),
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
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  SizedBox(
                                    child: createWeeklyTableList(
                                        controller, context),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }

  createDataTable(MonthlyAttendanceController controller, BuildContext context) {
    print(controller.errorMsg.value.toString());

    if (controller.errorMsg.value.isNotEmpty) {
      return Center(
          child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 480),
              child: Center(
                  child: NoRecordWidget(
                errorMessage: 'No Record Found',
              )
                  //Text("No records found ")
                  )));
    } else {
      if (controller.attendanceResult.isEmpty) {
        //  controller.isLoading.value = false;
        return const SizedBox(
            height: 200,
            child: Center(
                child: Padding(
              padding: EdgeInsets.all(20.0),
              child: CircularProgressIndicator(),
            )));
      } else {
        return DataTable(
          // border: TableBorder.all(width: 1),
          columnSpacing: 60,
          columns: controller.createColumns(),
          //  rows: controller.createRows(),
          rows: List.generate(
            controller.attendanceResult.length,
            (index) {
              var data = controller.attendanceResult[index];
              var punchIn = controller.dailyTimeFormat(data.timeIn);
              var punchOut = controller.dailyTimeFormat(data.timeOut);
              print("Punch......$punchIn");
              print("PunchOut......${data.timeOut}");
              return DataRow(cells: [
                DataCell(
                  Text(
                    punchIn,
                    // data.checkIn.toString(),
                    style:  TextStyle(fontSize: AppDimension.width(context)* 0.035),
                  ),
                ),
                DataCell(
                  Center(
                    child: Text(
                      punchOut,
                      //data.checkOut.toString(),
                      style:  TextStyle(fontSize: AppDimension.width(context)* 0.035),
                    ),
                  ),
                ),
                DataCell(
                  Center(
                    child: Text(
                      //"",
                      data.hours,
                      style:  TextStyle(fontSize: AppDimension.width(context)* 0.035),
                    ),
                  ),
                ),
              ]);
            },
          ).toList(),
          showBottomBorder: true,
        );
      }
    }
  }

  createMonthlyTableList(
      MonthlyAttendanceController controller, BuildContext context) {
    if (controller.errorMsg.value.isNotEmpty) {
      return Center(
          child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 480),
              child: Center(
                  child: NoRecordWidget(
                errorMessage: 'No Record Found',
              )
                  // Text("No records found ")
                  )));
    } else {
      if (controller.monthlyAttendanceResult.isEmpty) {
        return const SizedBox(
            height: 200,
            child: Center(
                child: Padding(
              padding: EdgeInsets.all(20.0),
              child: CircularProgressIndicator(),
            )));
      } else {
        return SingleChildScrollView(
          controller: controller.scrollController,
          scrollDirection: Axis.horizontal,
          child: DataTable(
            horizontalMargin: 0,
            showCheckboxColumn: false,
            dataRowHeight: 50,
            // border: TableBorder.all(width: 1),
            columnSpacing: 10,
            columns: controller.createMonthColumns(),
            //  rows: controller.createRows(),
            rows:
            List.generate(
              controller.monthlyAttendanceResult.length,
              (index) {
                var data = controller.monthlyAttendanceResult[index];
                print("TimeIN...${data.present}");
                var punchIn = controller.converTimeFormat(data.timeIn);
                var punchOut = controller.converTimeFormat(data.timeOut);
                var inDate =
                    controller.modifiedDate(data.inDateTime.toString());
                var inMonth =
                    controller.modifiedMonth(data.inDateTime.toString());
                var totalHr =
                    controller.calculateTotalHour(data.timeIn, data.timeOut);
                print("");

                return DataRow(
                    onSelectChanged: (value) {
                      MonthlyAttendanceReport.datetpass = data.inDateTime.toString();
                   totalHrpass = totalHr.toString();

                      Get.to(() => ApplyRegularization());
                      //Get.to(() => DemoScreen());
                    },
                    cells: [
                      DataCell(
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Container(
                            width: AppDimension.width(context) * 0.13,
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                color: ColorSection.primaryColor,
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    //"04",
                                    inDate,
                                    // data.checkIn.toString(),
                                    style:  TextStyle(
                                        color: Colors.white,
                                        fontSize: AppDimension.width(context)* 0.038,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    //"04",
                                    inMonth,
                                    // data.checkIn.toString(),
                                    style:  TextStyle(
                                        color: Colors.white,
                                        fontSize: AppDimension.width(context)* 0.037,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        Center(
                          child: Icon(
                            data.present == "true"
                                ? Icons.check_circle
                                : Icons.cancel,
                            color: data.present == "true"
                                ? Colors.green
                                : Colors.red,
                            size: 22,
                          ),
                        ),
                      ),
                      DataCell(
                        Center(
                          child: Text(
                            punchIn,
                            style: TextStyle(
                                fontSize: AppDimension.width(context)* 0.035,
                                fontWeight: FontWeight.w500,
                                color: punchIn == "9:30 AM"
                                    ? Colors.black
                                    : Colors.red),
                            //color: Colors.black),
                          ),
                        ),
                      ),
                      DataCell(
                        Center(
                          child: Text(
                            punchOut,
                            //data.checkOut.toString(),
                            style:  TextStyle(
                                fontSize: AppDimension.width(context)* 0.035,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      DataCell(
                        Center(
                          child: Text(
                            totalHr == "0.000000" ? "--:--" : totalHr,
                            style: GoogleFonts.recursive(
                                fontSize: AppDimension.width(context)* 0.035,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      DataCell(GestureDetector(
                          onTap: () {
                            MonthlyAttendanceReport.datetpass = data.inDateTime
                              .toString();
                            // totalHrpass = totalHr
                            //   .toString();
                            //Get.to(() => ApplyRegularization());
                          },
                          child: controller.hours <= 6
                              ? Container(
                                  height: AppDimension.height(context) * 0.035,
                                  width: AppDimension.height(context) * 0.035,
                                  decoration: BoxDecoration(
                                      color: Colors.blue[300],
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Center(
                                      child: Text(
                                        "R",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: ColorSection.textColorWhite,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 28,
                                  width: 28,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(15)),
                                  child: const Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Center(
                                        child: Icon(
                                      Icons.remove_red_eye_outlined,
                                      size: 16,
                                    )),
                                  ),
                                ))),
                    ]);
              },
            ).toList(),

            showBottomBorder: true,
          ),
        );
      }
    }
  }

  createWeeklyTableList(
      MonthlyAttendanceController controller, BuildContext context) {
    if (controller.errorMsg.value.isNotEmpty) {
      return Center(
          child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 480),
              child: Center(
                  child: NoRecordWidget(
                errorMessage: 'No Record Found',
              ))));
    } else {
      if (controller.monthlyAttendanceResult.isEmpty) {
        return const SizedBox(
            height: 200,
            child: Center(
                child: Padding(
              padding: EdgeInsets.all(20.0),
              child: CircularProgressIndicator(),
            )));
      } else {
        return SingleChildScrollView(
          controller: controller.scrollController,
          scrollDirection: Axis.horizontal,
          child: DataTable(
            horizontalMargin: 0,
            showCheckboxColumn: false,
            dataRowHeight: 50,
            columnSpacing: 10,
            columns: controller.createMonthColumns(),
            //  rows: controller.createRows(),
            rows: List.generate(
              controller.monthlyAttendanceResult.length,
              (index) {
                var data = controller.monthlyAttendanceResult[index];
                var punchIn = controller.converTimeFormat(data.timeIn);
                var punchOut = controller.converTimeFormat(data.timeOut);
                var inDate =
                    controller.modifiedDate(data.inDateTime.toString());
                var inMonth =
                    controller.modifiedMonth(data.inDateTime.toString());
                var totalHr =
                    controller.calculateTotalHour(data.timeIn, data.timeOut);

                return DataRow(
                    onSelectChanged: (value) {

                      MonthlyAttendanceReport.datetpass = data.inDateTime.toString();
                      MonthlyAttendanceReport.totalHrpass = totalHr.toString();
                      print("totalHrpass...${totalHrpass}");
                      Get.to(() => ApplyRegularization());
                    },
                    cells: [
                      DataCell(
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Container(
                            width: AppDimension.width(context) * 0.13,
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                color: ColorSection.primaryColor,
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    //"04",
                                    inDate,
                                    // data.checkIn.toString(),
                                    style:  TextStyle(
                                        color: Colors.white,
                                        fontSize: AppDimension.width(context)* 0.038,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    //"04",
                                    inMonth,
                                    // data.checkIn.toString(),
                                    style:  TextStyle(
                                        color: Colors.white,
                                        fontSize: AppDimension.width(context)* 0.037,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        Center(
                          child: Icon(
                            data.present == "true"
                                ? Icons.check_circle
                                : Icons.cancel,
                            color: data.present == "true"
                                ? Colors.green
                                : Colors.red,
                            size: 22,
                          ),
                        ),
                      ),
                      DataCell(
                        Center(
                          child: Text(
                            punchIn,
                            style: TextStyle(
                                fontSize: AppDimension.width(context)* 0.035,
                                fontWeight: FontWeight.w500,
                                color: punchIn == "9:30 AM"
                                    ? Colors.black
                                    : Colors.red),
                          ),
                        ),
                      ),
                      DataCell(
                        Center(
                          child: Text(
                            punchOut,
                            style:  TextStyle(
                                fontSize: AppDimension.width(context)* 0.035, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      DataCell(
                        Center(
                          child: Text(
                            totalHr.toString(),
                            style: GoogleFonts.recursive(
                                fontSize: AppDimension.width(context)* 0.035, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      DataCell(GestureDetector(
                          onTap: () {
                            MonthlyAttendanceReport.datetpass = data.inDateTime
                              ..toString();
                            print("hr...${controller.hours}");
                            // if(controller.hours <=5){
                            //   controller.isRegularization.value = true;
                            // }else {
                            //   controller.isRegularization.value = false;
                            // }

                            print("val...${controller.isRegularization.value}");
                            Get.to(() => ApplyRegularization());
                          },
                          child: controller.hours <= 5
                              ? Container(
                                  height: AppDimension.height(context) * 0.035,
                                  width: AppDimension.height(context) * 0.035,
                                  decoration: BoxDecoration(
                                      color: Colors.blue[300],
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Center(
                                      child: Text(
                                        "R",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: ColorSection.textColorWhite,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 28,
                                  width: 28,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(15)),
                                  child: const Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Center(
                                        child: Icon(
                                      Icons.remove_red_eye_outlined,
                                      size: 16,
                                    )),
                                  ),
                                ))),
                    ]);
              },
            ).toList(),
            showBottomBorder: true,
          ),
        );
      }
    }

    // return FutureBuilder<List<Result>>(
    //   future: controller.fetchMonthlyAttendanceList(),
    //   builder: (context, snapshot) {
    //     if (snapshot.hasData) {
    //       return SingleChildScrollView(
    //         controller: controller.scrollController,
    //         scrollDirection: Axis.horizontal,
    //         child: DataTable(
    //           // border: TableBorder.all(width: 1),
    //           columnSpacing: 20,
    //           columns: controller.createMonthColumns(),
    //           //  rows: controller.createRows(),
    //           rows: List.generate(
    //             snapshot.data!.length,
    //                 (index) {
    //               var data = snapshot.data![index];
    //               var punchIn = controller.modifiedTime(data.checkIn);
    //               var punchOut = controller.modifiedTime(data.checkOut);
    //               var inDate = controller.modifiedDate(data.inDateTime);
    //               return DataRow(cells: [
    //                 DataCell(
    //                   Text(
    //                     inDate,
    //                     // data.checkIn.toString(),
    //                     style: const TextStyle(fontSize: 13),
    //                   ),
    //                 ),
    //                 DataCell(
    //                   Text(
    //                     'Present',
    //                     style: TextStyle(color: Colors.green[600]),
    //                   ),
    //                 ),
    //                 DataCell(
    //                   Text(
    //                     punchIn,
    //                     // data.checkIn.toString(),
    //                     style: const TextStyle(fontSize: 13),
    //                   ),
    //                 ),
    //                 DataCell(
    //                   Text(
    //                     punchOut,
    //                     //data.checkOut.toString(),
    //                     style: const TextStyle(fontSize: 13),
    //                   ),
    //                 ),
    //                 DataCell(GestureDetector(
    //                   onTap: () {
    //                     //nextScreen();
    //                   },
    //                   child: Container(
    //                     height: 30,
    //                     width: 30,
    //                     decoration: BoxDecoration(
    //                         color: Colors.blue[300],
    //                         borderRadius: BorderRadius.circular(5)),
    //                     child: Padding(
    //                       padding: const EdgeInsets.all(5.0),
    //                       child: Center(
    //                         child: Text(
    //                           "R",
    //                           textAlign: TextAlign.center,
    //                           style:
    //                           TextStyle(color: ColorSection.textColorWhite),
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 )),
    //               ]);
    //             },
    //           ).toList(),
    //           showBottomBorder: true,
    //         ),
    //       );
    //     } else if (snapshot.hasError) {
    //       return Text(snapshot.error.toString());
    //     }
    //     // By default show a loading spinner.
    //     return const SizedBox(
    //         height: 200,
    //         child: Center(
    //             child: Padding(
    //               padding: EdgeInsets.all(20.0),
    //               child: CircularProgressIndicator(),
    //             )));
    //   },
    // );
  }
}
