import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../ApiServices/api_end_points.dart';
import '../../../../shared/widgets/custom_loading_dialog.dart';
import '../../../../shared/widgets/custom_toast.dart';
import '../models/employee_details_model.dart';

class EmployeeHomeController extends GetxController {
  final box = GetStorage();

  RxString fullname = "".obs;

  double totalHeight = MediaQuery.of(Get.context!).size.height;
  double totalWidth = MediaQuery.of(Get.context!).size.width;

  double screenHeight = 0.0;
  double screenWidth = 0.0;

  RxBool iSPunched = false.obs;

  //Fetch lat-long
  UserDetailsModel? employeeDetailsModel;
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  Position? currentPosition;
  bool showPunchOutButton =
      false; // Added to control Punch Out button visibility

  final ImagePicker _ppicker = ImagePicker();

  // File? imageFile;
  var imageFile = Rx<File?>(null);

  RxString? fileName = " ".obs;

  RxList<Result> employeeTodaysDetailsList = <Result>[].obs;

  RxString currentDate = "".obs;

  //RxString currentAddress = ''.obs;
  RxString currentAddress = "".obs;

  var currentIndex = 0.obs;
  RxString currentTime = "00.00".obs;
  RxString punchoutcurrentTime = "00.00".obs;
  RxString workingHours = "00:00".obs;

/*  final double officeLatitude = 12.9716; // Replace with your office latitude
  final double officeLongitude = 77.5946; // Replace with your office longitude*/
  final double officeLat = 20.3149254; // Specify your office's latitude here;
  final double officeLong = 85.8214418; // Specify your office's longitude here;
  // 20.315310729513804, 85.82143321423696
  late StreamSubscription<Position> positionStreamSubscription;
  RxBool showWarning = false.obs;
  RxBool showPunchInWarning = false.obs;
  RxBool latePunch = false.obs; // Flag for late punch
  // RxString workingHoursRemaining = "00:00".obs;

  // late Timer workingHourTimer;
  // final Duration initialWorkingHours = const Duration(hours: 9);
  // late Duration targetWorkingHours;
  void changePage(int index) {
    currentIndex.value = index;
  }

  //late Duration remainingWorkingHours;
  final storage = GetStorage();
  RxString workingHoursRemaining = '00:00:00'.obs;

  // late Timer workingHourTimer;
  Timer? workingHourTimer = Timer(Duration.zero, () {});

  Duration targetWorkingHours = Duration(hours: 9);
  late Duration remainingWorkingHours;

  RxString isPunched = ''.obs;

  @override
  void onInit() {
    super.onInit();
    updateCurrentDate();
    // final box = GetStorage();
    getFullName();

    //fetchUserDetails();
    // startWorkingHourTimer();
    targetWorkingHours = Duration(hours: 9);

    String? imagePath = storage.read("selectedImageFilePath");

    if (imagePath != null) {
      imageFile.value = File(imagePath);
    }

    //  imageFile.value = (storage.read("imageFile") ?? "") as File?;
    //imageFile.value = storage.read("imageFile") ?? "";

    print(box.read("userId"));
  }

  @override
  void onClose() {
    workingHourTimer?.cancel();
    super.onClose();
  }

