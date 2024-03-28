class Branch {
//  final bool isSuccess;
  final int branchId;
  final String branchName;
  final String branchDesc;

  Branch({
  //  required this.isSuccess,
    required this.branchId,
    required this.branchName,
    required this.branchDesc,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
   //   isSuccess: json['isSuccess'],
      branchId: json['branchId'],
      branchName: json['branchName'],
      branchDesc: json['branchDesc'],
    );
  }
}