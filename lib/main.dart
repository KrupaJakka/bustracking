import 'package:bustracking/firebase_options.dart';
import 'package:bustracking/selection_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(onboarding());
}

class onboarding extends StatelessWidget {
  const onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bus Tracking App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const OnboardingScreen(),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentPage = 0;

  final List<Map<String, dynamic>> pages = [
    {
      'title': 'Welcome Screen',
      'icon': '🚌',
      'heading': 'Track Your Ride',
      'description':
          'Real-time GPS tracking for buses and vans. Never miss your ride again with live location updates.',
    },
    {
      'title': 'Features Overview',
      'icon': '📍',
      'heading': 'Live Location',
      'description':
          'Get accurate ETA updates and route information. Stay informed about delays and schedule changes.',
    },
    {
      'title': 'Get Started',
      'icon': '🔔',
      'heading': 'Smart Notifications',
      'description':
          'Receive instant alerts for vehicle arrivals, delays, and important updates.',
    },
  ];

  void nextPage() {
    if (currentPage < pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      goToMainScreen();
    }
  }

  void goToMainScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const SelectTheRole()),
    );
  }

  Widget buildDot(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: currentPage == index ? Colors.deepPurple : Colors.grey[300],
        shape: BoxShape.circle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: pages.length,
            onPageChanged: (index) {
              setState(() => currentPage = index);
            },
            itemBuilder: (context, index) {
              final page = pages[index];
              return Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 60),
                    Text(
                      page['title'],
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Container(
                      height: 120,
                      width: 120,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Color(0xFF5B2EFF), Color(0xFF8648F5)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          page['icon'],
                          style: const TextStyle(fontSize: 64),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      page['heading'],
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF374151),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      page['description'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.6,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        pages.length,
                        (index) => buildDot(index),
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        currentPage == pages.length - 1
                            ? 'Get Started'
                            : 'Next',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Positioned(
            top: 40,
            right: 20,
            child: TextButton(
              onPressed: goToMainScreen,
              child: const Text(
                "Skip",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
