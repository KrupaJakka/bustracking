import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class LocationProvider with ChangeNotifier {
  LatLng? driverLocation;
  LatLng? studentLocation;

  void updateDriverLocation(LatLng location) {
    driverLocation = location;
    notifyListeners();
  }

  void updateStudentLocation(LatLng location) {
    studentLocation = location;
    notifyListeners();
  }
}
