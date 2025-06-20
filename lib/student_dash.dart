import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  GoogleMapController? _mapController;
  LatLng _defaultPosition = LatLng(37.7749, -122.4194);
  LatLng? _busPosition;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('busLocation')
        .doc('driver1')
        .snapshots()
        .listen((doc) {
          final data = doc.data();
          if (data != null) {
            setState(() {
              _busPosition = LatLng(data['lat'], data['lng']);
            });
            _mapController?.animateCamera(
              CameraUpdate.newLatLng(_busPosition!),
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    final busMarker = _busPosition != null
        ? Marker(
            markerId: MarkerId('bus'),
            position: _busPosition!,
            infoWindow: InfoWindow(title: 'Bus Location'),
          )
        : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Dashboard"),
        backgroundColor: Colors.deepPurple,
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _defaultPosition,
          zoom: 14,
        ),
        onMapCreated: (controller) => _mapController = controller,
        markers: busMarker != null ? {busMarker} : {},
      ),
    );
  }
}
