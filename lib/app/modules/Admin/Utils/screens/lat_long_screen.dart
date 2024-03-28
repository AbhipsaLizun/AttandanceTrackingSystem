
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../shared/constants/app_text_styles.dart';
import '../../../../shared/constants/color_constants.dart';
import '../controllers/lat_long_screen_controller.dart';

class LatLongScreen extends StatelessWidget {

  final LatLongScreenController homeScreenController =
      Get.put(LatLongScreenController());

   LatLongScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.scaffoldBackground,
      // Set your desired background color
      // resizeToAvoidBottomInset: true,
      // backgroundColor: Colors.white,
      appBar: AppBar(
          title: Text(
            "Home Screen",
            style: AppTextStyles.titleStyle(context),
          ),
          // titleSpacing: 0,
          elevation: 2,
          automaticallyImplyLeading: true,
          backgroundColor: const Color.fromARGB(255, 148, 73, 73),
          // systemOverlayStyle: SystemUiOverlayStyle.dark,
          surfaceTintColor: Colors.transparent),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              if 
              //(homeScreenController.currentPosition.value == null ||
                  (homeScreenController.currentPosition.value.latitude == 0 &&
                      homeScreenController.currentPosition.value.longitude ==
                          0)
                        //  ) 
                          {
                return const CircularProgressIndicator();
              }
              return Text(
                'Latitude: ${homeScreenController.currentPosition.value.latitude}\n'
                'Longitude: ${homeScreenController.currentPosition.value.longitude}',
                textAlign: TextAlign.center,
              );
            }),
          ],
        ),
      ),
    );
  }
}
