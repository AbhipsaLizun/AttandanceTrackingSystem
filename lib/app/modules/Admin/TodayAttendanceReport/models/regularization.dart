class Regularization {

  final int reglarId;
  final DateTime fromDate;
  final DateTime toDate;
  final String remarks;
  final String regStatus;
  final String regFullStatus;
  final DateTime appliedDate;
  final DateTime approveRejectDate;
  final String reportingManager;
  final int reportingManagerId;
  final String reportingManagerRemarks;

  Regularization({
    required this.reglarId,
    required this.fromDate,
    required this.toDate,
    required this.remarks,
    required this.regStatus,
    required this.regFullStatus,
    required this.appliedDate,
    required this.approveRejectDate,
    required this.reportingManager,
    required this.reportingManagerId,
    required this.reportingManagerRemarks,
  });

  factory Regularization.fromJson(Map<String, dynamic> json) {
    return Regularization(
      reglarId: json['reglarId'] ?? 0,
      fromDate: DateTime.parse(json['fromDate']),
      toDate: DateTime.parse(json['toDate']),
      remarks: json['remarks'] ?? "",
      regStatus: json['regStatus'] ?? "",
      regFullStatus: json['regFullStatus'] ?? "",
      appliedDate: DateTime.parse(json['appliedDate']),
      approveRejectDate: DateTime.parse(json['approveRejectDate']),
      reportingManager: json['reportingManager'] ?? "",
      reportingManagerId: json['reportingManagerId'] ?? 0,
      reportingManagerRemarks: json['reportingManagerRemarks'] ?? "",
    );
  }
}

