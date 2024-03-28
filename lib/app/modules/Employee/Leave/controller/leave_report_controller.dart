import 'package:attendance_system/app/modules/Employee/Leave/model/leaveListModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LeaveReportController extends GetxController {
  final scrollController = ScrollController();
  List<String> calendarList = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];

  RxString selectedMonthType = 'Nov'.obs;

  // Leave Report data
  RxList<LeaveListModel> leaveData = <LeaveListModel>[].obs;
  final storedList = GetStorage();
  final box = GetStorage();

  @override
  void onInit() {
    loadLeaveList();
    super.onInit();
  }

  void loadLeaveList() {
    var storedList = box.read<List>('leaveList');
    if (storedList != null) {
      leaveData.value.assignAll(
        storedList.map(
          (data) => LeaveListModel.fromJson(data),
        ),
      );

      update();
      print(leaveData.toString());
    } else {
      leaveData.value.clear();
      update();
    }
  }
}

// class LeaveDataModel{
//   String? fromDate ;
//   String? toDate;
//   String? status;
//
//   LeaveDataModel({required this.fromDate,required this.toDate, required this.status});
//
// }
