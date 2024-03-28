class Branch {
  final int branchId;
  final String branchName;
  final String latitude;
  final String longitude;

  Branch({required this.branchId, required this.branchName, required this.latitude, required this.longitude});

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      branchId: json['branchId'],
      branchName: json['branchName'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}