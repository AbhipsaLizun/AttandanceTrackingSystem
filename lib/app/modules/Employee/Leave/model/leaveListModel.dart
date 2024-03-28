// To parse this JSON data, do
//
//     final leaveListModel = leaveListModelFromJson(jsonString);

import 'dart:convert';

LeaveListModel leaveListModelFromJson(String str) => LeaveListModel.fromJson(json.decode(str));

String leaveListModelToJson(LeaveListModel data) => json.encode(data.toJson());

class LeaveListModel {
  String? fromDate;
  String? toDate;
  String? status;

  LeaveListModel({
    required this.fromDate,
    required this.toDate,
    required this.status,
  });



  factory LeaveListModel.fromJson(Map<dynamic, dynamic> json) => LeaveListModel(
    fromDate: json["fromDate"] ?? "",
    toDate: json["toDate"] ?? "",
    status: json["status"] ?? "",
  );

  Map<dynamic, dynamic> toJson() => {
    "fromDate": fromDate,
    "toDate": toDate,
    "status": status,
  };
}
