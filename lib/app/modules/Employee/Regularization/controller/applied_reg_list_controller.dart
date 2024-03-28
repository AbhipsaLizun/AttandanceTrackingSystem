
import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../../../../ApiServices/api_end_points.dart';
import '../model/applied_list_model.dart';

class AppliedRegularizationListController extends GetxController{

  final box = GetStorage();
  RxInt userid = 0.obs;
  RxBool isLoading = false.obs;
  RxString errorMsg = ''.obs;
  RxString fromDate = ''.obs;
  RxString toDate = ''.obs;
  RxList<RegResultList> appliedRegResultList = <RegResultList>[].obs;


  @override
  void onInit() {
    super.onInit();
    print("URL....");
    fetchRegularizationAppliedList();
  }



  Future<List<RegResultList>> fetchRegularizationAppliedList() async {
    userid.value = box.read("userId");

    print("USER....$userid");

    isLoading.value = true;

    //http://3.111.234.227/api/Regularizations/GetRegulizationByID?UserId=4

    try{
      var response = await http.post(
        Uri.parse('${ApiEndPoints.regularizationsBaseUrl}${AuthEndPoints.getRegulizationByID}UserId=${userid.value}'),
      );
      var url = '${ApiEndPoints.regularizationsBaseUrl}${AuthEndPoints.getRegulizationByID}UserId=${userid.value}';
      print("URL....$url");
      print("RES....${response.statusCode}");

      if(response.statusCode == 200){
        isLoading.value = false;
        var jsonResponse = json.decode(response.body);
        final isSuccess = jsonResponse['isSuccess'];
        if(isSuccess){
          var data = GetRegularizationModel.fromJson(jsonResponse);
          appliedRegResultList.value = data.result;


          print("'List..${appliedRegResultList[0].reglarId.toString()}");
        }else{
          errorMsg.value = "No Data Found";
        }
      }else {
        throw Exception('Unexpected error occured!');
      }
    }catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }finally{
      isLoading.value = false;
    }




    return appliedRegResultList;

  }

}