import 'dart:convert';
import 'dart:io';

import 'package:attendance_system/app/modules/Admin/AddEmployeeByAdmin/models/branch.dart';
import 'package:attendance_system/app/shared/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../../ApiServices/api_end_points.dart';
import '../../../../shared/widgets/custom_error_dialog.dart';
import '../../../../shared/widgets/custom_loading_dialog.dart';
import '../../../../shared/widgets/custom_success_dialog.dart';
import '../../EmployeesAttendanceReport/controllers/employee_attendance_report_screen_controller.dart';
import '../../Home/controllers/admin_home_screen_controller.dart';
import '../models/company.dart';
import '../models/financial_year.dart';
import '../models/reporting_manager.dart';
import '../models/role.dart';

class AddEmployeeScreenController extends GetxController {
  //Add Emp by id controller
/*
  final AddEmployeeScreenController addEmployeeController =
  Get.find<AddEmployeeScreenController>();
*/

  double screenHeight = 0.0;
  double screenWidth = 0.0;
  final _formKey = GlobalKey<FormState>();

  // var branches = <Branch>[].obs;
  RxList<Branch> branches = <Branch>[].obs;
  RxList<Company> companies = <Company>[].obs;
  RxList<ReportingManager> reportingManagers = <ReportingManager>[].obs;

// Make branches an observable list

  var financialyears = <FinancialYear>[].obs;

  GlobalKey<FormState> get formKey => _formKey;
  final selectedBranch = Rx<Branch?>(null);
  final selectedFinancialYear = Rx<FinancialYear?>(null);
  final selectedReportingManager = Rx<ReportingManager?>(null);
  final selectedCompany = Rx<Company?>(null);

  var roles = <Role>[].obs;
  final selectedRole = Rx<Role?>(null);

  final firstNameController = TextEditingController();
  final middleNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final confirmEmailController = TextEditingController();
  final alternativeEmailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final confirmPhoneNumberController = TextEditingController();
  final alternativePhoneNumberController = TextEditingController();
  final addressController = TextEditingController();
  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  var pickedImage = Rx<File?>(null);

  final AdminHomeScreenController adminHomeScreenController =
      Get.find<AdminHomeScreenController>();

  @override
  void onInit() {
    super.onInit();
    updateScreenSize();
    //fetchBranches();
    fetchFinancialYears();
    fetchRoles();
    fetchReportingManagers();
    //fetchCompanies();
  }

  void updateScreenSize() {
    screenHeight = Get.height;
    screenWidth = Get.width;
  }

