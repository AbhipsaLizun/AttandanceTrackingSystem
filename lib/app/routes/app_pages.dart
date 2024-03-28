import 'package:attendance_system/app/modules/Admin/BranchWiseReports/MainScreen/screens/branchwise_report_screen.dart';
import 'package:attendance_system/app/modules/Employee/Leave/screens/apply_leave_screen.dart';
import 'package:get/get.dart';

import '../modules/Admin/BranchWiseReports/LeaveReports/screens/admin_leave_report_screen.dart';
import '../modules/Admin/BranchWiseReports/RegularizationReports/screens/regularization_report_screen.dart';
import '../modules/Employee/Leave/screens/leave_report_list.dart';
import '../modules/Employee/MonthlyAttendanceReport/screens/attendance_report.dart';
import '../modules/Employee/Regularization/screens/applied_reg_list_screen.dart';
import '../modules/Employee/Regularization/screens/apply_reg_screen.dart';
import '../modules/Employee/Report/screens/report_screen.dart';
import '../splash_screen.dart';
import '../modules/Admin/EmployeesAttendanceReport/screens/employee_attendance_report_screen.dart';
import '../modules/Admin/Home/screens/admin_home_screen.dart';
import '../modules/Admin/MonthlyAttendanceReport/screens/monthly_attendance_report_screen.dart';
import '../modules/Admin/TodayAttendanceReport/screens/today_attendance_report_screen.dart';
import '../modules/Admin/WeeklyAttendanceReport/screens/weekly_attendance_report_screen.dart';
import '../modules/CommonScreen/screens/login_screen.dart';
import '../modules/main_screen.dart';
import '../modules/Admin/AddEmployeeByAdmin/screens/add_employee_screen.dart';
import '../modules/Employee/Home/screens/employee_home_screen.dart';



class AppPages {
  static String splashScreen = '/';
  static String latLongScreen = '/HomeScreen';
  static String loginScreen = '/LoginScreen';
  static String adminHomeScreen = '/AdminHomeScreen';
  static String todayAttendanceReportScreen = '/TodayAttendanceReportScreen';
  static String employeeAttendanceReportScreen = '/EmployeeAttendanceReportScreen';
  static String weeklyAttendanceReportScreen = '/WeeklyAttendanceReportScreen';
  static String monthlyAttendanceReportScreen = '/MonthlyAttendanceReportScreen';
  static String employeeHomeScreen = '/EmployeeHomeScreen';
  static String reportScreen = '/ReportScreen';
  static String mainScreen = '/MainScreen';
  static String addEmployeeScreen = '/AddEmployeeScreen';
  static String applyRegularization = '/ApplyRegularization';
  static String empMonthlyAttendanceReport = '/MonthlyAttendanceReport';
  static String empAppliedRegularizationList = '/AppliedRegularizationListScreen';
  static String branchWiseReportScreen = '/BranchWiseReportScreen';
  static String regularizationReportScreen = '/RegularizationReportScreen';
  static String leaveApplyScreen = '/LeaveApplyScreen';
  static String leaveReport = '/LeaveReport';
  static String admin_leave_report_screen = '/AdminLeaveReportScreen';

}


final getPages = [
  GetPage(
    name: AppPages.splashScreen,
    page: () => SplashScreen(),

  ),
  GetPage(
    name: AppPages.loginScreen,
    page: () => LoginScreen(),
  ),
  GetPage(
    name: AppPages.adminHomeScreen,
    page: () => AdminHomeScreen(),
  ),
  GetPage(
    name: AppPages.employeeAttendanceReportScreen,
    page: () => EmployeeAttendanceReportScreen(),
  ),
  GetPage(
    name: AppPages.todayAttendanceReportScreen,
    page: () => TodayAttendanceReportScreen(),
  ),
  GetPage(
    name: AppPages.weeklyAttendanceReportScreen,
    page: () => WeeklyAttendanceReportScreen(),
  ),
  GetPage(
    name: AppPages.monthlyAttendanceReportScreen,
    page: () => MonthlyAttendanceReportScreen(),
  ),GetPage(
    name: AppPages.employeeHomeScreen,
    page: () => EmployeeHomeScreen(),
  ),GetPage(
    name: AppPages.reportScreen,
    page: () =>  ReportScreen(),
  ),GetPage(
    name: AppPages.mainScreen,
    page: () => MainScreen(),
  ),GetPage(
    name: AppPages.addEmployeeScreen,
    page: () => AddEmployeeScreen(),
  ),
  GetPage(
    name: AppPages.applyRegularization,
    page: () => ApplyRegularization(),
  ),
  GetPage(
    name: AppPages.empMonthlyAttendanceReport,
    page: () => MonthlyAttendanceReport(),
  ),
  GetPage(
    name: AppPages.empAppliedRegularizationList,
    page: () =>  AppliedRegularizationListScreen(),
  ),GetPage(
    name: AppPages.branchWiseReportScreen,
    page: () =>  BranchWiseReportScreen(),
  ),GetPage(
    name: AppPages.regularizationReportScreen,
    page: () =>  RegularizationReportScreen(),
  ),GetPage(
    name: AppPages.leaveReport,
    page: () =>  LeaveReport(),
  ),
  GetPage(
    name: AppPages.leaveApplyScreen,
    page: () => LeaveApplyScreen(),
  ), GetPage(
    name: AppPages.admin_leave_report_screen,
    page: () => AdminLeaveReportScreen(),
  ),
];
