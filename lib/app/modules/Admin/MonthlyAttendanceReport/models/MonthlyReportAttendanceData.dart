import 'package:intl/intl.dart';

class MonthlyReportAttendanceData {
  final int userId;
  final String firstName;
  final String middleName;
  final String lastName;
  final String email;
  final String phone;
  final int branchId;
  final String branchName;
  final String longitude;
  final String latitude;
  final int financialYearId;
  final String financialYear;
  final DateTime inDateTime;
  final DateTime timeIn;
  final DateTime timeOut;
  final bool present;
  final double totHrs;

  MonthlyReportAttendanceData({
    required this.userId,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.branchId,
    required this.branchName,
    required this.longitude,
    required this.latitude,
    required this.financialYearId,
    required this.financialYear,
    required this.inDateTime,
    required this.timeIn,
    required this.timeOut,
    required this.present,
    required this.totHrs,
  });

  factory MonthlyReportAttendanceData.fromJson(Map<String, dynamic> json) {
    return MonthlyReportAttendanceData(
      userId: json['userId'] ?? 0,
      firstName: json['firstName'] ?? '',
      middleName: json['middleName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      branchId: json['branchId'] ?? 0,
      branchName: json['branchName'] ?? '',
      longitude: json['longitude'] ?? '',
      latitude: json['latitude'] ?? '',
      financialYearId: json['financialYearId'] ?? 0,
      financialYear: json['financialYear'] ?? '',
      inDateTime: parseDateTime(json['inDateTime']) ?? DateTime(0),
      timeIn: parseDateTime(json['timeIn']) ?? DateTime(0),
      timeOut: parseDateTime(json['timeOut']) ?? DateTime(0),
      present: json['present'] == 'true',
      totHrs: json['totHrs'] ?? 0.0,
    );
  }
}

DateTime? parseDateTime(String? dateTimeString) {
  if (dateTimeString != null && dateTimeString.isNotEmpty) {
    try {
      // Try parsing with the first format
      final format1 = DateFormat("MM/dd/yyyy HH:mm:ss");
      return format1.parse(dateTimeString);
    } catch (e) {
      // If parsing fails, try the second format
      final format2 = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
      return format2.parse(dateTimeString);
    }
  }
  return null;
}
