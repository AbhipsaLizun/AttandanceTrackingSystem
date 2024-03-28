import 'package:attendance_system/app/modules/Employee/Report/Controller/report_controller.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../shared/constants/app_text_styles.dart';
import '../../../../shared/constants/color_constants.dart';
import '../../../../shared/widgets/no_recor_widget.dart';
import '../../ColorsGallary/color_section.dart';
import '../../Regularization/screens/custom_dropdown.dart';
import '../controller/leave_report_controller.dart';

class LeaveReport extends StatelessWidget {
  final LeaveReportController controller = Get.put(LeaveReportController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text("Leave Request"),
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
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 05,
                    ),
                    //! Leaves  Row
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, top: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Leaves",
                            style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: ColorSection.textColorBlack,
                                letterSpacing: 0.5),
                          ),

                          //! Leave Apply Button
                          ElevatedButton(
                            onPressed: () {
                              Get.lazyPut<LeaveReportController>(() => LeaveReportController());

                              Get.toNamed("/LeaveApplyScreen");
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: LightColor.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'Apply  leave',
                                style: AppTextStyles.customTextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    // Leave Card
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Present
                        leaveCard(
                            context: context,
                            tittle: 'Annual',
                            total:
                                // controller.presentCount.value.toString(),
                                "3/12",
                            cardColor: Color(0xffC0E77F),
                            texColor: const Color(0xFF4C691D)),
                        // Absent
                        leaveCard(
                            context: context,
                            tittle: 'Medical',
                            total:
                                // controller.absentCount.value.toString(),
                                "2/5",
                            cardColor: Color(0xffd0ecff),
                            texColor: const Color(0xFF22577B)),
                        // Leave
                        leaveCard(
                            context: context,
                            tittle: 'Casual',
                            total:
                                // controller.absentCount.value.toString(),
                                "1/5",
                            cardColor: Color(0xFFFDE1DC),
                            texColor: const Color(0xFF9A4738))
                      ],
                    ),

                    const SizedBox(
                      height: 20,
                    ),

// Leave Request row
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, top: 10),
                            child: Text(
                              "Leave Request Info",
                              style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: ColorSection.textColorBlack,
                                  letterSpacing: 0.5),
                            ),
                          ),
                        ),

                      //...............Month  Dropdown..................//

                        // Expanded(
                        //   child: Container(
                        //     height: 45,
                        //     decoration: BoxDecoration(
                        //         color: Colors.grey[200],
                        //         border: Border.all(color: Colors.grey),
                        //         borderRadius: BorderRadius.circular(8)),
                        //     child: DropdownButtonHideUnderline(
                        //       child: DropdownButton2(
                        //         dropdownMaxHeight: 300,
                        //         offset: const Offset(0, -04),
                        //         dropdownDecoration: BoxDecoration(
                        //           border: Border.all(color: Colors.transparent),
                        //           borderRadius: BorderRadius.circular(8),
                        //         ),
                        //         isExpanded: true,
                        //         buttonPadding:
                        //             const EdgeInsets.only(left: 5, right: 5),
                        //         items: controller.calendarList.map((list) {
                        //           return DropdownMenuItem(
                        //             value: list.toString(),
                        //             child: Text(
                        //               list.toString(),
                        //               style: const TextStyle(
                        //                 fontSize: 14,
                        //                 color: Colors.black,
                        //               ),
                        //             ),
                        //           );
                        //         }).toList(),
                        //           onChanged: (String? value) {
                        //             controller.selectedMonthType.value =
                        //             value!;
                        //         },
                        //         hint: Row(
                        //           children: [
                        //             const SizedBox(
                        //               width: 4,
                        //             ),
                        //             Expanded(
                        //               child: Obx(
                        //                 () => Text(
                        //                   controller.selectedMonthType.toString(),
                        //                   style: const TextStyle(
                        //                     fontSize: 14,
                        //                     fontWeight: FontWeight.w500,
                        //                     color: Colors.black87,
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),

//  Least report Table

                    Expanded(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(minHeight: 500),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(bottom: 15, top: 15),
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
                            child: createDataTable(controller),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),

    );
  }

  Widget createDataTable(LeaveReportController controller) {
    return controller.leaveData.isEmpty
        ?  Center(
        child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 500),
            child: Center(
                child: NoRecordWidget(
                  errorMessage: 'No Record Found',
                )
              // Text("No records found ")
            ))
    )
        : DataTable2(
            columnSpacing: 30,
            columns: createColumns(),
            rows: List.generate(
              controller.leaveData.value.length,
              (index) {
                var data = controller.leaveData[index];
                return DataRow(cells: [
                  DataCell(
                    Text(
                      data.fromDate.toString(),
                      // data.checkIn.toString(),
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                  ),
                  DataCell(
                    Center(
                      widthFactor: 0.5,
                      child: Text(
                        data.toDate.toString(),
                        //data.checkOut.toString(),
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  DataCell(
                    Text(
                      data.status.toString(),
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: data.status == "Approved"
                              ? Colors.green
                              : data.status == "Rejected"
                                  ? Colors.red
                                  : Color(0xffFA9301)),
                    ),
                  )
                ]);
              },
            ).reversed.toList(),
            showBottomBorder: true,
          );
  }
}

List<DataColumn> createColumns() {
  return [
    const DataColumn(
        label: Center(
      widthFactor: 1.5,
      child: Text(
        'From',
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
    )),
    const DataColumn(
        label: Center(
      widthFactor: 1.5,
      child: Text(
        'To',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    )),
    const DataColumn(
        label: Center(
      widthFactor: 1.5,
      child: Text(
        'Status',
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
    )),
  ];
}

Card leaveCard(
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
      child: leaveData(
        count: total,
        category: tittle,
        catClr: Colors.black,
        countClr: texColor,
      ),
    ),
  );
}

class leaveData extends StatelessWidget {
  final String count;
  final String category;
  final Color countClr;
  final Color catClr;

  const leaveData(
      {super.key,
      required this.count,
      required this.category,
      required this.countClr,
      required this.catClr});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          category,
          style: GoogleFonts.poppins(
              color: catClr, fontSize: 14, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 02,
        ),
        Text(
          count,
          style: GoogleFonts.poppins(
              color: countClr, fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
