import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

void main() {
  runApp(sample());
}

class sample extends StatelessWidget {
  const sample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StudentDashboard(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  final MapController _mapController = MapController();
  LatLng? _studentLocation;
  LatLng? _driverLocation;
  Timer? _pollingTimer;

  @override
  void initState() {
    super.initState();
    _getStudentLocation();
    _startPollingDriverLocation();
  }

  Future<void> _getStudentLocation() async {
    final permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever)
      return;

    final position = await Geolocator.getCurrentPosition();
    setState(() {
      _studentLocation = LatLng(position.latitude, position.longitude);
    });
  }

  void _startPollingDriverLocation() {
    _pollingTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      _fetchDriverLocation();
    });
  }

  Future<void> _fetchDriverLocation() async {
    final uri = Uri.parse(
      "https://your-api-url.com/driver-location",
    ); // replace

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final driverLat = data['latitude'];
        final driverLng = data['longitude'];

        setState(() {
          _driverLocation = LatLng(driverLat, driverLng);
        });

        _calculateAndSendDistance();
      }
    } catch (e) {
      debugPrint("Error fetching driver location: $e");
    }
  }

  void _calculateAndSendDistance() {
    if (_studentLocation == null || _driverLocation == null) return;

    final distance = const Distance().as(
      LengthUnit.Meter,
      _studentLocation!,
      _driverLocation!,
    );

    // 🔁 Send to cloud
    final payload = {
      "student_lat": _studentLocation!.latitude,
      "student_lng": _studentLocation!.longitude,
      "driver_lat": _driverLocation!.latitude,
      "driver_lng": _driverLocation!.longitude,
      "distance_meters": distance,
    };

    http.post(
      Uri.parse("https://your-api-url.com/distance-report"), // replace
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(payload),
    );

    print("📤 Sent distance: $distance meters");
  }

  @override
  void dispose() {
    _pollingTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Live Bus Tracker"),
        backgroundColor: AppColors.primary,
      ),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: _studentLocation ?? LatLng(0, 0),
          initialZoom: 14,
          maxZoom: 18,
          minZoom: 5,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          if (_studentLocation != null)
            MarkerLayer(
              markers: [
                Marker(
                  point: _studentLocation!,
                  width: 40,
                  height: 40,
                  child: const Icon(
                    Icons.person_pin_circle,
                    color: Colors.green,
                    size: 40,
                  ),
                ),
              ],
            ),
          if (_driverLocation != null)
            MarkerLayer(
              markers: [
                Marker(
                  point: _driverLocation!,
                  width: 40,
                  height: 40,
                  child: const Icon(
                    Icons.directions_bus,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
              ],
            ),
          if (_studentLocation != null && _driverLocation != null)
            PolylineLayer(
              polylines: [
                Polyline(
                  points: [_studentLocation!, _driverLocation!],
                  color: Colors.red,
                  strokeWidth: 4,
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class AppColors {
  static const Color primary = Color(0xFF4F46E5);
}
