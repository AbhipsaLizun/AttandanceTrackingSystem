import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart'as http;
import '../models/branch.dart';
import '../../../../ApiServices/api_end_points.dart';

class AdminHomeScreenController extends GetxController {

  RxList<Branch> branches = <Branch>[].obs;
  RxBool isSuccess = false.obs;
  final box = GetStorage();
  final RxString selectedBranchName = ''.obs;
  final RxString selectedBranchId = ''.obs;
  RxString adminName = ''.obs;



  @override
  void onInit() {
    super.onInit();
    adminName.value = box.read("firstName")+" "+ box.read("middleName")+" "+ box.read("lastName");
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