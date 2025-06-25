import 'package:bustracking/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
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
    Position position = await Geolocator.getCurrentPosition();
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
    final driverStartedRide = provider.driverStartedRide;
    final studentLoc = provider.studentLocation ?? studentLocation;

    List<Polyline> polylines = [];
    if (driverLocation != null && studentLoc != null && driverStartedRide) {
      polylines.add(
        Polyline(
          points: [studentLoc, driverLocation],
          strokeWidth: 4,
          color: Colors.red,
        ),
      );
    }

    return Scaffold(
      body: studentLoc == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                // Show map only if driver started the ride
                if (driverStartedRide)
                  FlutterMap(
                    options: MapOptions(
                      initialCenter: studentLoc,
                      initialZoom: 15,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: const ['a', 'b', 'c'],
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
                          if (driverLocation != null)
                            Marker(
                              point: driverLocation,
                              width: 40,
                              height: 40,
                              child: const Icon(
                                Icons.directions_bus,
                                color: Colors.green,
                                size: 40,
                              ),
                            ),
                        ],
                      ),
                      PolylineLayer(polylines: polylines),
                    ],
                  )
                else
                  // If driver hasn't started ride - show static map and button
                  Container(
                    color: Colors.grey.shade200,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.map, size: 100, color: Colors.grey),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              // Optional: Show info or refresh
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              "Ride doesn't start",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                // Floating Zoom / My Location Button (Optional)
                if (driverStartedRide)
                  Positioned(
                    top: 40,
                    right: 20,
                    child: FloatingActionButton(
                      backgroundColor: Colors.deepPurple,
                      onPressed: () {
                        // Optional: Center map to student
                      },
                      child: const Icon(Icons.my_location, color: Colors.white),
                    ),
                  ),

                // Bottom Card - Only if driver started
                if (driverStartedRide)
                  Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.deepPurple,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  "248",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Direction: Schöneberg",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Current: (${studentLoc.latitude.toStringAsFixed(4)}, ${studentLoc.longitude.toStringAsFixed(4)})",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: const [
                              Icon(
                                Icons.location_on,
                                color: Colors.deepPurple,
                                size: 18,
                              ),
                              SizedBox(width: 6),
                              Text(
                                "Alexanderplatz → Berliner Rathaus",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                // Optional: Show full route
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                              ),
                              child: const Text(
                                "Show Full Route",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}
