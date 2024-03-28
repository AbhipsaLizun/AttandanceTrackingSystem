import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../constants/app_text_styles.dart';

class NoRecordWidget extends StatelessWidget {
  final String errorMessage;

  NoRecordWidget({required this.errorMessage});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          'assets/lottie/no_record.json',
          fit: BoxFit.contain,
          repeat:false ,
          height: 220,
          width: 250,
        ),
        Text(
          errorMessage,
          style: AppTextStyles.customTextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
