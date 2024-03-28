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
  String checkIn;
  String timeIn;
  String timeOut;
  String hours;
  String firstIn;
  String lastOut;
  String isPunch;

  Result({
    required this.userId,
    required this.checkIn,
    required this.timeIn,
    required this.timeOut,
    required this.hours,
    required this.firstIn,
    required this.lastOut,
    required this.isPunch,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    userId: json["userId"] ?? 0,
    checkIn: json["checkIn"] ?? "",
    timeIn: json["timeIn"] ?? "",
    timeOut: json["timeOut"] ?? "",
    hours: json["hours"] ?? "",
    firstIn: json["firstIn"] ?? "",
    lastOut: json["lastOut"] ?? "",
    isPunch: json["isPunch"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "checkIn": checkIn,
    "timeIn": timeIn,
    "timeOut": timeOut,
    "hours": hours,
    "firstIn": firstIn,
    "lastOut": lastOut,
    "isPunch": isPunch,
  };
}