  Future<void> fetchUserDetails() async {
    Future.delayed(Duration.zero, () {
      Get.dialog(
        const CustomLoadingDialog(message: 'Please wait ...'),
        barrierDismissible: false,
      );
    });

    final todayDate = formatter.format(DateTime.now());

    var response = await http.post(
      Uri.parse(
          '${ApiEndPoints.attendanceReportBaseUrl}${AuthEndPoints.getCheckInOutByIDWithHour}InputDate=${todayDate}&UId=${box.read("userId")}&FinYear=${box.read("financialYearId")}&BranchId=${box.read("branchId")}'),
    );

    try {
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['isSuccess'] == true) {
          Get.back();
          employeeDetailsModel = UserDetailsModel.fromJson(data);

          print(employeeDetailsModel!.result.length);
          employeeTodaysDetailsList.value = employeeDetailsModel!.result;
          // calculate first punch in
          if (employeeTodaysDetailsList.isNotEmpty) {
            String isPunch = employeeTodaysDetailsList.first.isPunch;
            isPunched.value = isPunch;

            String firstInTime =
                extractTime(employeeTodaysDetailsList.first.firstIn.toString());

            String lastOut =
                extractTime(employeeTodaysDetailsList.first.lastOut.toString());

            // startWorkingHourTimer();

            if (firstInTime == "00:00" && lastOut == "00:00") {
              // Both firstInTime and lastOut are 00:00
              updateCurrentTime(firstIn: "00:00");
              updatePunchoutCurrentTime(lastOut: "00:00");
            } else if (firstInTime == "00:00") {
              // Only firstInTime is 00:00
              updateCurrentTime(firstIn: "00:00");
              updatePunchoutCurrentTime(lastOut: lastOut);
              //startWorkingHourTimer(firstInTime, lastOut, isPunched);
            } else if (lastOut == "00:00") {
              // Only lastOut is 00:00
              updatePunchoutCurrentTime(lastOut: "00:00");
              updateCurrentTime(firstIn: firstInTime);
              startWorkingHourTimer(firstInTime, lastOut, isPunched);
            } else {
              // Both firstInTime and lastOut are not 00:00
              updateCurrentTime(firstIn: firstInTime);
              updatePunchoutCurrentTime(lastOut: lastOut);
              startWorkingHourTimer(firstInTime, lastOut, isPunched);
              // startWorkingHourTimer(firstInTime, lastOut,isPunched);
            }
          }

          /* if (firstInTime == "00:00") {
              updateCurrentTime(firstIn: "00:00");
            } else if (lastOut == "00:00") {
              updatePunchoutCurrentTime(lastOut: "00:00");
            } else {
              startWorkingHourTimer(firstInTime, lastOut);
              updateCurrentTime(firstIn: firstInTime);
            }
            */ /*if (lastOut == "00:00") {
              updatePunchoutCurrentTime(lastOut: "00:00");
            } else {
              updatePunchoutCurrentTime(lastOut: lastOut);
              startWorkingHourTimer(firstInTime, lastOut);
            }*/ /*
          } else {
            updateCurrentTime(firstIn: "00:00");
            updatePunchoutCurrentTime(lastOut: "00:00");
          }*/
          /*  CustomToast.showToast('Successfully fetch user Deatils',
              backgroundColor: Colors.green);*/
        } else {
          Get.back();
          updateCurrentTime(firstIn: "00:00");
          updatePunchoutCurrentTime(lastOut: "00:00");
          /*CustomToast.showToast(data['errorMessage'].toString(),
              backgroundColor: Colors.red);*/
        }
      } else {
        Get.back();

        CustomToast.showToast('failed to fetch user Deatils',
            backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.back();
      CustomToast.showToast('An error occurred: $e',
          backgroundColor: Colors.red);
      // return throw Exception(e);
    }

    // return employeeDetailsModel!;
  }

  Future<void> CheckPermission(bool isPunchIn) async {
    // Request location permission
    var locationStatus = await Permission.location.request();

    if (locationStatus.isGranted) {
      _getCurrentPosition(isPunchIn);
    } else if (locationStatus.isDenied) {
      showPermanentlyDeniedDialog(Get.context!, 'Location Permission Denied',
          'You have denied the required location permission. Please enable it in the app settings.');
    } else if (locationStatus.isPermanentlyDenied) {
      showPermanentlyDeniedDialog(Get.context!, 'Location Permission Denied',
          'You have denied the required location permission. Please enable it in the app settings.');
    } else if (locationStatus.isLimited) {
      // Permission is limited, handle it as needed
      handleLimitedPermission();
    } else if (locationStatus.isRestricted) {
      // Permission is restricted, handle it as needed
      handleRestrictedPermission();
    } else if (locationStatus.isProvisional) {
      // Permission is provisional, handle it as needed
      handleProvisionalPermission();
    } else {
      // Handle other cases where permission is not granted
      print('Permission not granted');
    }
  }

