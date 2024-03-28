import 'package:attendance_system/app/shared/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../shared/widgets/no_recor_widget.dart';
import '../controllers/regularization_reportScreen_controller.dart';

class RegularizationReportScreen extends StatelessWidget {
  final RegularizationReportScreenController regularizationReportScreenController =
  Get.put(RegularizationReportScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Regularization Report'),
      ),
      body: DefaultTabController(
        length: regularizationReportScreenController.tabs.length,
        child: Builder(
          builder: (BuildContext context) {
            return Column(
              children: [
                Obx(() {
                  return Container(
                    width: double.infinity,
                    child: Material(
                      elevation: 4, // Adjust the elevation as needed
                      child: TabBar(
                        isScrollable: true,
                        tabs: regularizationReportScreenController.tabs.map((String tab) {
                          return Tab(text: tab);
                        }).toList(),
                        indicatorColor: LightColor.primary,
                        labelColor: LightColor.primary,
                        unselectedLabelColor: Colors.grey,
                      ),
                    ),
                  );
                }),
                Expanded(
                  child: TabBarView(
                    children: regularizationReportScreenController.tabs.map((String tab) {
                      return _buildListTab(tab);
                    }).toList(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildListTab(String tabName) {
    return Center(
      child: NoRecordWidget(
        errorMessage: 'No record found',
      ),
    );
  }
}
Color getColorForRegStatus(String regFullStatus) {
  switch (regFullStatus) {
    case 'Pending':
      return Colors.orange.withOpacity(0.5);
    case 'Approved':
      return Colors.green.withOpacity(0.5);
    case 'Cancel':
      return Colors.red.withOpacity(0.5);
    case 'Reject':
      return Colors.red;
    case 'Hold':
      return Colors.yellow.withOpacity(0.5);
    default:
      return Colors.grey;
  }
}
