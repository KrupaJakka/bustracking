import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DriverDashboard extends StatefulWidget {
  const DriverDashboard({super.key});

  @override
  State<DriverDashboard> createState() => _DriverDashboardState();
}

class _DriverDashboardState extends State<DriverDashboard> {
  GoogleMapController? _mapController;
  Location location = Location();
  bool _isSharing = false;

  LatLng? currentPosition;

  void _startSharingLocation() async {
    final hasPermission = await location.hasPermission();
    if (hasPermission == PermissionStatus.denied) {
      await location.requestPermission();
    }

    location.changeSettings(interval: 3000);
    location.onLocationChanged.listen((loc) async {
      currentPosition = LatLng(loc.latitude!, loc.longitude!);

      FirebaseFirestore.instance.collection('busLocation').doc('driver1').set({
        'lat': loc.latitude,
        'lng': loc.longitude,
        'timestamp': FieldValue.serverTimestamp(),
      });

      if (_mapController != null) {
        _mapController!.animateCamera(CameraUpdate.newLatLng(currentPosition!));
      }
    });

    setState(() {
      _isSharing = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Driver Dashboard"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(37.7749, -122.4194), // default position
                zoom: 14,
              ),
              onMapCreated: (controller) => _mapController = controller,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton.icon(
              onPressed: _isSharing ? null : _startSharingLocation,
              icon: Icon(Icons.directions_bus),
              label: Text("Start Journey"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
