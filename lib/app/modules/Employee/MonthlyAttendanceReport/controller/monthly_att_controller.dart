import 'dart:convert';
import 'package:attendance_system/app/modules/Employee/MonthlyAttendanceReport/model/DailyCheckInOutResponse.dart';
import 'package:attendance_system/app/modules/Employee/Report/screens/report_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../../ApiServices/api_end_points.dart';
import '../../ColorsGallary/color_section.dart';
import '../model/monthly_attendance_response.dart';
import '../model/monthly_attendance_model.dart';
import 'package:http/http.dart' as http;

class MonthlyAttendanceController extends GetxController {
  final scrollController = ScrollController();
  // List<AttendanceModel> empAttendance = [];
  final box = GetStorage();
  RxList<ResultResponse> attendanceResult = <ResultResponse>[].obs;
  RxList<Result> monthlyAttendanceResult = <Result>[].obs;
  List<Result> weeklyAttendanceResult = [];
  DateTime? selectedDate;
  //DateTime currentDate = Get.arguments["selectedDate"]  ;
  DateTime currentDate = DateTime.parse(ReportScreen.selectedPassDate.toString());
  RxString date= ''.obs;
  RxString finalDate = ''.obs;
  DateTime? lastDayOfMonth;
  RxInt selectedIndex = RxInt(0);
  RxBool isLoading = false.obs;
  RxList errorList = [].obs;

  RxInt userid = 0.obs;
  RxInt financialYearId = 0.obs;
  RxInt branchId = 0.obs;



  RxString? _text = ''.obs;
  RxString? _titleText = ''.obs;
  RxString errorMsg = ''.obs;
  //RxString errorMsg2 = ''.obs;
  RxString tag = ''.obs;
  var hours;
  RxBool isRegularization = false.obs;

  List<String> calendarList = [
    "Daily",
    "Month",
    "Week",
    "Date Range"
  ];
  RxString selectedType = 'Select'.obs;

  RxBool dailyContainerView = true.obs;
  RxBool weekContainerView = false.obs;
  RxBool monthContainerView = false.obs;



  @override
  void onInit() {
    super.onInit();
    print("DATE123.....$currentDate");
  fetchDailyAttendanceList(currentDate);
  }


  // void onDateClicked(DateTime selectedDay, DateTime focusDay ) {
  //   /// Implement your action here
  //   print("Selected day: $selectedDay");
  //   // You can perform any desired action here based on the selected day.
  // }

  ///...Modified Time...........//
  // String modifiedTime(String time) {
  //   print("Time...$time");
  //   var parsedDate = DateFormat('mm:ss').parse(time);
  //   String punchTime = DateFormat.jm().format(parsedDate);
  //   print("Time1...$time");
  //   return punchTime;
  // }

  ///......Monthly and weekly data time format for punchIn and Out .......(createMonthlyTableList)
  String converTimeFormat(String time){
    String dateTime = DateFormat("h:mm a").format(DateFormat("dd/MM/yyyy HH:mm:ss").parse(time));
    print(dateTime);
    return dateTime;
  }

  ///......Daily data time format for punchIn and Out .......(createDataTable)
  String dailyTimeFormat(String time){
    var formattedTime;
    if(time == "0:0"){
      formattedTime =  "00.00";
    }else{
      final inputFormat = DateFormat.Hm();
      final outputFormat = DateFormat("h:mm a");
      final parsedTime = inputFormat.parse(time);
      formattedTime = outputFormat.format(parsedTime);
    }
    return formattedTime;
  }


  String calculateTotalHour(String timeIn , String timeOut){
    print("In...$timeIn");
    print("Out...$timeOut");

    var dateTimeIn = DateFormat("h:mm").format(DateFormat("dd/MM/yyyy HH:mm:ss").parse(timeIn));
    //var dateTimeOut = DateFormat("Hm").format(DateFormat("dd/MM/yyyy HH:mm:ss").parse(timeOut));
    var dateTimeOut = DateFormat("h:mm").format(DateFormat("dd/MM/yyyy HH:mm:ss").parse(timeOut));

    print("DIn...$dateTimeIn");
    print("DOut...$dateTimeOut");

    var format = DateFormat("HH:mm");
    var start = format.parse(dateTimeIn);
    var end = format.parse(dateTimeOut);
    var totalHr;

    print("SIn...$start");
    print("SOut...$end");

    if (end.isAfter(start)) {
      end = end.add(Duration(days: 0));
      Duration diff = end.difference(start).abs();
      hours = diff.inHours;
      final minutes = diff.inMinutes % 60;
      totalHr = "$hours hr $minutes min";
      print('TOT $hours hours $minutes minutes');
    }else{
      totalHr = "0 hr 0 min";
    }

    return totalHr;
  }

