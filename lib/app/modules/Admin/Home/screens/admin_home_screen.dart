import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../core/app_drawer.dart';
import '../../../../shared/constants/app_text_styles.dart';
import '../../../../shared/constants/color_constants.dart';
import '../../../CommonScreen/controllers/login_controller.dart';
import '../../Widgets/custom_grid_item.dart';
import '../controllers/admin_home_screen_controller.dart';

class AdminHomeScreen extends StatelessWidget {
  final AdminHomeScreenController adminHomeScreenController =
      Get.put(AdminHomeScreenController());

  AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: AppDrawer(),
      body: DoubleBackToCloseApp(
        snackBar: SnackBar(
          content: Text(
            'Tap back again to leave',
            style: AppTextStyles.customTextStyle(
              color: Colors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background Image
            SvgPicture.asset(
              'assets/images/svg/ScreenBG_White.svg',
              fit: BoxFit.cover,
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image at the top
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(
                      // height: 30,
                      //  width: c_width,
                      decoration: const BoxDecoration(
                          color: LightColor.primary, // Customize the color
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      padding: const EdgeInsets.all(8),
                      child: Center(
                        child: Text(
                          "Oasys Tech Solutions Pvt Ltd",
                          style: AppTextStyles.customTextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  //Text('Welcome Debendra'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Welcome ${adminHomeScreenController.adminName.value}',
                   //'Welcome Debendra',
                    style: AppTextStyles.customTextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: LightColor.primary,
                    ),
                  ),
                  Text(
                    'Stay up to date with what your doing',
                    style: AppTextStyles.customTextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: LightColor.primary,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Two text widgets vertically below the image
                  Row(
                    children: [
                      Text(
                        'Office Locations',
                        style: AppTextStyles.customTextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: LightColor.textcolor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Obx(() {
                    if (adminHomeScreenController.branches.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return Expanded(
                        child: GridView.builder(
                          itemCount: adminHomeScreenController.branches.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            final branch =
                                adminHomeScreenController.branches[index];
                            return GestureDetector(
                              onTap: () {
                                adminHomeScreenController.selectedBranchName
                                    .value = branch.branchName;
                                adminHomeScreenController.selectedBranchId
                                    .value = branch.branchId.toString();
                                Get.toNamed("/EmployeeAttendanceReportScreen");
                              },
                              child: CustomGridItem(
                                title: branch.branchName,
                                imageUrl:
                                    'assets/images/png/location_bg.png', // Replace with your image path
                              ),
                            );
                          },
                        ),
                      );
                    }
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
