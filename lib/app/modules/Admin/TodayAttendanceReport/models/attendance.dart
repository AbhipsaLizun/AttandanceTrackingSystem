class Attendance {
  final int userId;
  final DateTime checkIn;
  final String timeIn;
  final String timeOut;
  final String hours;

  Attendance({
    required this.userId,
    required this.checkIn,
    required this.timeIn,
    required this.timeOut,
    required this.hours,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      userId: json['userId'] ?? 0,
      checkIn: DateTime.parse(json['checkIn'] ?? '1970-01-01'),
      timeIn: json['timeIn'] ?? '',
      timeOut: json['timeOut'] ?? '',
      hours: json['hours'] ?? '',
    );
  }
}