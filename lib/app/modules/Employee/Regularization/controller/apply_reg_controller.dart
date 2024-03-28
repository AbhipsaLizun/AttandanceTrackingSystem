import 'dart:convert';
import 'dart:developer';
import 'package:attendance_system/app/modules/Employee/Home/screens/employee_home_screen.dart';
import 'package:attendance_system/app/modules/Employee/MonthlyAttendanceReport/model/monthly_attendance_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../../ApiServices/api_end_points.dart';
import '../../../../shared/widgets/custom_loading_dialog.dart';
import '../../../../shared/widgets/custom_success_dialog.dart';
import '../../../../shared/widgets/custom_success_dialog2.dart';
import '../../../Admin/AddEmployeeByAdmin/models/reporting_manager.dart';
import '../../../main_screen.dart';
import '../../MonthlyAttendanceReport/controller/monthly_att_controller.dart';
import '../../MonthlyAttendanceReport/model/DailyCheckInOutResponse.dart';
import '../../MonthlyAttendanceReport/screens/attendance_report.dart';
import '../../Report/Controller/report_controller.dart';
import '../../Report/screens/report_screen.dart';

class RegularizationController extends GetxController {
  final fromDateController = TextEditingController();
  final toDateController = TextEditingController();
  final reasonController = TextEditingController();
  final scrollController = ScrollController();

  final box = GetStorage();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxList<ResultResponse> attendaceResult = <ResultResponse>[].obs;
  RxString inputDate = ''.obs;
  RxString errorMsg = ''.obs;
  RxString totalHr = ''.obs;
  RxInt regId = 0.obs;
  RxInt hourCount = 0.obs;
  RxString fromDateTimeFormat = ''.obs;
  RxString toDateTimeFormat = ''.obs;
  RxInt reportingMangID = 0.obs;
  RxString  username = "".obs;
  RxString dateInput = ''.obs;
  RxString dropdownvalue = 'Select'.obs;

  var reportingManagers = <ReportingManager>[].obs;
  final selectedReportingManager = Rx<ReportingManager?>(null);

  DateTime? picked;
  RxString? formattedDate;
  var totalHours;
  var totalMinutes;

  ReportController repController = Get.find<ReportController>();
  MonthlyAttendanceController monAttController = Get.find<MonthlyAttendanceController>();


  @override
  void onInit() {
    fetchregularizationList();
     fetchReportingManagers();
    getFullName();
    // calculateTotalHour();

    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
    fromDateController.dispose();
    toDateController.dispose();
    reasonController.dispose();
  }


  void getFullName(){
    username.value = box.read("firstName")+" "+ box.read("middleName")+" "+ box.read("lastName");
  }

  //.......DateTimeFormat......................//
  convertDateTimeFormat(String dateTimeType, String dateType) {
    if (dateType == "FromDate") {
      var chngFromDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z")
          .format(DateTime.parse(dateTimeType));
      fromDateTimeFormat.value = '${chngFromDate}Z';
      print("FD...${fromDateTimeFormat.value}");
    } else {
      var chngToDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z")
          .format(DateTime.parse(dateTimeType));
      toDateTimeFormat.value = '${chngToDate}Z';
      print("TD...${toDateTimeFormat.value}");
    }
  }

  converTimeFormat(String time) {
    // print("Times...$time");
    final inputFormat = DateFormat.Hm();
    final outputFormat = DateFormat("h:mm a");
    final parsedTime = inputFormat.parse(time);
    final formattedTime = outputFormat.format(parsedTime);
    return formattedTime;
  }

  //.........select date....................//
  Future selectDate(String dateType) async {
    final selectedDate = await showDatePicker(
        context: Get.context!,
        initialDate: picked ?? DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime(2050));
    picked = selectedDate;
    //print('date$picked');
    if(dateType == "FromDate"){
      formattedDate = " ${picked!.year}-${picked!.month}-${picked!.day} ".obs;
      fromDateController.text = formattedDate.toString();
     // print('date$fromDateController');
    }else{
      formattedDate = " ${picked!.year}-${picked!.month}-${picked!.day} ".obs;
      toDateController.text = formattedDate.toString();
    }
    convertDateTimeFormat(picked.toString(), dateType);

  }

  List<DataColumn> createColumns() {
    return [

      const DataColumn(

          label: Text(
        'Punch In',
        style: TextStyle(fontSize: 15),
      )),
      const DataColumn(
          label: Text(
        'Punch Out',
        style: TextStyle(fontSize: 15),
      )),
      // const DataColumn(
      //     label: Text(
      //   'Hours',
      //   style: TextStyle(fontSize: 15),
      // )),
    ];
  }

  //...Modified Time...........//
  String modifiedTime(String time) {
    String punchTime = DateFormat.jm().format(DateTime.parse(time));
    // var parsedDate = DateFormat('yyyy-MM-ddTHH:mm:ss').parse(time);
    // String punchTime = DateFormat.jm().format(parsedDate);
    return punchTime;
  }

  String modifiedDate(String date){
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    String finalDate = formatter.format(DateTime.parse(date));
    return finalDate;
  }

  ///......Calculating Total Hours........//
  String calculateTotalHour(DateTime totHr){
    String formattedTotalTime;

    final String totalDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(totHr.toString()));
    print("Tot12 $totalDateTime");

    String  totalTime= DateFormat.Hm().format(DateTime.parse(totalDateTime));
    print("Sot1...$totalTime");

    RegExp regExp = RegExp(r'^(\d{2}):(\d{2})$');
    RegExpMatch match = regExp.firstMatch(totalTime)!;

