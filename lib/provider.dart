import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class LocationProvider with ChangeNotifier {
  LatLng? driverLocation;
  LatLng? studentLocation;
  bool driverStartedRide = false;

  void updateDriverLocation(LatLng location) {
    driverLocation = location;
    notifyListeners();
  }

  void updateStudentLocation(LatLng location) {
    studentLocation = location;
    notifyListeners();
  }

  void startDriverRide() {
    driverStartedRide = true;
    notifyListeners();
  }
}
