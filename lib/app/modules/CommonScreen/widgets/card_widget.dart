import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/constants/app_text_styles.dart';
import '../../../shared/constants/color_constants.dart';
import '../controllers/login_controller.dart';

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
          child: Column(
            children: [
              CardCustomization(
                loginController: loginController,
                title: 'Let’s Set Up Fast-Login!',
                subtitle: 'Please enter account details below',
              ),
              SizedBox(height: loginController.screenHeight * 0.02),
              CustomInputField(
                loginController: loginController,
                controller: loginController.usernameController,
                hintText: 'Username',
              ),
              SizedBox(height: loginController.screenHeight * 0.02),
              CustomInputField(
                loginController: loginController,
                controller: loginController.passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
              SizedBox(height: loginController.screenHeight * 0.02),
              ForgotPasswordText( loginController: loginController,),
              SizedBox(height: loginController.screenHeight * 0.02),
              CustomElevatedButton(onPressed: loginController.submitForm,loginController:loginController),
            ],
          ),
        ),
      ),
    );
  }
}

class CardCustomization extends StatelessWidget {
  final LoginController loginController;
  final String title;
  final String subtitle;

  const CardCustomization({super.key, 
    required this.loginController,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: AppTextStyles.customTextStyle(
            fontSize: loginController.screenHeight * 0.02,
            color: LightColor.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: loginController.screenHeight * 0.005),
        Text(
          subtitle,
          style: AppTextStyles.customTextStyle(
            fontSize: loginController.screenHeight * 0.018,
            color: LightColor.primary,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

class CustomInputField extends StatelessWidget {
  final LoginController loginController;

  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const CustomInputField({super.key, 
    required this.loginController,

    required this.controller,
    required this.hintText,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: LightColor.fadedPrimary,
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: LightColor.textcolor),
          prefixIcon: const Icon(Icons.person, color: LightColor.primary),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: loginController.screenWidth * 0.03,
          ),
          errorStyle: TextStyle(
            fontSize: loginController.screenHeight * 0.015,
            fontWeight: FontWeight.w500,
            color: LightColor.red,
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
        obscureText: obscureText,
      ),
    );
  }
}

class ForgotPasswordText extends StatelessWidget {

  final LoginController loginController;


  const ForgotPasswordText({super.key, 
    required this.loginController,

  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          'Forgot password?',
          style: AppTextStyles.customTextStyle(
            fontSize: loginController.screenHeight * 0.018,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final LoginController loginController;

  const CustomElevatedButton({super.key, required this.onPressed, required this. loginController});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1.0,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: LightColor.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(loginController.screenWidth * 0.015),
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
    );
  }
}