  void submitForm() async {
    if(pickedImage.value != null){
      if (_formKey.currentState!.validate() ) {
        // Show a loading dialog
        Get.dialog(
          const CustomLoadingDialog(message: 'Registering ...'),
          barrierDismissible: false,
        );
        DateTime now = DateTime.now().toLocal();
        String formattedDate =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(now);
        print(formattedDate);

        try {
          // Create a map with the form data to be sent in the request
          final Map<String, dynamic> formData = {
            "userID": 0,
            "loginID": usernameController.text,
            "pwd": passwordController.text, // Add password here
            "firstName": firstNameController.text,
            "middleName": middleNameController.text,
            "lastName": lastNameController.text,
            "email": emailController.text,
            "emailConfiremed": confirmEmailController.text,
            "alternativeEmail": alternativeEmailController.text,
            "phone": phoneNumberController.text,
            "phoneConfirmed": confirmPhoneNumberController.text,
            "alternativePhone": alternativePhoneNumberController.text,
            "address1": addressController.text,
            "companyName": 'Oasys Technology',
            "FinancialYearId": selectedFinancialYear.value!.financialYearId,
            "companyId": 1,
            "roleId": selectedRole.value!.roleId,
            "reportingMangId": selectedReportingManager.value!.userID,
            "accountId": 0,
            "imageID": 0,
            "branchId": adminHomeScreenController.selectedBranchId.value,
            "lastLoginDate": '2023-11-02T09:42:33.469Z',
            "lockedDate": '2023-11-02T09:42:33.469Z',
            "lockedEnable": 'N',
            "loginFailure": 0,
            "created_By": 'admin',
            "created_On": formattedDate,
            "modified_By": 'admin',
            "modified_On": formattedDate,
            "profilePictureURL": '',
            "twoFactorEnable": '',
            "paymentID": 0,
            "remarks": '',
            "del_Flg": 'N',
          };
          final String jsonBody = jsonEncode(formData);
          //var jsonBody = json.encode(formData);

          // Set the 'Content-Type' header to 'application/json'
          final Map<String, String> headers = {
            'Content-Type': 'application/json; charset=UTF-8',
          };

          var response = await http.post(
              Uri.parse(
                  '${ApiEndPoints.userBaseUrl}${AuthEndPoints.AddUserDetails}'),
              headers: headers,
              body: jsonBody,
              encoding: Encoding.getByName("utf-8"));
          if (response.statusCode == 200) {
            final data = json.decode(response.body);
            if (data['isSuccess']) {
              // Registration was successful, handle the response as needed
              final result = data['result'];
              String resultAsString = result.toString();
              final EmployeeAttendanceReportScreenController empCtl =
              Get.find<EmployeeAttendanceReportScreenController>();
              empCtl.fetchEmployeeData();

              // Close the loading dialog
              Get.back();

              Future.delayed(Duration.zero, () {
                Get.dialog(
                  CustomSuccessDialog(
                    title: "Success",
                    message: "Registration successful",
                  ),
                );
              });
              //  Get.back();
            } else {
              Get.back();
              // Registration failed, handle the error
              final errorMessage = data['errorMessage'];
              // You can display the error message to the user.
              Get.dialog(
                CustomErrorDialog(
                  title: 'Error',
                  message: errorMessage.join('\n'),
                ),
              );
            }
          } else {
            Get.back();
            // Handle other HTTP status codes if needed
            // You can show an error message to the user.
            Get.dialog(
              CustomErrorDialog(
                title: 'Error',
                message: 'Failed to register. Please try again.',
              ),
            );
          }
        } catch (e) {
          Get.back();
          // Handle network or other errors
          // You can show an error message to the user.
          Get.dialog(
            CustomErrorDialog(
              title: 'Error',
              message: 'An error occurred. Please try again.',
            ),
          );
        } finally {
          // Close the loading dialog
          Get.back();
        }
      }
    }else{
      CustomToast.showToast("Uplaod Profile picture First",backgroundColor: Colors.red);
    }




  }

  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _updateProfilePhoto(File(pickedFile.path));
    } else {
      // User canceled the picker
      pickedImage.value = null;

      print("discard gallery by user");
      Get.back();
    }
  }

  Future<void> _pickImageFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      // Do something with the captured image, for example, set it to the profile photo.
      _updateProfilePhoto(File(pickedFile.path));
    } else {
      // User canceled the picker
      print("discard camera by user");
      pickedImage.value = null;
      Get.back();
    }
  }

  void _updateProfilePhoto(File imageFile) {
    pickedImage.value = imageFile;
    update();
    Get.back();
  }

  showPhotoPicker() {
    Get.bottomSheet(
        backgroundColor: Colors.white,
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text(
                'Pick from Gallery',
                style: TextStyle(color: Colors.black),
              ),
              onTap: _pickImageFromGallery,
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text(
                'Capture Image',
                style: TextStyle(color: Colors.black),
              ),
              onTap: _pickImageFromCamera,
            ),
          ],
        ));
  }

  Future<void> fetchFinancialYears() async {
    var response = await http.post(
      Uri.parse('${ApiEndPoints.financialYearBaseUrl}GetFinancialYears?Id=0'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final branchList = (data['result'] as List)
          .map((item) => FinancialYear.fromJson(item))
          .toList();
      financialyears.assignAll(branchList);
    }
  }

  Future<void> fetchRoles() async {
    final response = await http.post(Uri.parse(
        '${ApiEndPoints.RolesBaseUrl}${AuthEndPoints.GetRoleDetails}?roleid=0'));
/*
    final url = Uri.parse(
        '${ApiEndPoints.RolesBaseUrl}${AuthEndPoints.GetRoleDetails}CmpId=0');
*/

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final roleList =
          (data['result'] as List).map((item) => Role.fromJson(item)).toList();
      roles.assignAll(roleList);
    }
  }

  Future<void> fetchCompanies() async {
    final url = Uri.parse(
        '${ApiEndPoints.companyBaseUrl}${AuthEndPoints.getCompanyDetails}CmpId=0');
    final response = await http.post(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final companyList = (data['result'] as List)
          .map((item) => Company.fromJson(item))
          .toList();
      companies.assignAll(companyList);
    }
  }

  Future<void> fetchBranches(int companyId) async {
    branches.clear();
    var response = await http.post(Uri.parse(
        '${ApiEndPoints.branchBaseUrl}GetBranchsByCompany?CmpId=$companyId'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final branchList = (data['result'] as List)
          .map((item) => Branch.fromJson(item))
          .toList();
      branches.assignAll(branchList);
    }
  }

  Future<void> fetchReportingManagers() async {
    //reportingManagers.clear();
    var response = await http.post(Uri.parse(
        '${ApiEndPoints.CommonBaseUrl}GetReportingManager?BranchId=${adminHomeScreenController.selectedBranchId.value.toString()}'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final managerList = (data['result'] as List)
          .map((item) => ReportingManager.fromJson(item))
          .toList();
      reportingManagers.assignAll(managerList);
    }
  }
}
