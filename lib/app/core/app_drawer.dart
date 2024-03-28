import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../shared/constants/color_constants.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({super.key});

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    var roleName = box.read('roleName') ?? '';
    return Drawer(
      width: 230,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  height: 150,
                  color: LightColor.primary, // Set the background color here
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.asset(
                        'assets/images/png/logo.png',
                        width: 130,
                        height: 130,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                buildDrawerItem(Icons.home, 'Home', () {
                  // Add functionality for Home
                  Get.back();
                }),

                if (roleName == 'ADM') ...[
                  SizedBox.shrink(),
                ] else ...[
                  const Divider(height: 1, color: Colors.grey),
                  buildDrawerItem(Icons.list, 'Applied Regularization List',
                      () {
                    Get.toNamed("/AppliedRegularizationListScreen");
                    //Get.back();
                  }),
                ],



                const Divider(height: 1, color: Colors.grey),


                if (roleName == 'User') ...[
                  const Divider(height: 1, color: Colors.grey),
                  buildDrawerItem(Icons.list, 'Leave Report',
                          () {
                        Get.toNamed("/LeaveReport");
                        //Get.back();
                      }),
                ] else ...[
                const SizedBox.shrink(),
                ],

                // buildDrawerItem(Icons.list, 'Leave Report',
                //         () {
                //       Get.toNamed("/LeaveReport");
                //       //Get.back();
                //     }),


              const Divider(height: 1, color: Colors.grey),

                buildDrawerItem(Icons.terminal_sharp, 'Terms & Condition', () {
                  // Add functionality for Home
                  Get.back();
                }),
                const Divider(height: 1, color: Colors.grey),
                buildDrawerItem(Icons.info, 'About Us', () {
                  // Add functionality for Home
                  Get.back();
                }),
                const Divider(height: 1, color: Colors.grey),

                // Add more drawer items as needed
              ],
            ),
          ),
          const Divider(height: 1, color: Colors.grey),
          // Add a divider before the Logout item
          buildLogoutItem(context),
        ],
      ),
    );
  }

  Widget buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      horizontalTitleGap: 1,
      // contentPadding:EdgeInsets.zero,
      title: Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
      onTap: onTap,
    );
  }

  Widget buildLogoutItem(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.logout,
        color: Colors.red,
      ),
      title: const Text(
        'Logout',
        style: TextStyle(fontSize: 16, color: Colors.red),
      ),
      onTap: () {
        showLogoutConfirmationDialog(context);

        //  Implement logout functionality here
        // For example, you can show a confirmation dialog and log the user out.
      },
    );
  }

  void showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                box.erase();

                // Perform logout functionality here
                // For example, clear user data and navigate to the login screen.
                // Get.offAll("/LoginScreen") ;// Close the dialog
                Get.offAllNamed("/LoginScreen"); // Close the dialog
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}
