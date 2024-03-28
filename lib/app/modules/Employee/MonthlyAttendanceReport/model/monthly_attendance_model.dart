class AttendanceModel {
  String? date;
  String? status;
  String? punchIn;
  String? punchOut;
  String? edit;

  AttendanceModel({
    required this.date,
    required this.status,
    required this.punchIn,
    required this.punchOut,
    required this.edit,
  });

  AttendanceModel copy({
    String? date,
    String? status,
    String? punchIn,
    String? punchOut,
    String? edit,
  }) =>
      AttendanceModel(
        date: date ?? this.date,
        status: status ?? this.status,
        punchIn: punchIn ?? this.punchIn,
        punchOut: punchOut ?? this.punchOut,
        edit: edit ?? this.edit,
      );
}
