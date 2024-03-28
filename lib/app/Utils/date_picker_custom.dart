import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../modules/Admin/WeeklyAttendanceReport/controllers/weekly_attendance_report_screen_controller.dart';


class DatePickerCustom extends StatelessWidget {

  final WeeklyAttendanceReportScreenController controller = Get.put(WeeklyAttendanceReportScreenController());

  DatePickerCustom({super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final currentMonthDate = DateFormat('MMMM y').format(now);

    // Check if the selected date is the current date when the page is loaded
    if (controller.selectedDate == null) {
      controller.selectDate(now.day -
          1); // Select the current day (subtract 1 because indexing starts from 0)
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 148.0,
        title: Column(
          children: [
            const Row(
              children: [
                Icon(
                  Icons.arrow_back_ios,
                  color: Colors.orange,
                ),
                Expanded(
                  child: Text(
                    "Workout",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 16.0),
            Text(
              currentMonthDate,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const ClampingScrollPhysics(),
              child: Row(
                children: List.generate(
                  controller.lastDayOfMonth.day,
                  (index) {
                    final currentDate =
                        DateTime(now.year, now.month, index + 1);
                    final dayName = DateFormat('EEEE').format(currentDate);

                    return Padding(
                      padding: EdgeInsets.only(
                        left: index == 0 ? 16.0 : 0.0,
                        right: 16.0,
                      ),
                      child: GestureDetector(
                        onTap: () => controller.selectDate(index),
                        child: Obx(() {
                          return Container(
                            decoration: BoxDecoration(
                              color: controller.selectedIndex.value == index
                                  ? Colors.orange
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(44.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 42.0,
                                  width: 42.0,
                                  alignment: Alignment.center,
                                  child: Text(
                                    dayName.substring(0, 1),
                                    style: TextStyle(
                                      fontSize: 24.0,
                                      color: controller.selectedIndex.value ==
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
                                        controller.selectedIndex.value == index
                                            ? Colors.white
                                            : Colors.black54,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Container(
                                  height: 2.0,
                                  width: 28.0,
                                  color: controller.selectedIndex.value == index
                                      ? Colors.orange
                                      : Colors.transparent,
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
          ],
        ),
      ),
    );
  }
}
