class ApiEndPoints {

  ///Basic Auth
  static const String username = '';
  static const String password = '';

  // Common base URL
  static const String commonBaseUrl = 'http://3.111.234.227/api';

  // API endpoints with the common base URL
  static const String userBaseUrl = '$commonBaseUrl/User/';
  static const String branchBaseUrl = '$commonBaseUrl/Branch/';
  static const String financialYearBaseUrl = '$commonBaseUrl/FinancialYear/';
  static const String companyBaseUrl = '$commonBaseUrl/Company/';
  static const String attendanceReportBaseUrl = '$commonBaseUrl/Attendance/';
  static const String CommonBaseUrl = '$commonBaseUrl/Common/';
  static const String AttendanceBaseUrl = '$commonBaseUrl/Attendance/';
  static const String RolesBaseUrl = '$commonBaseUrl/Roles/';
  static const String getAttandanceForUserLocYearInDateUrl = '$commonBaseUrl/Common/';
  static const String regularizationsBaseUrl = '$commonBaseUrl/Regularizations/';

/*  //Base URL
  static final String UserBaseUrl = '$ApiBaseUrl/User/';
  static final String BranchBaseUrl = '$ApiBaseUrl/Branch/';
  static final String FinancialYearBaseUrl = '$ApiBaseUrl/FinancialYear/';*/

  static AuthEndPoints authEndpoints = AuthEndPoints();
  static const String defaultDatetime= "1900-01-01T00:00:00.000";

}

///Apis
///
class AuthEndPoints {
  static const String validLoginUser = 'ValidLoginUser?';
  static const String getBranchsByCompany = 'GetBranchsByCompany?';
  static const String getCompanyDetails = 'GetCompanyDetails?';
  static const String checkInCheckOutHistory = 'checkIncheckOuthistory?';
  static const String getReportingManager = 'GetReportingManager?';
  static const String addRegularizationDetails = 'AddRegularizationDetails';
  static const String getCheckInOutByIDWithHour = 'GetCheckInOutByIDWithHour?';
  static const String checkIncheckOutDayWeekMonth = 'checkIncheckOutDayWeekMonth?';
  static const String getRegulizationByID = 'GetRegulizationByID?';
  static const String AddUserDetails = 'AddUserDetails';
  static const String GetBranchWiseEmployee = 'GetBranchWiseEmployee';
  static const String GetAttendanceByDate = 'GetAttendanceByDate';
  static const String GetRoleDetails = 'GetRoleDetails';
  static const String GetCheckInOutByIDWithHour = 'GetCheckInOutByIDWithHour';
  static const String Forgotpassword = 'Forgotpassword';
  static const String addAtendance  = 'AddAttendance';
  static const String getAttandanceForUserLocYearInDate  = 'GetAttandanceForUserLocYearInDate?';

}
