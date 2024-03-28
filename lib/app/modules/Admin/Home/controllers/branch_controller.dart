import 'dart:convert';
import 'package:attendance_system/app/ApiServices/api_end_points.dart';
import 'package:http/http.dart'as http;
import 'package:get/get.dart';

import '../models/branch.dart';

class BranchController extends GetxController {
  RxList<Branch> branches = <Branch>[].obs;
  RxBool isSuccess = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchBranches(); // Fetch data when the controller is initialized
  }

  Future<void> fetchBranches() async {

    //final url = Uri.parse('http://192.168.5.70:7221/api/Branch/GetBranchsByCompany?CmpId=1');
    final url = Uri.parse('${ApiEndPoints.branchBaseUrl}${AuthEndPoints.getBranchsByCompany}CmpId=1'
        //'GetBranchsByCompany?CmpId=1'
    );
    final response = await http.post(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      branches.assignAll((data['result'] as List).map((item) => Branch.fromJson(item)));
    } else {
      throw Exception('Failed to load data');
      //throw Exception('Failed to load data');
    }
  }
}