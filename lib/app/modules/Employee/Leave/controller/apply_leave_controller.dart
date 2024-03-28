import 'package:attendance_system/app/modules/Employee/Leave/model/leaveListModel.dart';
import 'package:attendance_system/app/modules/Employee/Leave/screens/leave_report_list.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/models/value_item.dart';

import 'leave_report_controller.dart';

class ApplyLeaveController extends GetxController {
  final formKey = GlobalKey<FormState>();
  List<String> reportingManagers = [
    "Sunitha Das",
    "Manthan Rout",
    "Avishek Das",
  ];

  List<ValueItem> valueItemManagers = [];

  final LeaveReportController leaveReportController =
      Get.find<LeaveReportController>();
  final box = GetStorage();


  void saveLeaveList() {
    // GetStorage().write('leaveList', leaveReportController.leaveData.value.toList());
    box.write('leaveList', leaveReportController.leaveData.value.map((obj) => obj.toJson()).toList());
    update();
  }

  @override
  void onInit() {
    super.onInit();

    reportingManagers
        .map(
          (e) => valueItemManagers.add(
            ValueItem(
              label: e,
              value: reportingManagers.indexOf(e).toString(),
            ),
          ),
        )
        .toList();
  }

  RxList selectedManager = [].obs;

  RxString selectedType = 'Select'.obs;
  RxInt selectedOption = 1.obs;
  RxInt radioSelectedTypeFrom = 1.obs;
  RxInt radioSelectedTypeTo = 1.obs;
  DateTime? picked;

  // RxString? formattedDate;
  RxString custmFormDate = "".obs;
  RxString custmToDate = "".obs;

  final fromDateController = TextEditingController();
  final toDateController = TextEditingController();
  final reasonController = TextEditingController();

  // controller remains clear when enter to the screen
  @override
  void dispose() {
    fromDateController.dispose();
    fromDateController.clear();
    toDateController.dispose();
    toDateController.clear();
    reasonController.clear();
    reasonController.clear();
    super.dispose();
  }

  ///.........select date....................//
  Future selectDate(String dateType) async {
    final selectedDate = await showDatePicker(
        context: Get.context!,
        initialDate: picked ?? DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime(2050));
    picked = selectedDate;
    //print('date$picked');
    if (dateType == "FromDate") {
      // formattedDate = " ${picked!.year}-${picked!.month}-${picked!.day} ".obs;
      fromDateController.text = DateFormat('yyyy-MM-dd').format(picked!);

      custmFormDate.value = DateFormat('d MMM yy').format(picked!);
    } else {
      // formattedDate = " ${picked!.year}-${picked!.month}-${picked!.day} ".obs;
      // toDateController.text = formattedDate.toString();

      toDateController.text = DateFormat('yyyy-MM-dd').format(picked!);
      custmToDate.value = DateFormat('d MMM yy').format(picked!);
    }
    //convertDateTimeFormat(picked.toString(), dateType);
  }

  applyLeave() {
    if (formKey.currentState!.validate()) {
      if (selectedManager.value.isNotEmpty) {
        leaveReportController.leaveData.add(LeaveListModel(
            fromDate: custmFormDate.value,
            toDate: custmToDate.value,
            status: "Pending"));
        saveLeaveList();
        update();

        Fluttertoast.showToast(
          msg: 'Success',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        Get.back();
      } else {
        Fluttertoast.showToast(
          msg: 'Please select reporting manager',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    }
  }
}
