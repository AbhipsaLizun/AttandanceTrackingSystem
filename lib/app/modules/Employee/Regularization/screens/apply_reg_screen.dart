import 'package:attendance_system/app/modules/Admin/AddEmployeeByAdmin/models/reporting_manager.dart';
import 'package:attendance_system/app/modules/Employee/MonthlyAttendanceReport/model/monthly_attendance_response.dart';
import 'package:attendance_system/app/shared/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../shared/widgets/no_recor_widget.dart';
import '../../ColorsGallary/color_section.dart';
import '../../Commons/screensize.dart';
import '../../Commons/text_string.dart';
import '../../MonthlyAttendanceReport/controller/monthly_att_controller.dart';
import '../../MonthlyAttendanceReport/screens/attendance_report.dart';
import '../controller/apply_reg_controller.dart';
import 'buttons.dart';
import 'custom_dropdown.dart';

class ApplyRegularization extends StatelessWidget {
  ApplyRegularization({
    super.key,
  });

  //
  final RegularizationController controller =
      Get.put(RegularizationController());
  MonthlyAttendanceController monAttController =
      Get.find<MonthlyAttendanceController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: ColorConstants.scaffoldBackground,
        appBar: AppBar(
          backgroundColor: ColorSection.primaryColor,
          iconTheme: IconThemeData(color: ColorSection.textColorWhite),
        ),
        body: SafeArea(
            child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
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
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 8, right: 15),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            shadowColor: Colors.grey,
                            color: ColorSection.containerbgColor,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: AppDimension.width(context) * 0.3,
                                height: 20,
                                child: Center(
                                  child: Text(
                                    //Get.arguments["inDate"],
                                    controller.dateInput.value,
                                    style: GoogleFonts.poppins(
                                      fontSize: AppDimension.width(context) * 0.042,
                                        color: Colors.red,
                                        fontWeight: FontWeight.w600),
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
                      Container(
                        //height: AppDimension.height(context) * 0.75,
                        margin: const EdgeInsets.only(bottom: 15),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 7,
                                offset: const Offset(
                                    0, 3), // changes the position of the shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Column(
                              children: [
                                createDataTable(controller, context),
                                Divider(
                                  thickness: 1,
                                  color: ColorSection.textColorBlack,
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Card(
                                    shape: BeveledRectangleBorder(
                                        borderRadius: BorderRadius.circular(3)),
                                    shadowColor: Colors.white,
                                    color: ColorSection.containerbgColor,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        //width:
                                        //AppDimension.width(context) * 0.45,
                                        height: 20,
                                        child: RichText(
                                          text: TextSpan(
                                            text: 'Total Hours : ',
                                            style: GoogleFonts.poppins(
                                                color:
                                                    ColorSection.primaryColor,
                                                letterSpacing: 0.5,
                                                fontWeight: FontWeight.bold),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text:
                                                      // controller.totalHr.value,
                                                      MonthlyAttendanceReport
                                                          .totalHrpass
                                                          .toString(),
                                                  style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors
                                                          .deepOrangeAccent)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: AppDimension.height(context) * 0.02,
                                ),
                                Visibility(
                                  // visible: controller.hourCount.value  < 6
                                  visible: int.parse(
                                              controller.convertToHoursFormat(
                                                  MonthlyAttendanceReport
                                                      .totalHrpass
                                                      .toString())) <
                                          6
                                      ? true
                                      : false,
                                  child: SizedBox(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: Text(
                                              TextString.regularizationTitle,
                                              style: GoogleFonts.poppins(
                                                  color:
                                                      ColorSection.primaryColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),

                                        SizedBox(
                                          height: AppDimension.height(context) *
                                              0.02,
                                        ),

                                        //.........Apply Dates..............//
                                        Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            TextString.regApplyText,
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(
                                          height: AppDimension.height(context) *
                                              0.02,
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8),
                                          child: Row(
                                            children: [
                                              ///............From Date.............//
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 3),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey[200],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8)),
                                                    child: TextFormField(
                                                      controller: controller
                                                          .fromDateController,
                                                      readOnly: true,
                                                      textAlignVertical:
                                                          TextAlignVertical
                                                              .center,
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 15),
                                                      decoration:
                                                          const InputDecoration(
                                                              hintText:
                                                                  "From Date",
                                                              contentPadding:
                                                                  EdgeInsets.only(
                                                                      left: 10),
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              suffixIcon: Icon(
                                                                Icons
                                                                    .calendar_month,
                                                                size: 18,
                                                                color:
                                                                    Colors.grey,
                                                              )),
                                                      onTap: () {
                                                        controller.selectDate(
                                                            "FromDate");
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              ///............To Date.............//
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 3),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey[200],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8)),
                                                    child: TextFormField(
                                                      controller: controller
                                                          .toDateController,
                                                      readOnly: true,
                                                      textAlignVertical:
                                                          TextAlignVertical
                                                              .center,
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 15),
                                                      decoration:
                                                          const InputDecoration(
                                                              hintText:
                                                                  "To Date",
                                                              contentPadding:
                                                                  EdgeInsets.only(
                                                                      left: 10),
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              suffixIcon: Icon(
                                                                Icons
                                                                    .calendar_month,
                                                                size: 18,
                                                                color:
                                                                    Colors.grey,
                                                              )),
                                                      onTap: () {
                                                        controller.selectDate(
                                                            "ToDate");
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: AppDimension.height(context) *
                                              0.02,
                                        ),

                                        ///...............Project Manager..................//
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 8),
                                          child: Row(
                                            children: [
                                              Text(
                                                TextString.reportManager,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 14),
                                              ),
                                              SizedBox(
                                                width: AppDimension.width(
                                                        context) *
                                                    0.07,
                                              ),
                                              Expanded(
                                                  child: Container(
                                                height: 45,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[200],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child: DropdownButton2(
                                                    buttonPadding:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    isExpanded: true,
                                                    value: controller
                                                        .selectedReportingManager
                                                        .value,
                                                    items: controller
                                                        .reportingManagers
                                                        .map((manager) {
                                                      return DropdownMenuItem(
                                                        value: manager,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 5),
                                                          child: Text(
                                                            ' ${manager.firstName} ${manager.lastName}',
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            //overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ),
                                                      );
                                                    }).toList(),
                                                    onChanged: (newManager) {
                                                      controller
                                                          .selectedReportingManager
                                                          .value = newManager;
                                                      controller.reportingMangID
                                                              .value =
                                                          newManager!.userID;
                                                      print(
                                                          "RP....${controller.reportingMangID.value}");
                                                    },
                                                    dropdownDecoration:
                                                        BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                    hint: Row(
                                                      children: [
                                                        const SizedBox(
                                                          width: 4,
                                                        ),
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 8),
                                                            child: Text(
                                                              controller
                                                                  .dropdownvalue
                                                                  .toString(),
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .black87,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ))
                                            ],
                                          ),
                                        ),

                                        SizedBox(
                                          height: AppDimension.height(context) *
                                              0.02,
                                        ),

                                        ///...................Reason..............//
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 8),
                                          child: Row(
                                            children: [
                                              Text(
                                                TextString.reeson,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 14),
                                              ),
                                              SizedBox(
                                                width: AppDimension.width(
                                                        context) *
                                                    0.07,
                                              ),
                                              Expanded(
                                                  child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[200],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: TextFormField(
                                                  controller: controller
                                                      .reasonController,
                                                  maxLines: null,
                                                  style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 15),
                                                  decoration:
                                                      const InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.all(10),
                                                    border: InputBorder.none,
                                                  ),
                                                ),
                                              ))
                                            ],
                                          ),
                                        ),

