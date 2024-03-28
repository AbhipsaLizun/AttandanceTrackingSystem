import 'user.dart';

class LoginResponse {
  final bool isSuccess;
  final List<String> errorMessage;
  final User? result;

  LoginResponse({
    required this.isSuccess,
    required this.errorMessage,
    this.result,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      isSuccess: json['isSuccess'],
      errorMessage: List<String>.from(json['errorMessage']),
      result: json['result'] != null ? User.fromJson(json['result']) : null,
    );
  }
}