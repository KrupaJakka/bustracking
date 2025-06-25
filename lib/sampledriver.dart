// driver_view.dart
import 'package:bustracking/provider.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class DriverView extends StatefulWidget {
  @override
  State<DriverView> createState() => _DriverViewState();
}
class _DriverViewState extends State<DriverView> {
  bool rideStarted = false;
  late Stream<Position> positionStream;

  void startRide() {
    setState(() {
      rideStarted = true;
    });

    positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );

    positionStream.listen((position) {
      final driverLatLng = LatLng(position.latitude, position.longitude);
      Provider.of<LocationProvider>(
        context,
        listen: false,
      ).updateDriverLocation(driverLatLng);
    });
  }

  @override
  Widget build(BuildContext context) {
    LatLng? driverLocation = context.watch<LocationProvider>().driverLocation;

    return Scaffold(
      appBar: AppBar(title: const Text("Driver View")),
      body: rideStarted
          ? driverLocation == null
                ? const Center(child: CircularProgressIndicator())
                : FlutterMap(
                    options: MapOptions(
                      initialCenter: driverLocation,
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
                            point: driverLocation,
                            width: 40,
                            height: 40,
                            child: const Icon(
                              Icons.directions_car,
                              color: Colors.blue,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
          : Center(
              child: ElevatedButton(
                onPressed: startRide,
                child: const Text("Start Ride"),
              ),
            ),
    );
  }
}
