import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LatLongScreenController extends GetxController{

  Rx<Position> currentPosition = Rx<Position>(Position(
    latitude: 0,
    longitude: 0,
    timestamp: DateTime(0),
    accuracy: 0,
    altitude: 0,
    heading: 0,
    speed: 0,
    speedAccuracy: 0,
  ));
  late StreamSubscription<Position> positionStreamSubscription;

  @override
  void onInit() {
    super.onInit();
    getLocation();
  }

  void getLocation() async {
    positionStreamSubscription = Geolocator.getPositionStream(
      desiredAccuracy: LocationAccuracy.high,
      distanceFilter: 10, // Update location when the user moves at least 10 meters
    ).listen((Position position) {
      currentPosition.value = position;
      //updateLocationAPI(position.latitude, position.longitude);
    });
  }

  @override
  void onClose() {
    positionStreamSubscription.cancel();
    super.onClose();
  }
}