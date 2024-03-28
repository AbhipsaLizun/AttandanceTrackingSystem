import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/constants/color_constants.dart';
import 'rejected_dialog.dart';
import 'success_dialog.dart';


class RoundedDialog extends StatelessWidget {
  const RoundedDialog({super.key});

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

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'From Date',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "02-09-2023",
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Center(
                          child: Icon(
                            Icons.calendar_month,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
           const  SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'To Date',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ), 
                  child:const  Padding(
                    padding:  EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "30-09-2023",
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Center(
                          child: Icon(
                            Icons.calendar_month,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20,),
            Container(
              // height: 30,
              width: double.infinity,
              //height: 100,
              decoration: const BoxDecoration(
                  color: LightColor.primary, // Customize the color
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              padding: const EdgeInsets.all(16),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Reason",
                    style: TextStyle(
                        fontSize: 15,
                        color: LightColor.whitecolor,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 20,),
                  Text(
                    "Presentation about the design system",
                    style: TextStyle(
                        fontSize: 15,
                        color: LightColor.whitecolor,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.dialog(
                            const SuccessDialog()); // Show the custom dialog
                      },
                      child: Container(
                        // height: 30,
                        width: 60,
                        height: 30,
                        decoration: const BoxDecoration(
                            color: Colors.green,
                            // Customize the color
                        ),
                        padding: const EdgeInsets.all(4),
                        child: const Center(
                          child: Text(
                            'Accept',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: (){
                        Get.dialog(
                            const RejectedDialog());
                      },
                      child: Container(
                        // height: 30,
                        width: 60,
                          height: 30,
                        decoration: const BoxDecoration(
                            color: Colors.red, // Customize the color
                            ),
                        padding: const EdgeInsets.all(4),
                        child: const Center(
                          child: Text(
                            'Reject',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),

                SizedBox(
                  height: 30,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstants.gray100,
                        textStyle: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                    onPressed: () {
                      Get.back(); // Close the dialog
                    },
                    child: const Text('Close'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
