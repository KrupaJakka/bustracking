import 'package:bustracking/map_student.dart';
import 'package:bustracking/sampledriver.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(sample());
}

class sample extends StatelessWidget {
  const sample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: DriverDashboard());
  }
}

class DriverDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      body: Column(
        children: [
          // Header with Gradient
          Container(
            padding: EdgeInsets.only(top: 50, bottom: 30),
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF5B2EFF), Color(0xFF8648F5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Column(
              children: [
                Text(
                  'Driver Dashboard',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                // ElevatedButton(
                //   onPressed: (
                //       ) {
                //     Navigator.push(context,MaterialPageRoute(builder: (context)=>SettingsScreen()
                //     )
                //     );
                //   },
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Colors.white24,
                //     shape: StadiumBorder(),
                //     padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                //   ),
                //   child: Text(
                //     'Driver View',
                //     style: TextStyle(color: Colors.white),
                //   ),
                // ),
              ],
            ),
          ),

          // Route Info with Buttons Beside Text
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text Section
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Route A-1\nActive',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            height: 1.3,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Morning shift - 23 passengers',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: 10),
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // Start Route Logic
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (contex) => DriverView(),
                                  ),
                                );
                              },
                              child: Text(
                                'Start Route',
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // SOS Logic
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              padding: EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: Text(
                              'SOS',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
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