    if (match != null && match.groupCount == 2) {
      // Extract hours and minutes
      int hours = int.parse(match.group(1)!);
      int minutes = int.parse(match.group(2)!);

      hourCount.value = hours;
      // Format the time
      formattedTotalTime = '$hours hr $minutes min';

      print("FD....$formattedTotalTime");  // Output: 00 hr 18 min
    } else {
      formattedTotalTime = "-";
    }
    // String formattedTime = DateFormat("hh 'hr' mm 'min'").format(DateTime.parse(dateTime));
    // print("Tot $formattedTime");
     return formattedTotalTime;
  }

 ///..Fetch Regularization list.............//
  Future<List<ResultResponse>> fetchregularizationList() async {
   // print("HELLOO");
    var userid = box.read("userId");
    var financialYearId = box.read("financialYearId");
    var branchId = box.read("branchId");
     // String date = Get.arguments["inDate"] ?? DateTime.now();
     String date = MonthlyAttendanceReport.datetpass.toString(); //2023-11-20 00:00
    print("DATEE....$date");

    String newDate = date.replaceAll('T',' ');
   // print("N...$newDate");

   var split = newDate.split(" ");
   //dateInput.value = reverseDateFormat(split[0]) ;

    try {

      var response = await http.post(
        Uri.parse('${ApiEndPoints.attendanceReportBaseUrl}${AuthEndPoints
            .getCheckInOutByIDWithHour}InputDate=${split[0]}&UId=$userid&FinYear=$financialYearId&BranchId=$branchId'),
      );

      print("RES1...${response.statusCode}");
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        final isSuccess = jsonResponse['isSuccess'];

        if(isSuccess){
          var data = DailyCheckInOutResponse.fromJson(jsonResponse);
          attendaceResult.value = data.result;
          dateInput.value = DateFormat('dd-MM-yyyy').format(DateTime.parse(attendaceResult.value[0].checkIn.toString()));
          //print("DATA....$attendaceResult");

          // attendaceResult.map((e) => totalHr += int.parse(e.hours)).toList();
          // print("Total hr =$totalHr");

        }else{
          errorMsg.value = "No Data Found";
        }
      } else {
        throw Exception('Unexpected error occured!');
      }
    } catch(e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
    return attendaceResult;
  }

  //..Fetch Reporting Manager.............//
  Future<void> fetchReportingManagers() async {
    var branchID = box.read("branchId");
    print("RM..."+ branchID.toString());

    try {
      var response = await http.post(
        Uri.parse('${ApiEndPoints.CommonBaseUrl}${AuthEndPoints
            .getReportingManager}branchId=$branchID'),
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        final isSuccess = data['isSuccess'];

        if (isSuccess) {
          final repManagerList = (data['result'] as List)
              .map((item) => ReportingManager.fromJson(item))
              .toList();
          reportingManagers.assignAll(repManagerList);
        } else {
          errorMsg.value = "No Data Found";
        }
      } else {
        throw Exception('Unexpected error occured!');
      }
    }catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }

  String reverseDateFormat(String inputDate) {
    List<String> dateComponents = inputDate.split('-');
    if (dateComponents.length == 3) {
      String reversedDate = '${dateComponents[2]}-${dateComponents[1]}-${dateComponents[0]}';
      return reversedDate;
    } else {
      return 'Invalid Date';
    }
  }

  //.............Apply Regularization........................//
  Future<void> submitRegularization()async{
    var userid = box.read("userId");
    var date = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z").format(DateTime.now());
    String createdOnTime = '${date}Z';

    print("RepMang...${reportingMangID.value}");

    try{
      var encodedBody = json.encode({

          "reglarId": regId.value,
          "userId": userid,
          "reportingManagerId": reportingMangID.value,
          "remarks": reasonController.text,
          "location": "test",
          "regStaus": 1,
          "reportingManagerRemarks": " ",
          "createdBy": "test",
          "createdOn": createdOnTime,
          "modifiedBy": username.value,
          "modifiedOn": createdOnTime,
          "fromDate": fromDateTimeFormat.value,
          "toDate": toDateTimeFormat.value
      });
      print("BODY.......$encodedBody");

      Map<String, String> header = {
        "Content-type": "application/json",
        "accept": "*/*",
      };

      final uri = Uri.parse('${ApiEndPoints.regularizationsBaseUrl}${AuthEndPoints
          .addRegularizationDetails}');
      var response = await http.post(uri, body: encodedBody, headers: header);
      //print("RES.......${response.statusCode}");
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        final isSuccess = jsonResponse['isSuccess'];

        if(isSuccess){
          //_showAlert(Get.context!);
          Get.dialog(
            CustomSuccessDialog2(message: 'Successfully applied',),
            barrierDismissible: false,
          );
          // repController.calendarController.selectedDate = DateTime.now();
          monAttController.selectedType.value = "Select";
          monAttController.weekContainerView.value = false;
          monAttController.monthContainerView.value = false;
          monAttController.dailyContainerView.value = true;
          monAttController.date.value = '';
          repController.text.value = repController.calendarController.selectedDate.toString();
          print("Date....${repController.calendarController.selectedDate}");

        //  Get.toNamed('/MainScreen');

          Future.delayed(const Duration(seconds: 2), () {
            Get.offAllNamed('/MainScreen', arguments: {'initialTabIndex': 1});
          });

    }else{
          errorMsg.value = "No Data Found";
        }
      }

    }catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }

  String convertToHoursFormat(String input) {
    List<String> parts = input.split(' ');

    int hours = 0;

    for (int i = 0; i < parts.length; i += 2) {
      int value = int.parse(parts[i]);
      String unit = parts[i + 1].toLowerCase();

      if (unit == 'hr') {
        hours = value;
        break; // No need to check further for hours
      }
    }

    return hours.toString().padLeft(2, '0');
  }




  }

