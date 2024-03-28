import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/constants/color_constants.dart';


class SuccessDialog extends StatelessWidget {
  const SuccessDialog({super.key});



  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 64,
            ),
            const SizedBox(height: 16),
            const Text(
              'Success!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Accepted Successfully",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstants.gray100,
                    textStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
              onPressed: () {
                Get.back(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}