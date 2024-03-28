

class DailyCheckInOutResponse {
  bool isSuccess;
  List<dynamic> errorMessage;
  List<ResultResponse> result;
  int totalRecords;

  DailyCheckInOutResponse({
    required this.isSuccess,
    required this.errorMessage,
    required this.result,
    required this.totalRecords,
  });

  factory DailyCheckInOutResponse.fromJson(Map<String, dynamic> json) => DailyCheckInOutResponse(
    isSuccess: json["isSuccess"],
    errorMessage: List<dynamic>.from(json["errorMessage"].map((x) => x)),
    result: List<ResultResponse>.from(json["result"].map((x) => ResultResponse.fromJson(x))),
    totalRecords: json["totalRecords"],
  );

  Map<String, dynamic> toJson() => {
    "isSuccess": isSuccess,
    "errorMessage": List<dynamic>.from(errorMessage.map((x) => x)),
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
    "totalRecords": totalRecords,
  };
}

class ResultResponse {
  final int userId;
  final DateTime checkIn;
  final String timeIn;
  final String timeOut;
  final String hours;
  final String firstIn;
  final String lastOut;
  final DateTime totHr;

  ResultResponse({
    required this.userId,
    required this.checkIn,
    required this.timeIn,
    required this.timeOut,
    required this.hours,
    required this.firstIn,
    required this.lastOut,
    required this.totHr,
  });

  factory ResultResponse.fromJson(Map<String, dynamic> json) => ResultResponse(
    userId: json["userId"] ?? 0,
    checkIn: DateTime.parse(json["checkIn"]),
    timeIn: json["timeIn"] ?? "",
    timeOut: json["timeOut"] ?? "",
    hours: json["hours"] ?? "",
    firstIn: json["firstIn"] ?? "",
    lastOut: json["lastOut"] ?? "",
    totHr: DateTime.parse(json["totHr"]),
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "checkIn": "${checkIn.year.toString().padLeft(4, '0')}-${checkIn.month.toString().padLeft(2, '0')}-${checkIn.day.toString().padLeft(2, '0')}",
    "timeIn": timeIn,
    "timeOut": timeOut,
    "hours": hours,
    "firstIn": firstIn,
    "lastOut": lastOut,
    "totHr": totHr.toIso8601String(),
  };
}