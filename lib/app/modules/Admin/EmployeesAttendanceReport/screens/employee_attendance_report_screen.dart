import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../shared/constants/color_constants.dart';
import '../../../../shared/widgets/no_recor_widget.dart';
import '../../Home/controllers/admin_home_screen_controller.dart';
import '../controllers/employee_attendance_report_screen_controller.dart';

class EmployeeAttendanceReportScreen extends StatelessWidget {
  final EmployeeAttendanceReportScreenController
      employeeAttendanceReportScreenController =
      Get.put(EmployeeAttendanceReportScreenController());

  final AdminHomeScreenController adminHomeScreenController =
      Get.find<AdminHomeScreenController>();

  EmployeeAttendanceReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double cWidth = MediaQuery.of(context).size.width * 0.4;
    return Scaffold(
      appBar: AppBar(
        title: Text(adminHomeScreenController.selectedBranchName.value),
      ),
      body: Stack(
        children: [
          SvgPicture.asset(
            'assets/images/svg/ScreenBG_White.svg',
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.toNamed('/BranchWiseReportScreen');
                      },
                      child: Container(
                        // height: 30,
                        width: cWidth,
                        decoration: const BoxDecoration(
                            color: LightColor.primary, // Customize the color
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        padding: const EdgeInsets.all(8),
                        child: const Center(
                          child: Text(
                            'Reports',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed('/AddEmployeeScreen');
                      },
                      child: Container(
                        // height: 30,
                        decoration:const  BoxDecoration(
                            color: LightColor.primary, // Customize the color
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        padding: const EdgeInsets.all(8),
                        child:const Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Add User",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.add,
                                color: Colors.white,
                                // Change the icon color as needed
                                size: 25, // Change the icon size as needed
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Obx(() {

                    if (employeeAttendanceReportScreenController
                        .errorMessage.isNotEmpty) {
                      // If errorMessage is not empty, show the error message
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          NoRecordWidget(
                            errorMessage: employeeAttendanceReportScreenController
                                .errorMessage.value,
                          ),
                        ],
                      );
                    } else {
                      if (employeeAttendanceReportScreenController
                          .employees.isEmpty) {
                        // If the employees list is empty, show a loading indicator
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        // If isSuccess is true and there are employees, show the ListView
                        return
                        // GetBuilder<EmployeeAttendanceReportScreenController>(builder:(c) {
                        //   return
                            RefreshIndicator(
                              triggerMode: RefreshIndicatorTriggerMode.onEdge,
                              onRefresh: ()async{
                                await Future.delayed(const Duration(seconds: 3),(){
                                  employeeAttendanceReportScreenController.fetchEmployeeData();
                                }
                                );
                              },
                              child: ListView(
                                children: [
                                  SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: DataTable(
                                        columnSpacing: 28,
                                        columns: const [
                                          DataColumn(label: Text('')),
                                          DataColumn(
                                            label: Text(
                                              'Working\nHours',
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          DataColumn(
                                            label: Text('Today',
                                                textAlign: TextAlign.center),
                                          ),
                                          DataColumn(
                                            label: Text(
                                              'Last\nWeek',
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          DataColumn(
                                            label: Text('Month',
                                                textAlign: TextAlign.center),
                                          ),
                                        ],
                                        rows: employeeAttendanceReportScreenController
                                            .employees.reversed
                                            .map((employee) {
                                          return DataRow(
                                            cells: [
                                              DataCell(
                                                Center(child: Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 5),
                                                      child: Text(employee.firstName),
                                                    ))),
                                              ),
                                              DataCell(
                                                Center(
                                                    child: Text(
                                                        employeeAttendanceReportScreenController
                                                            .calculateWorkingHours(
                                                            employee.timeIn,
                                                            employee.timeOut))),
                                              ),
                                              DataCell(
                                                Center(
                                                  child: employee.present
                                                      ? InkWell(
                                                    onTap: () {

                                                      employeeAttendanceReportScreenController
                                                          .selectedUserId
                                                          .value =
                                                          employee.userId
                                                              .toString();
                                                      employeeAttendanceReportScreenController
                                                          .selectedUserName
                                                          .value =
                                                          employee.firstName
                                                              .toString();

                                                      Get.toNamed(
                                                          "/TodayAttendanceReportScreen");
                                                    },
                                                    child: Container(
                                                      height: 25,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Colors.green,
                                                        borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                      ),
                                                      padding:
                                                      const EdgeInsets.only(
                                                          left: 10,
                                                          right: 10),
                                                      child: Center(
                                                        child: Image.asset(
                                                          "assets/images/png/eye.png",
                                                          height: 10,
                                                          width: 20,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                      : InkWell(
                                                    onTap: () {
                                                      // Handle the case when not present
                                                    },
                                                    child: Container(
                                                      height: 25,
                                                      decoration:
                                                      const BoxDecoration(
                                                        color: Colors.red,
                                                        borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                      ),
                                                      padding:
                                                      const EdgeInsets.only(
                                                          left: 10,
                                                          right: 10),
                                                      child: Center(
                                                        child: Image.asset(
                                                          "assets/images/png/eye.png",
                                                          height: 10,
                                                          width: 20,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              DataCell(InkWell(
                                                onTap: () {
                                                  employeeAttendanceReportScreenController
                                                      .selectedUserId.value =
                                                      employee.userId.toString();
                                                  employeeAttendanceReportScreenController
                                                      .selectedUserName.value =
                                                      employee.firstName.toString();
                                                  Get.toNamed(
                                                      "/WeeklyAttendanceReportScreen");
                                                },
                                                child: Container(
                                                  height: 25,
                                                  decoration: const BoxDecoration(
                                                    color: LightColor.primary,
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(10)),
                                                  ),
                                                  padding: const EdgeInsets.only(
                                                      left: 10, right: 10),
                                                  child: Center(
                                                    child: Image.asset(
                                                      "assets/images/png/calenderview_icon.png",
                                                      height: 20,
                                                      width: 20,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              )),
                                              DataCell(InkWell(
                                                onTap: () {
                                                  employeeAttendanceReportScreenController
                                                      .selectedUserId.value =
                                                      employee.userId.toString();
                                                  employeeAttendanceReportScreenController
                                                      .selectedUserName.value =
                                                      employee.firstName.toString();
                                                  Get.toNamed("/MonthlyAttendanceReportScreen");
                                                },
                                                child: Container(
                                                  height: 25,
                                                  decoration: const BoxDecoration(
                                                    color: LightColor.primary,
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(10)),
                                                  ),
                                                  padding: const EdgeInsets.only(
                                                      left: 10, right: 10),
                                                  child: Center(
                                                    child: Image.asset(
                                                      "assets/images/png/calenderview_icon.png",
                                                      height: 20,
                                                      width: 20,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              )),
                                            ],
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );

                       //},

                        //);
                      }
                    }
                  }),
                ),
              ],
            ),
          ],
        ),
      );
  }
}
