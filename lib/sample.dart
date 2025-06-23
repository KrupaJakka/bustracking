// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// void main() {
//   runApp(BusTrackingApp());
// }

// class BusTrackingApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Bus Tracking App',
//       theme: ThemeData(
//         primarySwatch: Colors.indigo,
//         primaryColor: Color(0xFF4F46E5),
//         scaffoldBackgroundColor: Colors.white,
//         fontFamily: 'Segoe UI',
//       ),
//       home: OnboardingScreen(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// // Color Constants
// class AppColors {
//   static const Color primary = Color(0xFF4F46E5);
//   static const Color secondary = Color(0xFF059669);
//   static const Color accent = Color(0xFFF59E0B);
//   static const Color surface = Color(0xFFF8FAFC);
//   static const Color border = Color(0xFFE2E8F0);
//   static const Color textPrimary = Color(0xFF374151);
//   static const Color textSecondary = Color(0xFF6B7280);
//   static const Color success = Color(0xFF10B981);
//   static const Color error = Color(0xFFEF4444);
// }

// // Onboarding Screen
// class OnboardingScreen extends StatefulWidget {
//   @override
//   _OnboardingScreenState createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen> {
//   PageController _pageController = PageController();
//   int currentPage = 0;

//   List<OnboardingData> onboardingData = [
//     OnboardingData(
//       icon: "🚌",
//       title: "Track Your Ride",
//       description: "Real-time GPS tracking for buses and vans. Never miss your ride again with live location updates.",
//     ),
//     OnboardingData(
//       icon: "📍",
//       title: "Live Location",
//       description: "Get accurate ETA updates and route information. Stay informed about delays and schedule changes.",
//     ),
//     OnboardingData(
//       icon: "🔔",
//       title: "Smart Notifications",
//       description: "Receive instant alerts for vehicle arrivals, delays, and important updates.",
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [Color(0xFF667eea), Color(0xFF764ba2)],
//           ),
//         ),
//         child: SafeArea(
//           child: Column(
//             children: [
//               Expanded(
//                 child: PageView.builder(
//                   controller: _pageController,
//                   onPageChanged: (index) {
//                     setState(() {
//                       currentPage = index;
//                     });
//                   },
//                   itemCount: onboardingData.length,
//                   itemBuilder: (context, index) {
//                     return OnboardingPage(data: onboardingData[index]);
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(20),
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: List.generate(
//                         onboardingData.length,
//                         (index) => AnimatedContainer(
//                           duration: Duration(milliseconds: 300),
//                           margin: EdgeInsets.symmetric(horizontal: 4),
//                           width: currentPage == index ? 20 : 10,
//                           height: 10,
//                           decoration: BoxDecoration(
//                             color: currentPage == index ? Colors.white : Colors.white54,
//                             borderRadius: BorderRadius.circular(5),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 30),
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         onPressed: () {
//                           if (currentPage < onboardingData.length - 1) {
//                             _pageController.nextPage(
//                               duration: Duration(milliseconds: 300),
//                               curve: Curves.easeInOut,
//                             );
//                           } else {
//                             Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(builder: (context) => LoginScreen()),
//                             );
//                           }
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.white,
//                           foregroundColor: AppColors.primary,
//                           padding: EdgeInsets.symmetric(vertical: 16),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           elevation: 8,
//                         ),
//                         child: Text(
//                           currentPage < onboardingData.length - 1 ? "Next" : "Get Started",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class OnboardingData {
//   final String icon;
//   final String title;
//   final String description;

//   OnboardingData({
//     required this.icon,
//     required this.title,
//     required this.description,
//   });
// }

// class OnboardingPage extends StatelessWidget {
//   final OnboardingData data;

//   OnboardingPage({required this.data});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(40),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             width: 120,
//             height: 120,
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.2),
//               borderRadius: BorderRadius.circular(60),
//             ),
//             child: Center(
//               child: Text(
//                 data.icon,
//                 style: TextStyle(fontSize: 50),
//               ),
//             ),
//           ),
//           SizedBox(height: 40),
//           Text(
//             data.title,
//             style: TextStyle(
//               fontSize: 28,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           SizedBox(height: 20),
//           Text(
//             data.description,
//             style: TextStyle(
//               fontSize: 16,
//               color: Colors.white.withOpacity(0.9),
//               height: 1.6,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Login Screen
// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   TextEditingController _studentIdController = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();
//   TextEditingController _emailController = TextEditingController();
//   bool _rememberMe = false;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [Color(0xFF667eea), Color(0xFF764ba2)],
//           ),
//         ),
//         child: SafeArea(
//           child: Column(
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(20),
//                 child: Text(
//                   "🚌 Live Bus Tracking",
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.symmetric(horizontal: 20),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.2),
//                   borderRadius: BorderRadius.circular(25),
//                 ),
//                 child: TabBar(
//                   controller: _tabController,
//                   indicatorColor: Colors.white,
//                   labelColor: Colors.white,
//                   unselectedLabelColor: Colors.white70,
//                   tabs: [
//                     Tab(text: "Student"),
//                     Tab(text: "Parent"),
//                     Tab(text: "Driver"),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: TabBarView(
//                   controller: _tabController,
//                   children: [
//                     _buildStudentLogin(),
//                     _buildParentLogin(),
//                     _buildDriverLogin(),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildStudentLogin() {
//     return Container(
//       margin: EdgeInsets.all(20),
//       padding: EdgeInsets.all(25),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 20,
//             offset: Offset(0, 10),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Container(
//             width: 80,
//             height: 80,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [AppColors.primary, Color(0xFF7C3AED)],
//               ),
//               borderRadius: BorderRadius.circular(40),
//             ),
//             child: Center(
//               child: Text("🎓", style: TextStyle(fontSize: 35)),
//             ),
//           ),
//           SizedBox(height: 20),
//           Text(
//             "Welcome Back!",
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//               color: AppColors.textPrimary,
//             ),
//           ),
//           Text(
//             "Sign in to track your bus",
//             style: TextStyle(
//               color: AppColors.textSecondary,
//             ),
//           ),
//           SizedBox(height: 30),
//           TextField(
//             controller: _studentIdController,
//             decoration: InputDecoration(
//               labelText: "Student ID",
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               prefixIcon: Icon(Icons.person),
//             ),
//           ),
//           SizedBox(height: 15),
//           TextField(
//             controller: _passwordController,
//             obscureText: true,
//             decoration: InputDecoration(
//               labelText: "Password",
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               prefixIcon: Icon(Icons.lock),
//             ),
//           ),
//           SizedBox(height: 15),
//           Row(
//             children: [
//               Checkbox(
//                 value: _rememberMe,
//                 onChanged: (value) {
//                   setState(() {
//                     _rememberMe = value!;
//                   });
//                 },
//               ),
//               Text("Remember me"),
//             ],
//           ),
//           SizedBox(height: 20),
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               onPressed: () {
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (context) => StudentDashboard()),
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.primary,
//                 padding: EdgeInsets.symmetric(vertical: 16),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               child: Text(
//                 "Sign In",
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildParentLogin() {
//     return Container(
//       margin: EdgeInsets.all(20),
//       padding: EdgeInsets.all(25),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 20,
//             offset: Offset(0, 10),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Container(
//             width: 80,
//             height: 80,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [AppColors.secondary, Color(0xFF10B981)],
//               ),
//               borderRadius: BorderRadius.circular(40),
//             ),
//             child: Center(
//               child: Text("👨‍👩‍👧‍👦", style: TextStyle(fontSize: 25)),
//             ),
//           ),
//           SizedBox(height: 20),
//           Text(
//             "Parent Portal",
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//               color: AppColors.textPrimary,
//             ),
//           ),
//           Text(
//             "Monitor your child's journey",
//             style: TextStyle(
//               color: AppColors.textSecondary,
//             ),
//           ),
//           SizedBox(height: 30),
//           TextField(
//             controller: _emailController,
//             decoration: InputDecoration(
//               labelText: "Email Address",
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               prefixIcon: Icon(Icons.email),
//             ),
//           ),
//           SizedBox(height: 15),
//           TextField(
//             controller: _passwordController,
//             obscureText: true,
//             decoration: InputDecoration(
//               labelText: "Password",
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               prefixIcon: Icon(Icons.lock),
//             ),
//           ),
//           SizedBox(height: 20),
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               onPressed: () {
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (context) => ParentDashboard()),
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.secondary,
//                 padding: EdgeInsets.symmetric(vertical: 16),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               child: Text(
//                 "Access Portal",
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDriverLogin() {
//     return Container(
//       margin: EdgeInsets.all(20),
//       padding: EdgeInsets.all(25),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 20,
//             offset: Offset(0, 10),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Container(
//             width: 80,
//             height: 80,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [AppColors.accent, Color(0xFFEF4444)],
//               ),
//               borderRadius: BorderRadius.circular(40),
//             ),
//             child: Center(
//               child: Text("🚌", style: TextStyle(fontSize: 35)),
//             ),
//           ),
//           SizedBox(height: 20),
//           Text(
//             "Driver Dashboard",
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//               color: AppColors.textPrimary,
//             ),
//           ),
//           Text(
//             "Manage your route",
//             style: TextStyle(
//               color: AppColors.textSecondary,
//             ),
//           ),
//           SizedBox(height: 30),
//           TextField(
//             decoration: InputDecoration(
//               labelText: "Driver ID",
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               prefixIcon: Icon(Icons.badge),
//             ),
//           ),
//           SizedBox(height: 15),
//           TextField(
//             obscureText: true,
//             decoration: InputDecoration(
//               labelText: "Password",
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               prefixIcon: Icon(Icons.lock),
//             ),
//           ),
//           SizedBox(height: 20),
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               onPressed: () {
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (context) => DriverDashboard()),
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.accent,
//                 padding: EdgeInsets.symmetric(vertical: 16),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               child: Text(
//                 "Start Shift",
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Student Dashboard
// class StudentDashboard extends StatefulWidget {
//   @override
//   _StudentDashboardState createState() => _StudentDashboardState();
// }

// class _StudentDashboardState extends State<StudentDashboard> {
//   int _selectedIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Good Morning, Alex!"),
//         backgroundColor: AppColors.primary,
//         foregroundColor: Colors.white,
//         elevation: 0,
//         actions: [
//           Stack(
//             children: [
//               IconButton(
//                 icon: Icon(Icons.notifications),
//                 onPressed: () {},
//               ),
//               Positioned(
//                 right: 8,
//                 top: 8,
//                 child: Container(
//                   padding: EdgeInsets.all(2),
//                   decoration: BoxDecoration(
//                     color: AppColors.error,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   constraints: BoxConstraints(
//                     minWidth: 16,
//                     minHeight: 16,
//                   ),
//                   child: Text(
//                     '3',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 12,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Your bus is on the way",
//               style: TextStyle(
//                 color: AppColors.textSecondary,
//                 fontSize: 16,
//               ),
//             ),
//             SizedBox(height: 20),
            
//             // Bus Status Card
//             Container(
//               padding: EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     blurRadius: 10,
//                     offset: Offset(0, 5),
//                   ),
//                 ],
//               ),
//               child: Row(
//                 children: [
//                   Container(
//                     width: 60,
//                     height: 60,
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [AppColors.primary, Color(0xFF7C3AED)],
//                       ),
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     child: Center(
//                       child: Text("🚌", style: TextStyle(fontSize: 25)),
//                     ),
//                   ),
//                   SizedBox(width: 15),
//                   Expanded(
//                     child: Column(
//                       crossStartAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Bus Route A-1",
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: AppColors.textPrimary,
//                           ),
//                         ),
//                         Row(
//                           children: [
//                             Container(
//                               width: 8,
//                               height: 8,
//                               decoration: BoxDecoration(
//                                 color: AppColors.success,
//                                 borderRadius: BorderRadius.circular(4),
//                               ),
//                             ),
//                             SizedBox(width: 8),
//                             Text(
//                               "Arriving in 5 minutes",
//                               style: TextStyle(
//                                 color: AppColors.textSecondary,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.accent,
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: Text("Track"),
//                   ),
//                 ],
//               ),
//             ),
            
//             SizedBox(height: 20),
            
//             // Map Placeholder
//             Container(
//               height: 200,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [Color(0xFFE5E7EB), Color(0xFFD1D5DB)],
//                 ),
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.map,
//                       size: 50,
//                       color: AppColors.textSecondary,
//                     ),
//                     Text(
//                       "📍 Live Map View",
//                       style: TextStyle(
//                         color: AppColors.textSecondary,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
            
//             SizedBox(height: 30),
            
//             Text(
//               "Route Timeline",
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.textPrimary,
//               ),
//             ),
            
//             SizedBox(height: 15),
            
//             // Route Timeline
//             _buildRouteTimeline(),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//         },
//         type: BottomNavigationBarType.fixed,
//         selectedItemColor: AppColors.primary,
//         unselectedItemColor: AppColors.textSecondary,
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.location_on),
//             label: 'Track',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.schedule),
//             label: 'Schedule',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildRouteTimeline() {
//     return Container(
//       padding: EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 10,
//             offset: Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           _buildTimelineItem("Main Gate", "Departed - 8:15 AM", true, false),
//           _buildTimelineItem("Park Street", "Current Location - 8:25 AM", false, true),
//           _buildTimelineItem("College Campus", "ETA - 8:35 AM", false, false),
//         ],
//       ),
//     );
//   }

//   Widget _buildTimelineItem(String title, String subtitle, bool isPassed, bool isCurrent) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 15),
//       child: Row(
//         children: [
//           Container(
//             width: 20,
//             height: 20,
//             decoration: BoxDecoration(
//               color: isCurrent ? AppColors.primary : (isPassed ? AppColors.success : AppColors.border),
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//           SizedBox(width: 15),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: isCurrent ? AppColors.primary : AppColors.textPrimary,
//                   ),
//                 ),
//                 Text(
//                   subtitle,
//                   style: TextStyle(
//                     color: AppColors.textSecondary,
//                     fontSize: 14,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Parent Dashboard
// class ParentDashboard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Sarah's Journey"),
//         backgroundColor: AppColors.secondary,
//         foregroundColor: Colors.white,
//         elevation: 0,
//         actions: [
//           Padding(
//             padding: EdgeInsets.all(8.0),
//             child: ElevatedButton(
//               onPressed: () {},
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.error,
//                 foregroundColor: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               child: Text("Emergency"),
//             ),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Alert Banner
//             Container(
//               padding: EdgeInsets.all(15),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [AppColors.accent, AppColors.error],
//                 ),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Row(
//                 children: [
//                   Text("⚠", style: TextStyle(fontSize: 20)),
//                   SizedBox(width: 10),
//                   Expanded(
//                     child: Text(
//                       "Bus running 3 minutes late due to traffic",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
            
//             SizedBox(height: 20),
            
//             // Map Placeholder
//             Container(
//               height: 200,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [Color(0xFFE5E7EB), Color(0xFFD1D5DB)],
//                 ),
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Stack(
//                 children: [
//                   Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.map,
//                           size: 50,
//                           color: AppColors.textSecondary,
//                         ),
//                         Text(
//                           "🗺 Live Tracking Map",
//                           style: TextStyle(
//                             color: AppColors.textSecondary,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Positioned(
//                     top: 20,
//                     left: 20,
//                     child: Container(
//                       padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(8),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.1),
//                             blurRadius: 8,
//                           ),
//                         ],
//                       ),
//                       child: Text(
//                         "Speed: 25 km/h",
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
            
//             SizedBox(height: 20),
            
//             // Vehicle Card
//             Container(
//               padding: EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     blurRadius: 10,
//                     offset: Offset(0, 5),
//                   ),
//                 ],
//               ),
//               child: Row(
//                 children: [
//                   Container(
//                     width: 60,
//                     height: 60,
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [AppColors.primary, Color(0xFF7C3AED)],
//                       ),
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     child: Center(
//                       child: Text("🚌", style: TextStyle(fontSize: 25)),
//                     ),
//                   ),
//                   SizedBox(width: 15),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Morning Route",
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bol