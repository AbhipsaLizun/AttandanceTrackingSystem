// To parse this JSON data, do
//
//     final userDetailsModel = userDetailsModelFromJson(jsonString);

import 'dart:convert';

UserDetailsModel userDetailsModelFromJson(String str) => UserDetailsModel.fromJson(json.decode(str));

String userDetailsModelToJson(UserDetailsModel data) => json.encode(data.toJson());

class UserDetailsModel {
  bool isSuccess;
  List<dynamic> errorMessage;
  List<Result> result;
  int totalRecords;

  UserDetailsModel({
    required this.isSuccess,
    required this.errorMessage,
    required this.result,
    required this.totalRecords,
  });

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) => UserDetailsModel(
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
  int userId;
  DateTime checkIn;
  String timeIn;
  String timeOut;
  String hours;
  int branchId;
  String branchName;
  int financialYearId;
  String longitude;
  String latitude;

  Result({
    required this.userId,
    required this.checkIn,
    required this.timeIn,
    required this.timeOut,
    required this.hours,
    required this.branchId,
    required this.branchName,
    required this.financialYearId,
    required this.longitude,
    required this.latitude,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    userId: json["userId"],
    checkIn: DateTime.parse(json["checkIn"]),
    timeIn: json["timeIn"],
    timeOut: json["timeOut"],
    hours: json["hours"],
    branchId: json["branchId"],
    branchName: json["branchName"]!,
    financialYearId: json["financialYearId"],
    longitude: json["longitude"],
    latitude: json["latitude"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "checkIn": "${checkIn.year.toString().padLeft(4, '0')}-${checkIn.month.toString().padLeft(2, '0')}-${checkIn.day.toString().padLeft(2, '0')}",
    "timeIn": timeIn,
    "timeOut": timeOut,
    "hours": hours,
    "branchId": branchId,
    "branchName": branchName,
    "financialYearId": financialYearId,
    "longitude": longitude,
    "latitude": latitude,
  };
}

