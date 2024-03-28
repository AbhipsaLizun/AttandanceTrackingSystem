
class MonthlyAttendanceResponse {
  bool isSuccess;
  List<dynamic> errorMessage;
  List<Result> result;
  int totalRecords;

  MonthlyAttendanceResponse({
    required this.isSuccess,
    required this.errorMessage,
    required this.result,
    required this.totalRecords,
  });

  factory MonthlyAttendanceResponse.fromJson(Map<String, dynamic> json) => MonthlyAttendanceResponse(
    isSuccess: json["isSuccess"],
    errorMessage: List<dynamic>.from(json["errorMessage"].map((x) => x)),
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
    totalRecords: json["totalRecords"],
  );

  Map<String, dynamic> toJson() => {
    "isSuccess": isSuccess,
    "errorMessage": List<dynamic>.from(errorMessage.map((x) => x)),
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
    "totalRecords": totalRecords,
  };
}

class Result {
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
  final String inDateTime;
  final String timeIn;
  final String timeOut;
  final String present;
  final double totHrs;

  Result({
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

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    userId: json["userId"] ?? 0,
    firstName: json["firstName"] ?? '',
    middleName: json["middleName"] ?? '',
    lastName: json["lastName"] ?? '',
    email: json["email"] ?? '',
    phone: json["phone"] ?? '',
    branchId: json["branchId"],
    branchName: json["branchName"] ?? '',
    longitude: json["longitude"] ?? '',
    latitude: json["latitude"] ?? '',
    financialYearId: json["financialYearId"] ?? 0,
    financialYear: json["financialYear"] ?? '',
    inDateTime: json["inDateTime"] ?? '',
    timeIn: json["timeIn"] ?? '',
    timeOut: json["timeOut"] ?? '',
    present: json["present"] ?? '',
    totHrs: json["totHrs"]?.toDouble() ?? 0.00,
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "firstName": firstName,
    "middleName": middleName,
    "lastName": lastName,
    "email": email,
    "phone": phone,
    "branchId": branchId,
    "branchName": branchName,
    "longitude": longitude,
    "latitude": latitude,
    "financialYearId": financialYearId,
    "financialYear": financialYear,
    "inDateTime": inDateTime,
    "timeIn": timeIn,
    "timeOut": timeOut,
    "present": present,
    "totHrs": totHrs,
  };
}

// class Result {
//  final int userId;
//  final String firstName;
//  final String middleName;
//  final String lastName;
//  final String email;
//  final String phone;
//  final int branchId;
//  final String branchName;
//  final String longitude;
//  final String latitude;
//  final int financialYearId;
//  final String financialYear;
//  final String inDateTime;
//  final String timeIn;
//  final String timeOut;
//  final String present;
//
//   Result({
//     required this.userId,
//     required this.firstName,
//     required this.middleName,
//     required this.lastName,
//     required this.email,
//     required this.phone,
//     required this.branchId,
//     required this.branchName,
//     required this.longitude,
//     required this.latitude,
//     required this.financialYearId,
//     required this.financialYear,
//     required this.inDateTime,
//     required this.timeIn,
//     required this.timeOut,
//     required this.present,
//   });
//
//   factory Result.fromJson(Map<String, dynamic> json) => Result(
//     userId: json["userId"],
//     firstName: json["firstName"] ?? " ",
//     middleName: json["middleName"] ?? " ",
//     lastName: json["lastName"],
//     email: json["email"] ?? " ",
//     phone: json["phone"] ?? " ",
//     branchId: json["branchId"] ?? " ",
//     branchName: json["branchName"] ?? " ",
//     longitude: json["longitude"] ?? " ",
//     latitude: json["latitude"] ?? " ",
//     financialYearId: json["financialYearId"] ?? " ",
//     financialYear: json["financialYear"] ?? " ",
//     inDateTime: json["inDateTime"] ?? " ",
//     timeIn: json["timeIn"]?? " ",
//     timeOut: json["timeOut"]?? " ",
//     present: json["present"] ?? " ",
//   );
//
//   Map<String, dynamic> toJson() => {
//     "userId": userId,
//     "firstName": firstName,
//     "middleName": middleName,
//     "lastName": lastName,
//     "email": email,
//     "phone": phone,
//     "branchId": branchId,
//     "branchName": branchName,
//     "longitude": longitude,
//     "latitude": latitude,
//     "financialYearId": financialYearId,
//     "financialYear": financialYear,
//     "inDateTime": inDateTime,
//     "timeIn": timeIn,
//     "timeOut": timeOut,
//     "present": present,
//   };
// }