  void _getCurrentPosition(bool isPunchIn) async {
    Get.dialog(
      const CustomLoadingDialog(message: 'Please Wait......'),
      barrierDismissible: false,
    );
    //_showAlert(Get.context!);
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      _processLocationData(position, isPunchIn);
    } catch (e) {
      Get.back();
      CustomToast.showToast('Error getting location. Please try again.',
          backgroundColor: Colors.black);
    }
  }

  void _processLocationData(Position position, bool isPunchIn) async {
    try {
      currentPosition = position;

      List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude, position.longitude,
          localeIdentifier: "en");

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        // Fetch individual address components
        String street = placemark.street ?? '';
        String thoroughfare = placemark.thoroughfare ?? '';
        String subLocality = placemark.subLocality ?? '';
        String locality = placemark.locality ?? '';
        String administrativeArea = placemark.administrativeArea ?? '';
        String postalCode = placemark.postalCode ?? '';
        String country = placemark.country ?? '';
        String name = placemark.name ?? '';
        String subAdministrativeArea = placemark.subAdministrativeArea ?? '';

        // Concatenate the address components
        String fullStreetAddress =
            '$subLocality, $locality, $administrativeArea $postalCode, $country';
        // Update the currentAddress
        currentAddress.value = fullStreetAddress;
        var officeLat = box.read('latitude');
        var officelong = box.read('longitude');

        print(position.latitude);
        print(position.longitude);
        double distanceInMeters = Geolocator.distanceBetween(
            double.parse(officeLat),
            double.parse(officelong),
            position.latitude,
            position.longitude);

        // if (distanceInMeters < 1000) {
        if (distanceInMeters < 20) {
          Get.back();
          // Request camera permission
          var cameraStatus = await Permission.camera.request();
          if (cameraStatus.isGranted &&
              workingHoursRemaining.value == "00:00:00") {
            CaptureImage(isPunchIn);
          } else if (cameraStatus.isDenied) {
            showPermanentlyDeniedDialog(
                Get.context!,
                'Camera Permission Denied',
                'You have denied the required camera permission. Please enable it in the app settings.');
          } else if (cameraStatus.isPermanentlyDenied) {
            showPermanentlyDeniedDialog(
                Get.context!,
                'Camera Permission Denied',
                'You have denied the required camera permission. Please enable it in the app settings.');
          } else if (cameraStatus.isLimited) {
            // Permission is limited, handle it as needed
            handleLimitedPermission();
          } else if (cameraStatus.isRestricted) {
            // Permission is restricted, handle it as needed
            handleRestrictedPermission();
          } else if (cameraStatus.isProvisional) {
            // Permission is provisional, handle it as needed
            handleProvisionalPermission();
          } else {
            submitPunch(isPunchIn);
          }
        } else {
          //  Handle the case where the user is outside the 10-meter radius
          //  punchoutcurrentTime.value = "00.00";
          //  imageFile.value = null;
          //  update();
          Get.back();
          CustomToast.showToast('You are outside of the office location',
              backgroundColor: Colors.black);
        }
      } else {
        print("No placemarks found.");
        Get.back();
        CustomToast.showToast(
            'Error fetching location details. Please try again.',
            backgroundColor: Colors.black);
      }
    } catch (e) {
      // Handle any errors that may occur during geocoding
      print("Error during geocoding: $e");
      // Hide loading indicator
      CustomToast.showToast('Error during geocoding. Please try again.',
          backgroundColor: Colors.black);
      Get.back();
    }
  }

  Future<void> CaptureImage(bool isPunchIn) async {
    final XFile? pickedFile =
        await _ppicker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
      fileName!.value = imageFile.value!.path.split("/").last;

      storage.write("selectedImageFilePath", imageFile.value!.path);

      submitPunch(isPunchIn);
    } else {
      fileName!.value = " ";
    }
  }

  Future<void> submitPunch(bool isPunchIn) async {
    String checkTime =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z").format(DateTime.now());
    String checkInTime = isPunchIn ? checkTime : ApiEndPoints.defaultDatetime;
    String checkOutTime = isPunchIn ? ApiEndPoints.defaultDatetime : checkTime;

    String url =
        "${ApiEndPoints.attendanceReportBaseUrl}${AuthEndPoints.addAtendance}";

    final Map<String, dynamic> data = {
      'attendanceId': 0,
      'userId': box.read("userId"),
      'branchId': box.read("branchId"),
      'checkIn': checkInTime + 'Z',
      'checkOut': checkOutTime + 'Z',
      'finacialYearId': box.read("financialYearId"),
      'inDateTime': checkTime + 'Z',
      'latitude': currentPosition?.latitude.toString(),
      'longitude': currentPosition?.longitude.toString(),
      'reportingManagerId': box.read("reportingMangId"),
      "totalHours": '0',
      'del_Flg': 'N',
      'modified_By': 'Admin',
      'modified_On': checkTime + 'Z',
      'isPunch': isPunchIn ? 'Yes' : 'No',
    };

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        if (responseData['isSuccess'] == true) {
          CustomToast.showToast(
            isPunchIn ? 'Punched In successfully' : 'Punched Out successfully',
            backgroundColor: Colors.black,
          );
          fetchUserDetails();

          Get.back();
        } else {
          CustomToast.showToast(
            'Punch ${isPunchIn ? 'In' : 'Out'} Failed!\nSomething went wrong',
            backgroundColor: Colors.black,
          );
        }
      } else {
        CustomToast.showToast(
            'Server Exception\nPunch ${isPunchIn ? 'In' : 'Out'} Fail',
            backgroundColor: Colors.red);
      }
    } catch (e) {
      CustomToast.showToast('$e', backgroundColor: Colors.red);
    } finally {
      Get.back();
    }
  }

  void startWorkingHourTimer(
      String firstInTime, String lastOut, RxString isPunched) {
    DateTime punchOutTime;
    var formattedPunchOutTime;

    if (lastOut == "00:00") {
      punchOutTime = DateTime.now();
      formattedPunchOutTime = getTimeString(punchOutTime);
    } else {
      formattedPunchOutTime = lastOut;
    }

    var format = DateFormat("HH:mm");
    var punchInTime = format.parse(firstInTime);
    var end = format.parse(formattedPunchOutTime);

    Duration diff = end.difference(punchInTime).abs();
    remainingWorkingHours = targetWorkingHours - diff;

    if (isPunched == 'No') {
      print('call isPunched>>>>>>>>>>>>>>>>>>>.No');

      workingHourTimer?.cancel();
      calculateWorkingHoursRemaining();
    } else {
      print('call isPunched>>>>>>>>>>>>>>>>>>>Yes');
      workingHourTimer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
        if (remainingWorkingHours.inSeconds > 0) {
          remainingWorkingHours -= Duration(seconds: 1);
          calculateWorkingHoursRemaining();
        } else {
          timer.cancel();
          //update(); // Make sure to update the UI after the timer expires
        }
      });
    }
    /*   if (end.isAfter(punchInTime)) {
      end = end.add(Duration(days: 0));
      Duration diff = end.difference(punchInTime).abs();
      remainingWorkingHours = targetWorkingHours - diff;

      if (isPunched == 'No') {
        print('call isPunched>>>>>>>>>>>>>>>>>>>.No');

        workingHourTimer?.cancel();
        calculateWorkingHoursRemaining();
      } else {
        print('call isPunched>>>>>>>>>>>>>>>>>>>Yes');
        workingHourTimer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
          if (remainingWorkingHours.inSeconds > 0) {
            remainingWorkingHours -= Duration(seconds: 1);
            calculateWorkingHoursRemaining();
          } else {
            timer.cancel();
            //update(); // Make sure to update the UI after the timer expires
          }
        });
      }
    }*/
  }

  void calculateWorkingHoursRemaining() {
    try {
      // print('Calculate Timer>>>>>>>>>>>>>>>>>>>');

      final remainingHours =
          remainingWorkingHours.inHours.toString().padLeft(2, '0');
      final remainingMinutes =
          (remainingWorkingHours.inMinutes % 60).toString().padLeft(2, '0');
      final remainingSeconds =
          (remainingWorkingHours.inSeconds % 60).toString().padLeft(2, '0');

      final formattedDuration =
          '$remainingHours:$remainingMinutes:$remainingSeconds';

      //   updateWorkinghrTime(workinghrtime: formattedDuration);

      workingHoursRemaining.value = formattedDuration;
      // print('workingHoursRemaining >>>>>>>>>>>>' + workingHoursRemaining.value);

      update();
    } catch (e) {
      print("Error calculating remaining time: $e");
      workingHoursRemaining.value = "00:00:00";
    }
  }

  String getTimeString(DateTime dateTime) {
    return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  }

  String get targetWorkingHoursFormatted {
    final hours = targetWorkingHours.inHours.toString().padLeft(2, '0');
    final minutes =
        (targetWorkingHours.inMinutes % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:00';
  }

  DateTime parseTime(String timeString) {
    try {
      // Extract the time part from the string
      final timeOnly = timeString.split(' ').last;

      // Parse the time using the expected format
      return DateFormat('H:mm').parse(timeOnly);
    } catch (e) {
      print("Error parsing time: $e");
      // Handle the exception as needed, e.g., set a default value or show an error message
      return DateTime.now(); // Return current time as a default
    }
  }

  // update punchIn CurrentTime
  void updateCurrentTime({required String firstIn}) {
    currentTime.value = firstIn;
    latePunch.value = isPunchLate();
    update();
  }

  void updateWorkinghrTime({required String workinghrtime}) {
    workingHoursRemaining.value = workinghrtime;
    print('workingHoursRemaining >>>>>>>>>>>>' + workingHoursRemaining.value);
    update();
  }

  // update punchOut CurrentTime
  void updatePunchoutCurrentTime({required String lastOut}) {
    punchoutcurrentTime.value = lastOut;
    update();
  }

  void showPermanentlyDeniedDialog(
      BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await openAppSettings();
            },
            child: Text('Go to Setting'),
          ),
        ],
      ),
    );
  }

  void handleLimitedPermission() {
    // Handle limited permission as needed
    // You might want to show a message or guide the user on how to upgrade the permission
  }

  void handleRestrictedPermission() {
    // Handle restricted permission as needed
    // You might want to show a message or guide the user on how to resolve the restriction
  }

  void handleProvisionalPermission() {
    // Handle provisional permission as needed
    // You might want to show a message or guide the user on what provisional permission means
  }

  void getFullName() {
    fullname.value = box.read("firstName") +
        " " +
        box.read("middleName") +
        " " +
        box.read("lastName");
  }

  void updateCurrentDate() {
    final now = DateTime.now();
    final formatter = DateFormat('EEEE, MMM d');
    currentDate.value = formatter.format(now);
  }

  void punch() {
    iSPunched.value = true;
  }

  bool isPunchLate() {
    final punchInTime = DateFormat('hh:mm').parse(currentTime.value);
    final lateTime = DateFormat('hh:mm').parse("10:30 AM");
    return punchInTime.isAfter(lateTime);
  }
}

String extractTime(String inputTime) {
  List<String> timeParts = inputTime.split(':');
  if (timeParts.length >= 2) {
    return "${timeParts[0]}:${timeParts[1]}";
  }
  return "";
}
