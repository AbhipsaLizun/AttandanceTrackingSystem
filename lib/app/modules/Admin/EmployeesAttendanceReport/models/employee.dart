class Employee {
  final int userId;
  final String firstName;
  final String middleName;
  final String lastName;
  final String email;
  final String phone;
  final int branchId;
  final String branchName;
  final double longitude;
  final double latitude;
  final int financialYearId;
  final String? financialYear;
  final DateTime inDateTime;
  final String timeIn;
  final String timeOut;
  final bool present;


  Employee({
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
    this.financialYear,
    required this.inDateTime,
    required this.timeIn,
    required this.timeOut,
    required this.present,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      userId: json['userId'] ?? 0,
      firstName: json['firstName'] ?? '',
      middleName: json['middleName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      branchId: json['branchId'] ?? 0,
      branchName: json['branchName'] ?? '',
      longitude: double.tryParse(json['longitude'] ?? '0.0') ?? 0.0,
      latitude: double.tryParse(json['latitude'] ?? '0.0') ?? 0.0,
      financialYearId: json['financialYearId'] ?? 0,
      financialYear: json['financialYear'],
      inDateTime: DateTime.parse(json['inDateTime'] ?? '1970-01-01T00:00:00'),
      timeIn: json['timeIn'] ?? '',
      timeOut: json['timeOut'] ?? '',
      present: json['present']?.toLowerCase() == 'true',
    );
  }

}
