import 'package:get/get.dart';

import '../models/employee.dart';

class EmployeeAttendanceStatusController extends GetxController {
 // final RxString selectedLocation = ''.obs;

  final RxList<Employee> employees = <Employee>[].obs;
  

  Future<void> fakeLoading() async {
    await Future.delayed(const Duration(seconds: 2));
  }

  // @override
  // void onInit() {
  //   super.onInit();
  //   // Load employee data here or use an API call
  // }
}

