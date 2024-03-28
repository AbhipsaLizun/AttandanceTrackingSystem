class GetRegularizationModel {
  bool isSuccess;
  List<dynamic> errorMessage;
  List<RegResultList> result;
  int totalRecords;

  GetRegularizationModel({
    required this.isSuccess,
    required this.errorMessage,
    required this.result,
    required this.totalRecords,
  });

  factory GetRegularizationModel.fromJson(Map<String, dynamic> json) => GetRegularizationModel(
    isSuccess: json["isSuccess"],
    errorMessage: List<dynamic>.from(json["errorMessage"].map((x) => x)),
    result: List<RegResultList>.from(json["result"].map((x) => RegResultList.fromJson(x))),
    totalRecords: json["totalRecords"],
  );

  Map<String, dynamic> toJson() => {
    "isSuccess": isSuccess,
    "errorMessage": List<dynamic>.from(errorMessage.map((x) => x)),
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
    "totalRecords": totalRecords,
  };
}

class RegResultList {
  int reglarId;
  DateTime fromDate;
  DateTime toDate;
  String remarks;
  String regStatus;
  String regFullStatus;
  DateTime appliedDate;
  DateTime approveRejectDate;
  String reportingManager;
  String reportingManagerRemarks;


  RegResultList({
    required this.reglarId,
    required this.fromDate,
    required this.toDate,
    required this.remarks,
    required this.regStatus,
    required this.regFullStatus,
    required this.appliedDate,
    required this.approveRejectDate,
    required this.reportingManager,
    required this.reportingManagerRemarks,
  });

  factory RegResultList.fromJson(Map<String, dynamic> json) => RegResultList(
    reglarId: json["reglarId"] ?? 0,
    fromDate: DateTime.parse(json["fromDate"]),
    toDate: DateTime.parse(json["toDate"]),
    remarks: json["remarks"] ?? '',
    regStatus: json["regStatus"] ?? '',
    regFullStatus: json["regFullStatus"] ?? '',
    appliedDate: DateTime.parse(json["appliedDate"]),
    approveRejectDate: DateTime.parse(json["approveRejectDate"]),
    reportingManager: json["reportingManager"] ?? '',
    reportingManagerRemarks: json["reportingManagerRemarks"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "reglarId": reglarId,
    "fromDate": fromDate.toIso8601String(),
    "toDate": toDate.toIso8601String(),
    "remarks": remarks,
    "regStatus": regStatus,
    "regFullStatus": regFullStatus,
    "appliedDate": appliedDate.toIso8601String(),
    "approveRejectDate": approveRejectDate.toIso8601String(),
    "reportingManager": reportingManager,
    "reportingManagerRemarks": reportingManagerRemarks,
  };
}