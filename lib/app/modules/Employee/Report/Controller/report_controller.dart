import 'dart:convert';

import 'package:attendance_system/app/modules/Employee/Report/model/monthly_checkinout_response_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../ApiServices/api_end_points.dart';
import '../screens/circular_chart.dart';

class ReportController extends GetxController{

  RxString  fullname = "".obs;
  final box = GetStorage();
  RxInt userid = 0.obs;
  RxString text = ''.obs;
  RxString titleText = ''.obs;
  RxString errorMsg = ''.obs;
  CalendarController calendarController = CalendarController();
  RxList<MonthlyResult> monthlyCheckInOutResult = <MonthlyResult>[].obs;
  final DateTime dateNow = DateTime.now();
  RxBool isLoading = false.obs;
  RxInt presentCount = 0.obs;
  RxInt absentCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getFullName();
    fetchMonthlyCheckInOutReport();
    // check();
  }
  @override
  void dispose() {
    super.dispose();
    calendarController.dispose();
  }

  void getFullName(){
    fullname.value = box.read("firstName")+" "+ box.read("middleName")+" "+ box.read("lastName");
  }

  check(){

  }


  void calendarTapped(CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.header) {
      text.value = DateFormat('MMMM yyyy').format(details.date!);
      titleText.value = 'Header';
    } else if (details.targetElement == CalendarElement.viewHeader) {
      text.value = DateFormat('EEEE dd, MMMM yyyy').format(details.date!);
      titleText.value = 'View Header';
    } else if (details.targetElement == CalendarElement.calendarCell) {
      text.value = DateFormat('dd-MM-yyyy').format(details.date!);
      titleText.value = 'Calendar cell';
    }
    print("TitleTxt.....$text");
  }

  Future<List<MonthlyResult>> fetchMonthlyCheckInOutReport() async {
    print("Inn");
    isLoading.value == true;
    userid.value = box.read("userId");
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    String finalDate = formatter.format(dateNow);
    try{
      var response = await http.post(

        Uri.parse('${ApiEndPoints.attendanceReportBaseUrl}${AuthEndPoints
            .checkInCheckOutHistory}InputDate=2023-11-09&UId=${userid.value}&ReportStatus=monthly'),
      );
      // var url = '${ApiEndPoints.attendanceReportBaseUrl}${AuthEndPoints
      //     .checkInCheckOutHistory}InputDate=2023-11-09&UId=${userid.value}&ReportType=monthly';
     // print("'URL...$url");
      if (response.statusCode == 200) {
        isLoading.value == false;
        var jsonResponse = json.decode(response.body);
        final isSuccess = jsonResponse['isSuccess'];
        print("isSuccess....$isSuccess");
        if(isSuccess){
          var monthlyData = MonthlyCheckInOutResponse.fromJson(jsonResponse);
          monthlyCheckInOutResult.value = monthlyData.result;

            print("Inside.$presentCount");
            presentCount.value = monthlyCheckInOutResult.where((attendance) => attendance.presentStatus == true).length;
            print("Inside1.$presentCount");
            absentCount.value = monthlyCheckInOutResult.value.length - presentCount.value;
            print("Inside2.$absentCount");

        }else{
          errorMsg.value = "No Data Found";
        }

      }else{
        throw Exception('Unexpected error occured!');
      }

    }catch (e) {

    }
    return monthlyCheckInOutResult;
  }


}