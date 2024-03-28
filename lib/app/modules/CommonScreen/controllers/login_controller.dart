import 'dart:async';
import 'dart:convert';
import 'package:attendance_system/app/shared/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pin_input_text_field/pin_input_text_field.dart';
import '../../../ApiServices/api_end_points.dart';
import '../../../shared/widgets/custom_loading_dialog.dart';
import '../../../shared/widgets/custom_toast.dart';
import '../models/login_response.dart';

class LoginController extends GetxController {

  double screenHeight = 0.0;
  double screenWidth = 0.0;
  final formKey = GlobalKey<FormState>();
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  final RxBool isPasswordVisible = false.obs;
  final box = GetStorage();
  final RxBool isLoading = false.obs;
  var showResendButton = false.obs;
  var resendTimer = 30.obs; // Add this line to define the resendTimer variable

  @override
  void onInit() {
    super.onInit();
    updateScreenSize();
    usernameController = TextEditingController();
    passwordController = TextEditingController();

    // Enable autofill for username and password fields
    SystemChannels.textInput.invokeMethod('TextInput.setClientFeatures', <String, dynamic>{
      'setAuthenticationConfiguration': true,
      'setAutofillHints': <String>[
        AutofillHints.username,
        AutofillHints.password,
      ],
    });

  }

  void updateScreenSize() {
    screenHeight = Get.height;
    screenWidth = Get.width;
  }

  Future<void> submitForm() async {
    if (formKey.currentState!.validate()) {
      try {
        Get.dialog(
          const CustomLoadingDialog(message: 'Logging in...'),
          barrierDismissible: false,
        );
/*
        final url = Uri.parse(
            'http://192.168.5.70:7221/api/User/ValidLoginUser?LoginId=${usernameController.text}&Pwd=${passwordController.text}');
*/
        var response = await http.post(
          Uri.parse('${ApiEndPoints.userBaseUrl}ValidLoginUser?LoginId=${usernameController.text}&Pwd=${passwordController.text}'),
        );

       // final response = await http.post(url);
         // Uri.parse('${ApiEndPoints.userBaseUrl}ValidLoginUser?LoginId=${usernameController.text}&Pwd=${passwordController.text}');

        // final response = await http.post(url);

        if (response.statusCode == 200) {

          //var jsonRes = json.decode(response.body);

          final Map<String, dynamic> data = json.decode(response.body);
          final loginResponse = LoginResponse.fromJson(data);

          // ignore: avoid_print
          print(loginResponse);

          //  Get.offAllNamed('/MainScreen');

          if (loginResponse.isSuccess == true) {
            final user = loginResponse.result!;
            box.write("userId", user.userID);
            box.write("firstName", user.firstName);
            box.write("middleName", user.middleName);
            box.write("lastName", user.lastName);
            box.write("reportingMangId", user.reportingMangId);
            box.write("financialYearId", user.financialYearId);
            box.write("latitude", user.latitude);
            box.write("longitude", user.longitude);
            box.write("branchId", user.branchId);
            box.write("roleName", user.roleName);
            //  Get.snackbar('Success', 'Logged in as ${user.firstName}');
            CustomToast.showToast('Success: Logged in as ${user.firstName}',
                backgroundColor: Colors.green);
            if (user.roleId == 1) {
              box.write('LoginType', "Admin");

              Get.offAllNamed('/AdminHomeScreen');
            } else{
              Get.offAllNamed('/MainScreen');

            }




            /*else if (user.roleId == 2) {
              box.write('LoginType', "User");

              Get.offAllNamed('/MainScreen');
            } else if (user.roleId == 3) {
              box.write('LoginType', "Hr");

              Get.offAllNamed('/MainScreen');
            }else if (user.roleId == 4) {
              box.write('LoginType', "RM");

              Get.offAllNamed('/MainScreen');
            }else if (user.roleId == 5) {
              box.write('LoginType', "DM");

              Get.offAllNamed('/MainScreen');
            }*/
          } else {
            CustomToast.showToast('Error: Invalid credentials',
                backgroundColor: Colors.red);
          }
        } else {
          Get.snackbar('Error', 'Failed to connect to the server');
        }
      } catch (e) {
        Get.snackbar('Error', 'An error occurred: $e');
      } finally {
        Get.back();
      }
    }
  }

