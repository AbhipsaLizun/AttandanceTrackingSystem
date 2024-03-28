import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../shared/constants/app_text_styles.dart';
import '../../../shared/constants/color_constants.dart';
import '../controllers/login_controller.dart';

class LoginScreen extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());

  LoginScreen({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              height: loginController.screenHeight,
              width: loginController.screenWidth,
              child: SvgPicture.asset(
                'assets/images/svg/ScreenBG.svg',
                fit: BoxFit.cover,
              ),
            ),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Column(
                  children: [
                    SizedBox(height: loginController.screenHeight * 0.1),
                    Image.asset(
                      'assets/images/png/splash_image.png',
                      height: loginController.screenHeight * 0.2,
                    ),
                    SizedBox(height: loginController.screenHeight * 0.02),
                    Text(
                      'Attendance Tracking',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.customTextStyle(
                        color: Colors.white,
                        fontSize: loginController.screenWidth * 0.06,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: loginController.screenHeight * 0.01),
                    Text(
                      'System',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.customTextStyle(
                        color: Colors.white,
                        fontSize: loginController.screenWidth * 0.06,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: loginController.screenHeight * 0.02),
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: CardWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final LoginController loginController = Get.find();

  CardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(loginController.screenWidth * 0.03),
        child: Form(
          key: loginController.formKey,
          child: AutofillGroup(
            child: Column(
              children: [
                Column(
                  children: [
                    Text(
                      'Let’s Set Up Fast-Login!',
                      style: AppTextStyles.customTextStyle(
                        fontSize: loginController.screenHeight * 0.02,
                        color: LightColor.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: loginController.screenHeight * 0.005),
                    Text(
                      'Please enter account details below',
                      style: AppTextStyles.customTextStyle(
                        fontSize: loginController.screenHeight * 0.018,
                        color: LightColor.primary,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: loginController.screenHeight * 0.02),
                Container(
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(15),
                    // color: LightColor.fadedPrimary,
                  ),
                  child: TextFormField(
                    controller: loginController.usernameController,
                    autofillHints: [AutofillHints.username],
                    decoration: InputDecoration(
                      hintText: 'Username',
                      filled: true,
                      fillColor: LightColor.fadedPrimary,
                      hintStyle: const TextStyle(
                        color: LightColor.textcolor,
                      ),
                      prefixIcon:
                          const Icon(Icons.person, color: LightColor.primary),
                      border: InputBorder.none,
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      //contentPadding: EdgeInsets.only(bottom: 3),
                      errorStyle: TextStyle(
                        fontSize: loginController.screenHeight * 0.015,
                        fontWeight: FontWeight.w500,
                        color: LightColor.red,
                        // inherit: true
                        // wordSpacing: 1
                      ),
                    ),
                    style: AppTextStyles.customTextStyle(
                      fontSize: loginController.screenHeight * 0.018,
                      fontWeight: FontWeight.normal,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Username cannot be empty';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: loginController.screenHeight * 0.02),
                Container(
                  decoration: BoxDecoration(
                    //borderRadius: BorderRadius.circular(15),
                   // color: LightColor.fadedPrimary,
                  ),
                  child: Obx(() => TextFormField(
                    autofillHints: [AutofillHints.password],
                        controller: loginController.passwordController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: LightColor.fadedPrimary,
                          hintText: 'Password',
                          hintStyle: const TextStyle(color: LightColor.textcolor),
                          prefixIcon:
                              const Icon(Icons.lock, color: LightColor.primary),
                          border: InputBorder.none,
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                          /*contentPadding: EdgeInsets.symmetric(
                        horizontal: loginController.screenWidth * 0.03,
                      ),*/
                          errorStyle: TextStyle(
                            fontSize: loginController.screenHeight * 0.015,
                            fontWeight: FontWeight.w500,
                            color: LightColor.red,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              loginController.isPasswordVisible.value =
                                  !loginController.isPasswordVisible.value;
                            },
                            child: Icon(
                              loginController.isPasswordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: LightColor.primary,
                            ),
                          ),
                        ),
                        obscureText: !loginController.isPasswordVisible.value,
                        style: AppTextStyles.customTextStyle(
                          fontSize: loginController.screenHeight * 0.018,
                          fontWeight: FontWeight.normal,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password cannot be empty';
                          }
                          return null;
                        },
                      )),
                ),
                SizedBox(height: loginController.screenHeight * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: (){
                        loginController.openForgotPasswordDialog(); // Open the dialog
                      },
                      child: Text(
                        'Forgot password?',
                        style: AppTextStyles.customTextStyle(
                          fontSize: loginController.screenHeight * 0.020,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: loginController.screenHeight * 0.02),
                FractionallySizedBox(
                  widthFactor: 1.0,
                  child: ElevatedButton(
                    onPressed: loginController.submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: LightColor.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.all(loginController.screenWidth * 0.015),
                      child: Text(
                        'Login',
                        style: AppTextStyles.customTextStyle(
                          fontSize: loginController.screenHeight * 0.02,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

