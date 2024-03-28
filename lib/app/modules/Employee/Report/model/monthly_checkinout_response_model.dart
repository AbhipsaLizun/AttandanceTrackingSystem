
class MonthlyCheckInOutResponse {
  bool isSuccess;
  List<dynamic> errorMessage;
  List<MonthlyResult> result;
  int totalRecords;

  MonthlyCheckInOutResponse({
    required this.isSuccess,
    required this.errorMessage,
    required this.result,
    required this.totalRecords,
  });

  factory MonthlyCheckInOutResponse.fromJson(Map<String, dynamic> json) => MonthlyCheckInOutResponse(
    isSuccess: json["isSuccess"],
    errorMessage: List<dynamic>.from(json["errorMessage"].map((x) => x)),
    result: List<MonthlyResult>.from(json["result"].map((x) => MonthlyResult.fromJson(x))),
    totalRecords: json["totalRecords"],
  );

  Map<String, dynamic> toJson() => {
    "isSuccess": isSuccess,
    "errorMessage": List<dynamic>.from(errorMessage.map((x) => x)),
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
    "totalRecords": totalRecords,
  };
}

class MonthlyResult {
  int attendanceId;
  int userId;
  int branchId;
  String checkIn;
  String checkOut;
  int financialYearId;
  String inDateTime;
  String latitude;
  String longitude;
  int reportingManagerId;
  String totalHours;
  String delFlg;
  String reportingMangName;
  String branchName;
  String email;
  String userName;
  String reportMangEmail;
  String fYear;
  bool presentStatus;

  MonthlyResult({
    required this.attendanceId,
    required this.userId,
    required this.branchId,
    required this.checkIn,
    required this.checkOut,
    required this.financialYearId,
    required this.inDateTime,
    required this.latitude,
    required this.longitude,
    required this.reportingManagerId,
    required this.totalHours,
    required this.delFlg,
    required this.reportingMangName,
    required this.branchName,
    required this.email,
    required this.userName,
    required this.reportMangEmail,
    required this.fYear,
    required this.presentStatus,
  });

  factory MonthlyResult.fromJson(Map<String, dynamic> json) => MonthlyResult(
    attendanceId: json["attendanceId"] ?? 0,
    userId: json["userId"] ?? 0,
    branchId: json["branchId"] ?? 0,
    checkIn: json["checkIn"] ?? "",
    checkOut: json["checkOut"] ?? "",
    financialYearId: json["financialYearId"] ?? 0,
    inDateTime: json["inDateTime"] ?? "",
    latitude: json["latitude"]  ?? "",
    longitude: json["longitude"] ?? "",
    reportingManagerId: json["reportingManagerId"] ?? 0,
    totalHours: json["totalHours"] ?? "",
    delFlg: json["del_Flg"] ?? "",
    reportingMangName: json["reportingMangName"] ?? "",
    branchName: json["branchName"] ?? "",
    email: json["email"] ?? "",
    userName: json["userName"] ?? "",
    reportMangEmail: json["reportMangEmail"] ?? "",
    fYear: json["fYear"] ?? "",
    presentStatus: json["presentStatus"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "attendanceId": attendanceId,
    "userId": userId,
    "branchId": branchId,
    "checkIn": checkIn,
    "checkOut": checkOut,
    "financialYearId": financialYearId,
    "inDateTime": inDateTime,
    "latitude": latitude,
    "longitude": longitude,
    "reportingManagerId": reportingManagerId,
    "totalHours": totalHours,
    "del_Flg": delFlg,
    "reportingMangName": reportingMangName,
    "branchName": branchName,
    "email": email,
    "userName": userName,
    "reportMangEmail": reportMangEmail,
    "fYear": fYear,
    "presentStatus": presentStatus,
  };
}