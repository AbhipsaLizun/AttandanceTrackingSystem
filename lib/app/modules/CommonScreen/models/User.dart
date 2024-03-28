class User {
  final int userID;
  final String loginID;
  final String firstName;
  final String middleName;
  final String lastName;
  final String email;
  final String emailConfirmed;
  final String alternativeEmail;
  final String phone;
  final String phoneConfirmed;
  final String alternativePhone;
  final String address1;
  final String companyName;
  final int companyId;
  final int roleId;
  final int reportingMangId;
  final String roleName;
  final int accountId;
  final int imageID;
  final int branchId;
  final String lastLoginDate;
  final String lockedDate;
  final String lockedEnable;
  final int loginFailure;
  final String createdBy;
  final String createdOn;
  final String modifiedBy;
  final String modifiedOn;
  final String profilePictureURL;
  final String twoFactorEnable;
  final int paymentID;
  final String remarks;
  final String delFlag;
  final String stateName;
  final String countryName;
  final String branchName;
  final String longitude;
  final String latitude;
  final String fYear;
  final int financialYearId;

  User({
    required this.userID,
    required this.loginID,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.email,
    required this.emailConfirmed,
    required this.alternativeEmail,
    required this.phone,
    required this.phoneConfirmed,
    required this.alternativePhone,
    required this.address1,
    required this.companyName,
    required this.companyId,
    required this.roleId,
    required this.reportingMangId,
    required this.roleName,
    required this.accountId,
    required this.imageID,
    required this.branchId,
    required this.lastLoginDate,
    required this.lockedDate,
    required this.lockedEnable,
    required this.loginFailure,
    required this.createdBy,
    required this.createdOn,
    required this.modifiedBy,
    required this.modifiedOn,
    required this.profilePictureURL,
    required this.twoFactorEnable,
    required this.paymentID,
    required this.remarks,
    required this.delFlag,
    required this.stateName,
    required this.countryName,
    required this.branchName,
    required this.longitude,
    required this.latitude,
    required this.fYear,
    required this.financialYearId
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userID: json['userID'] ?? 0,  // Default to 0 if null
      loginID: json['loginID'] ?? '',  // Default to an empty string if null
      firstName: json['firstName'] ?? '',  // Default to an empty string if null
      middleName: json['middleName'] ?? '',  // Default to an empty string if null
      lastName: json['lastName'] ?? '',  // Default to an empty string if null
      email: json['email'] ?? '',  // Default to an empty string if null
      emailConfirmed: json['emailConfirmed'] ?? '',  // Default to an empty string if null
      alternativeEmail: json['alternativeEmail'] ?? '',  // Default to an empty string if null
      phone: json['phone'] ?? '',  // Default to an empty string if null
      phoneConfirmed: json['phoneConfirmed'] ?? '',  // Default to an empty string if null
      alternativePhone: json['alternativePhone'] ?? '',  // Default to an empty string if null
      address1: json['address1'] ?? '',  // Default to an empty string if null
      companyName: json['companyName'] ?? '',  // Default to an empty string if null
      companyId: json['companyId'] ?? 0,  // Default to 0 if null
      roleId: json['roleId'] ?? 0,
      reportingMangId: json['reportingMangId'] ?? 0,// Default to 0 if null
      roleName: json['roleName'] ?? '',  // Default to an empty string if null
      accountId: json['accountId'] ?? 0,  // Default to 0 if null
      imageID: json['imageID'] ?? 0,  // Default to 0 if null
      branchId: json['branchId'] ?? 0,  // Default to 0 if null
      lastLoginDate: json['lastLoginDate'] ?? '',  // Default to an empty string if null
      lockedDate: json['lockedDate'] ?? '',  // Default to an empty string if null
      lockedEnable: json['lockedEnable'] ?? '',  // Default to an empty string if null
      loginFailure: json['loginFailure'] ?? 0,  // Default to 0 if null
      createdBy: json['created_By'] ?? '',  // Default to an empty string if null
      createdOn: json['created_On'] ?? '',  // Default to an empty string if null
      modifiedBy: json['modified_By'] ?? '',  // Default to an empty string if null
      modifiedOn: json['modified_On'] ?? '',  // Default to an empty string if null
      profilePictureURL: json['profilePictureURL'] ?? '',  // Default to an empty string if null
      twoFactorEnable: json['twoFactorEnable'] ?? '',  // Default to an empty string if null
      paymentID: json['paymentID'] ?? 0,  // Default to 0 if null
      remarks: json['remarks'] ?? '',  // Default to an empty string if null
      delFlag: json['del_Flg'] ?? '',  // Default to an empty string if null
      stateName: json['statesName'] ?? '',  // Default to an empty string if null
      countryName: json['countryName'] ?? '',  // Default to an empty string if null
      branchName: json['branchName'] ?? '',  // Default to an empty string if null
      longitude: json['longitude'] ?? '',  // Default to an empty string if null
      latitude: json['latitude'] ?? '',  // Default to an empty string if null
      fYear: json['fYear'] ?? '',  // Default to an empty string if null
      financialYearId : json['financialYearId'] ?? 0,  // Default to an empty string if null
    );
  }
}