class ReportingManager {
  final int userID;
  final String firstName;
  final String lastName;

  ReportingManager({
    required this.userID,
    required this.firstName,
    required this.lastName,
  });

  factory ReportingManager.fromJson(Map<String, dynamic> json) {
    return ReportingManager(
      userID: json['userID'],
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }
}
