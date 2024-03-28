import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../shared/constants/app_text_styles.dart';
import '../../../../shared/constants/color_constants.dart';
import '../controllers/employee_home_controller.dart';

class EmployeeHomeScreen extends StatelessWidget {
  final EmployeeHomeController controller = Get.put(EmployeeHomeController());

  EmployeeHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Obx(() {
      return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            SvgPicture.asset(
              'assets/images/svg/ScreenBG_White.svg',
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification overscroll) {
                  overscroll.disallowIndicator();
                  return true;
                },
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Obx(() => Text(
                            controller.fullname.value,
                            style: AppTextStyles.customTextStyle(
                              color: LightColor.primary,
                              fontSize: screenWidth * 0.06,
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                      Text(
                        controller.currentDate.value,
                        style: AppTextStyles.customTextStyle(
                          color: LightColor.primary,
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      GestureDetector(
                        onTap: controller.imageFile.value != null
                            ? null
                            : () {
                                controller.CheckPermission(true);
                              },
                        child: Container(
                          width: screenHeight * 0.24,
                          height: screenHeight * 0.24,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              end: Alignment.bottomCenter,
                              begin: Alignment.topLeft,
                              colors: [
                                const Color(0xFF1CD1D3).withOpacity(0.2),
                                const Color(0xFF29BFC0).withOpacity(0.9),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(100.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 5.0,
                                offset: const Offset(0.0, 3.0),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(05.0),
                            child: Obx(() {
                              File? selectedImageFile =
                                  controller.imageFile.value;

                              return selectedImageFile != null
                                  ? CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      maxRadius: 100,
                                      child: ClipOval(
                                        child: SizedBox.fromSize(
                                          size: const Size.fromRadius(100),
                                          child: Image.file(
                                            selectedImageFile,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Image.asset(
                                          "assets/images/png/punch.png",
                                          height: screenHeight * 0.13,
                                          width: screenHeight * 0.13,
                                          filterQuality: FilterQuality.high,
                                          fit: BoxFit.fill,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Punch In',
                                          style: AppTextStyles.customTextStyle(
                                            color: LightColor.whitecolor,
                                            fontSize: screenWidth * 0.04,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    );
                            }),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: screenHeight * 0.035,
                            color: LightColor.darkgrey,
                          ),

                          // Image.asset(
                          //   "assets/images/png/location.png",
                          //   height: screenHeight * 0.03,
                          //   width: screenHeight * 0.025,
                          //   filterQuality: FilterQuality.high,
                          //   fit: BoxFit.fill,
                          //   color: LightColor.darkgrey,
                          // ),
                          const SizedBox(
                            width: 10,
                          ),

                          Expanded(
                            child: Text(
                              controller.currentAddress.value,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                color: LightColor.darkgrey,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Visibility(
                        visible: controller.latePunch.value,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.warning,
                              color: Colors.orange,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Late Punch',
                              style: AppTextStyles.customTextStyle(
                                fontSize: screenWidth * 0.04,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                              ),
                            ),
                          ],
                        ),
                      ),
                      punchInOutRectange(screenWidth, screenHeight),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: screenHeight <= 650 ? 00 : screenHeight <= 750  ? 15 : 20,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  punchDetailsWidget(
                    "assets/images/png/punchIn.png",
                    controller.currentTime.value,
                    "Punch In",
                    screenWidth,
                    screenHeight,
                  ),
                  VerticalDivider(
                    color: LightColor.darkgrey.withOpacity(0.2),
                    thickness: 1,
                  ),
                  punchDetailsWidget(
                    "assets/images/png/punchOut.png",
                    controller.punchoutcurrentTime.value,
                    "Punch Out",
                    screenWidth,
                    screenHeight,
                  ),
                  VerticalDivider(
                    color: LightColor.darkgrey.withOpacity(0.2),
                    thickness: 1,
                  ),
                  Obx(() => punchDetailsWidget(
                        "assets/images/png/hour.png",
                        controller.workingHoursRemaining.value,
                        "Working Hrs",
                        screenWidth,
                    screenHeight
                      )),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget punchInOutRectange(double screenWidth, double screenHeight) {
    if (controller.isPunched.value == '') {
      return SizedBox.shrink();
    } else {
      return Column(
        children: [
          const SizedBox(
            height: 20, //! Sizedbox height = 60
          ),
          FractionallySizedBox(
            widthFactor: 0.7,
            // heightFactor: 2,
            child: ElevatedButton(
              onPressed: () async {
                if (controller.isPunched.value == 'Yes') {
                  // For Punch Out
                  print('punchout');
                  // await controller.submitPunch(false);
                  controller.CheckPermission(false);
                } else {
                  print('punchin');
                  // For Punch in
                  //controller.CheckPermission();
                  await controller.CheckPermission(true);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: LightColor.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.011,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/png/punch.png",
                      height: screenHeight * 0.025,
                      width: screenHeight * 0.02,
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.fill,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      controller.isPunched.value == 'Yes'
                          ? 'Punch Out'
                          : 'Punch In',
                      style: AppTextStyles.customTextStyle(
                        color: LightColor.whitecolor,
                        fontSize: screenHeight * 0.02,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      );
    }
  }

  Widget punchDetailsWidget(
      String image, String time, String status, double screenWidth, double screeHeight) {
    return Container(
      // height: 90,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Image.asset(
            image,
            height: screeHeight <= 650 ? screenWidth * 0.055 : screeHeight * 0.04,
            width: screeHeight <= 650 ? screenWidth * 0.055 : screeHeight * 0.04  ,
            //filterQuality: FilterQuality.high,
            fit: BoxFit.fill,
          ),
          SizedBox(
            height: screeHeight <= 650 ? 7 : 9,
          ),
          Text(
            time,
            style: AppTextStyles.customTextStyle(
              fontSize:
              screeHeight <= 650 ? screenWidth * 0.029 : screeHeight * 0.015,
              fontWeight: FontWeight.w600,
              color: LightColor.darkgrey,
            ),
          ),
          SizedBox(
            height: screeHeight <= 650 ? 5 : 7,
          ),
          Text(
            status,
            style: AppTextStyles.customTextStyle(
              fontSize:
              screeHeight <= 650 ? screenWidth * 0.024 : screeHeight * 0.015,
              fontWeight: FontWeight.w600,
              color: LightColor.darkgrey,
            ),
          ),
        ],
      ),
    );
  }
}