                                        SizedBox(
                                          height: AppDimension.height(context) *
                                              0.035,
                                        ),

                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(right: 8),
                                            child: SizedBox(
                                              width:
                                                  AppDimension.width(context) *
                                                      0.35,
                                              child: Buttons(
                                                onTapBtn: () {
                                                  if (controller
                                                          .fromDateController
                                                          .text
                                                          .isNotEmpty &&
                                                      controller
                                                          .toDateController
                                                          .text
                                                          .isNotEmpty &&
                                                      controller.reportingMangID
                                                              .value !=
                                                          0 &&
                                                      controller
                                                          .reasonController
                                                          .text
                                                          .isNotEmpty) {
                                                    controller
                                                        .submitRegularization();
                                                    controller
                                                        .fromDateController
                                                        .clear();
                                                    controller.toDateController
                                                        .clear();
                                                    controller.reasonController
                                                        .clear();
                                                    controller.reportingManagers
                                                        .clear();
                                                    controller
                                                        .fromDateTimeFormat
                                                        .value = '';
                                                    controller.toDateTimeFormat
                                                        .value = '';
                                                  } else {
                                                    print("ELSE....");
                                                    Fluttertoast.showToast(
                                                      msg:
                                                          'Please fill all the details',
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity:
                                                          ToastGravity.BOTTOM,
                                                      backgroundColor:
                                                          Colors.red,
                                                      textColor: Colors.white,
                                                    );
                                                  }
                                                },
                                                bgColor:
                                                    ColorSection.primaryColor,
                                                text: "Submit",
                                                textColor:
                                                    ColorSection.textColorWhite,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }

  createDataTable(RegularizationController controller, BuildContext context) {
    if (controller.errorMsg.value.isNotEmpty) {
      return Center(
          child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 500),
              child: Center(
                  child: NoRecordWidget(
                errorMessage: 'No Record Found',
              ))));
    } else {
      if (controller.attendaceResult.isEmpty) {
        return const SizedBox(
            height: 200,
            child: Center(
                child: Padding(
              padding: EdgeInsets.all(20.0),
              child: CircularProgressIndicator(),
            )));
      } else {
        return SingleChildScrollView(
          child: DataTable(
            columnSpacing: AppDimension.width(context) / 2 - 50,
            columns: controller.createColumns(),
            rows: List.generate(
              controller.attendaceResult.length,
              (index) {
                var data = controller.attendaceResult[index];
                var punchIn = monAttController.dailyTimeFormat(data.timeIn);
                var punchOut = monAttController.dailyTimeFormat(data.timeOut);
                controller.totalHr.value =
                    controller.calculateTotalHour(data.totHr);
                print("Hr..${controller.hourCount.value}");
                return DataRow(cells: [
                  DataCell(
                    Text(
                      punchIn,
                      // data.checkIn.toString(),
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                  DataCell(
                    Center(
                      child: Text(
                        punchOut,
                        //data.checkOut.toString(),
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                  // DataCell(
                  //   Center(
                  //     child: Text(
                  //       "${data.hours} hr",
                  //       style: const TextStyle(fontSize: 13),
                  //     ),
                  //   ),
                  // ),
                ]);
              },
            ).toList(),
            showBottomBorder: true,
          ),
        );
      }
    }
  }
}
