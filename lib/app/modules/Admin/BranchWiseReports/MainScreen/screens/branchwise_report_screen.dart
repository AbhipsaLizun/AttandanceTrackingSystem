import 'package:attendance_system/app/shared/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Home/controllers/admin_home_screen_controller.dart';
import '../controllers/branchwise_report_screen_controller.dart';

class BranchWiseReportScreen extends StatelessWidget {

  final BranchWiseReportController controller =
      Get.put(BranchWiseReportController());

  final AdminHomeScreenController adminHomeScreenController =
      Get.find<AdminHomeScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            adminHomeScreenController.selectedBranchName.value + ' Reports'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
          ),
          itemCount: controller.icons.length,
          itemBuilder: (context, index) {
            print(index);
            return GestureDetector(
              onTap: () {
                if(index==0){
                  Get.toNamed('/RegularizationReportScreen');
                }else if(index==1){
                  Get.toNamed('/AdminLeaveReportScreen');
                }
              },
              child: Obx(() => Card(
                    elevation: 7.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(
                        color: controller.cardColors[index],
                        width: 2.0,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(controller.icons[index],
                              size: 48.0, color: controller.cardColors[index]),
                          SizedBox(height: 8.0),
                          Text(
                            controller.texts[index],
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  )),
            );
          },
        ),
      ),
    );
  }
}