  void openForgotPasswordDialog() {
    final TextEditingController forgotPasswordUsernameController =
        TextEditingController();
    Get.defaultDialog(
      title: 'Forgot Password?',
      barrierDismissible: false,
      content: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: forgotPasswordUsernameController,
              decoration: const InputDecoration(
                labelText: 'Enter your username',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.back(); // Cancel button, dismisses the dialog
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: LightColor.red200),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    final forgotPasswordUsername =
                        forgotPasswordUsernameController.text;
                    if (forgotPasswordUsername.isEmpty) {
                      CustomToast.showToast('Username cannot be empty');
                    } else {
                      sendForgotPasswordRequest(forgotPasswordUsername);
                    }
                  },
                  child: const Text('Verify'),
                ),
              ],
            ),
          ),
          // Show a circular progress indicator when loading
        ],
      ),
    );
  }

  Future<void> sendForgotPasswordRequest(String username) async {
    try {
      Get.dialog(
        const CustomLoadingDialog(message: 'Please wait...'),
        barrierDismissible: false,
      );
      final url = Uri.parse(
          '${ApiEndPoints.userBaseUrl}${AuthEndPoints.Forgotpassword}?LoginID=$username');
      final response = await http.post(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final isSuccess = data['isSuccess'];
        if (isSuccess == true) {
          CustomToast.showToast('OTP sent successfully to registered email');
          Get.back();
          showOTPDialog();
        } else {
          Get.back();

          CustomToast.showToast('Username doesn\'t exist');
        }
      } else {
        CustomToast.showToast('Failed to connect to the server');
      }
    } catch (e) {
      CustomToast.showToast('An error occurred: $e');
    }
  }

  void showOTPDialog() {
    String otp = '';

    Get.defaultDialog(
      title: 'OTP Verification',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: LightColor.primary),
              // Adjust border color
              borderRadius: BorderRadius.circular(8.0), // Adjust border radius
            ),
            child: PinInputTextField(
              pinLength: 6,
              decoration: BoxTightDecoration(),
              controller: TextEditingController(),
              autoFocus: true,
              textInputAction: TextInputAction.done,
              onChanged: (pin) {
                otp = pin;
              },
            ),
          ),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (otp.length == 6) {

                } else {
                  Get.snackbar(
                    'Error',
                    'Please enter all 6 digits of the OTP.',
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              },
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              child: const Text('Verify'),
            ),
          ],
        ),
        Container(
          alignment: Alignment.centerRight,
          child: Obx(() {
            return showResendButton.value
                ? TextButton(
                    onPressed: () {
                      // Implement resend logic here
                      // resendOtp();
                      showResendButton.value = false;
                      startResendTimer();
                    },
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.green),
                    ),
                    child: const Text('Resend'),
                  )
                : Text('Resend in ${resendTimer.value} seconds');
          }),
        ),
      ],
    );

    // Start the initial timer
    startResendTimer();
  }

  void showEmptyOtpSnackbar() {
    Get.snackbar(
      '',
      'Please enter OTP',
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
      colorText: Colors.white,
      backgroundColor: Colors.black,
      borderRadius: 10,
      margin: const EdgeInsets.all(16),
      animationDuration: const Duration(milliseconds: 500),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInBack,
      overlayBlur: 5,
      overlayColor: Colors.black.withOpacity(0.5),
    );
  }

  void showInvalidOtpSnackbar() {
    Get.snackbar(
      'Invalid OTP',
      'The entered OTP is invalid. Please enter a valid 6-digit OTP.',
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
      colorText: Colors.white,
      backgroundColor: Colors.red,
      borderRadius: 10,
      margin: const EdgeInsets.all(16),
      animationDuration: const Duration(milliseconds: 500),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInBack,
      overlayBlur: 5,
      overlayColor: Colors.black.withOpacity(0.5),
    );
  }

  void showIncorrectOtpSnackbar() {
    Get.snackbar(
      '',
      'Wrong OTP',
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
      colorText: Colors.white,
      backgroundColor: Colors.black,
      borderRadius: 10,
      margin: const EdgeInsets.all(16),
      animationDuration: const Duration(milliseconds: 500),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInBack,
      overlayBlur: 5,
      overlayColor: Colors.black.withOpacity(0.5),
    );
  }

  void startResendTimer() {
    const duration = Duration(seconds: 30);
    Timer(duration, () {
      showResendButton.value = true;
    });

    // Update the timer every second
    Timer.periodic(const Duration(seconds: 1), (timer) {
      resendTimer.value = duration.inSeconds - timer.tick;
      if (timer.tick == duration.inSeconds) {
        timer.cancel();
      }
    });
  }

  @override
  void onClose() {
    usernameController.dispose(); // Dispose of the controller
    passwordController.dispose(); // Dispose of the controller

    // Disable autofill when user logs out
    SystemChannels.textInput.invokeMethod('TextInput.clearClientFeatures');

    super.onClose();
  }
}
/*
class OtpTextField extends StatelessWidget {
  final int numberOfFields;
  final Color borderColor;
  final bool showFieldAsBox;
  final Function(String) onCodeChanged;
  final Function(String) onSubmit;

  OtpTextField({
    required this.numberOfFields,
    required this.borderColor,
    required this.showFieldAsBox,
    required this.onCodeChanged,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      length: numberOfFields,
      obscureText: false,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 40,
        activeFillColor: Colors.white,
        activeColor: borderColor,
        inactiveColor: Colors.grey,
        selectedColor: borderColor,
      ),
      onChanged: onCodeChanged,
      onCompleted: (code) {
        if (code.length == numberOfFields) {
          onSubmit(code);
        } else {
          // Show an error message or take appropriate action for invalid OTP length
          // For example, you can display a snackbar or toast message
          Get.snackbar(
            'Error',
            'Please enter a $numberOfFields-digit OTP.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      },
    );
  }
}
*/