  ///...........Custom dateformat for monthly & Week table.......
  String modifiedDate(String date){
    final DateFormat formatter = DateFormat('dd');
    String finalDate = formatter.format(DateTime.parse(date));
    print("D....$finalDate");
     return finalDate;
  }

  ///...........Custom Timeformat for monthly & Week table.......
  String modifiedMonth(String date){
    final DateFormat formatter = DateFormat('MMMM');
    String finalMonth = formatter.format(DateTime.parse(date));
    print("D....${finalDate.substring(0,3)}");
    return finalMonth.substring(0,3);
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

  ///...........Custom column for Daily table.......
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
      const DataColumn(
          label: Text(
            'Hours',
            style: TextStyle(fontSize: 15),
          )),
    ];
  }

  ///...........Custom column for monthly & Week table.......
  List<DataColumn> createMonthColumns() {
    return [
      const DataColumn(label: Center(
        widthFactor: 1.8,
        child: Text('Date',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),),
      )),
      const DataColumn(label: Text('Status',
        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),)),
      const DataColumn(label: Text('Punch In',
        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),)),
      const DataColumn(label: Text('Punch Out',
        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),)),
      const DataColumn(label: Center(
        widthFactor: 1.25,
        child: Text('Tot. Hrs',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),),
      )),
      const DataColumn(label: Text('Edit',
        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),))
    ];
  }


  ///........Daily API..............
  Future<List<ResultResponse>> fetchDailyAttendanceList(DateTime dateSelected) async {
    userid.value = box.read("userId");
    financialYearId.value = box.read("financialYearId");
   branchId.value = box.read("branchId");
    print("SECDate....${userid.value}");

    isLoading.value = true;
    errorMsg.value='';

    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    dateSelected = dateSelected ?? currentDate;
    finalDate.value = formatter.format(dateSelected);
    currentDate = dateSelected;
    print("DATC....$finalDate");
    date.value = reverseDateFormat(finalDate.value);
    print("DATC....$date");

    try {
      var response = await http.post(
     Uri.parse('${ApiEndPoints.attendanceReportBaseUrl}${AuthEndPoints
             .getCheckInOutByIDWithHour}InputDate=$finalDate&UId=${userid.value}&FinYear=${financialYearId.value}&BranchId=${branchId.value}'),

      );
      print("RES....${response.statusCode}");

      if (response.statusCode == 200) {
        isLoading.value = false;
        var jsonResponse = json.decode(response.body);
       final isSuccess = jsonResponse['isSuccess'];
        print("Succ....$isSuccess");
       if(isSuccess){
         isLoading.value = false;
        var data = DailyCheckInOutResponse.fromJson(jsonResponse);
         //errorList.value = data.errorMessage;
          attendanceResult.value = data.result;

          print("'DAILY..$attendanceResult['checkIn']");
        }else{
          errorMsg.value = "No Data Found";
        }
      } else {
        throw Exception('Unexpected error occured!');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }finally{
      isLoading.value = false;
    }
    return attendanceResult;
  }


///.......Month And Week Report Api .......................//
  Future<List<Result>> fetchMonthlyWeeklyAttendanceReport() async {

    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    String finalDate = formatter.format(currentDate);
    //String finalDate = currentDate.toString();

    isLoading.value = true;
    errorMsg.value='';

    print("Month  ${selectedType.value}");
    print("Month Date2  $finalDate");
    try {
      var response = await http.post(
          Uri.parse('${ApiEndPoints.CommonBaseUrl}${AuthEndPoints
              .checkIncheckOutDayWeekMonth}UserId=${userid.value}&finYear=${financialYearId.value}&branchid=${branchId.value}&ttype=${selectedType.value == 'Select' ? 'day1'
              : selectedType.value == 'Month'? 'month1' :
          selectedType.value == 'Week'? 'week1' : 'day1' }&indate=$finalDate'),
      );
      // var Url1 = '${ApiEndPoints.CommonBaseUrl}${AuthEndPoints
      //     .checkIncheckOutDayWeekMonth}UserId=${userid.value}&finYear=${financialYearId.value}&branchid=${branchId.value}&ttype=${selectedType.value == 'Select' ? 'day1'
      //     : selectedType.value == 'Month'? 'month1' :
      // selectedType.value == 'Week'? 'week1' : 'day1' }&indate=$finalDate';

      // print("URL1....$Url1");
      print("'Response...${response.statusCode}");
      if (response.statusCode == 200) {
        isLoading.value = false;
        var jsonResponse = json.decode(response.body);
        final isSuccess = jsonResponse['isSuccess'];
        if(isSuccess){
          var data = MonthlyAttendanceResponse.fromJson(jsonResponse);
          monthlyAttendanceResult.value = data.result;
          print("'DAILY12..${monthlyAttendanceResult[0].timeIn}");
        }else{
          errorMsg.value = "No Data Found";
        }
      } else {
        throw Exception('Unexpected error occured!');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
    return monthlyAttendanceResult;
  }

}
