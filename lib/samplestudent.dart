// student_view.dart
import 'package:bustracking/provider.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class StudentView extends StatefulWidget {
  @override
  State<StudentView> createState() => _StudentViewState();
}

class _StudentViewState extends State<StudentView> {
  LatLng? studentLocation;

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  void _initLocation() async {
    final position = await Geolocator.getCurrentPosition();
    final loc = LatLng(position.latitude, position.longitude);
    Provider.of<LocationProvider>(
      context,
      listen: false,
    ).updateStudentLocation(loc);

    setState(() {
      studentLocation = loc;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LocationProvider>();
    final driverLocation = provider.driverLocation;
    final studentLoc = provider.studentLocation ?? studentLocation;

    List<Polyline> polylines = [];
    if (driverLocation != null && studentLoc != null) {
      polylines.add(
        Polyline(
          points: [studentLoc, driverLocation],
          strokeWidth: 4,
          color: Colors.red,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Student View")),
      body: studentLoc == null
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(
              options: MapOptions(initialCenter: studentLoc, initialZoom: 15),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: const ['a', 'b', 'c'],
                ),
                if (driverLocation != null)
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: driverLocation,
                        width: 40,
                        height: 40,
                        child: const Icon(
                          Icons.directions_car,
                          color: Colors.green,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: studentLoc,
                      width: 40,
                      height: 40,
                      child: const Icon(
                        Icons.person_pin_circle,
                        color: Colors.orange,
                        size: 40,
                      ),
                    ),
                  ],
                ),
                PolylineLayer(polylines: polylines),
              ],
            ),
    );
  }
}
