import 'package:bustracking/college_login.dart';
import 'package:bustracking/driver.dart';
import 'package:bustracking/parentlogin.dart';
import 'package:bustracking/student_login.dart';
import 'package:flutter/material.dart';

class SelectTheRole extends StatefulWidget {
  const SelectTheRole({super.key});

  @override
  State<SelectTheRole> createState() => _SelectTheRoleState();
}

class _SelectTheRoleState extends State<SelectTheRole> {
  Widget buildRoleCard({
    required String title,
    required String imageUrl,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 129, 92, 234),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurple.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundImage: NetworkImage(imageUrl),
              backgroundColor: Colors.white,
              onBackgroundImageError: (_, __) => const Icon(Icons.error),
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Your Role"),
        backgroundColor: const Color.fromARGB(255, 129, 92, 234),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Column(
          children: [
            buildRoleCard(
              title: "Admin Login",
              imageUrl:
                  "https://img.freepik.com/premium-photo/young-student-avatar-generative-ai_138015-2370.jpg",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const collegeloginscreen()),
                );
              },
            ),
            buildRoleCard(
              title: "Student Login",
              imageUrl:
                  "https://img.freepik.com/premium-photo/young-student-avatar-generative-ai_138015-2370.jpg",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const StudentLogin()),
                );
              },
            ),
            buildRoleCard(
              title: "Driver Login",
              imageUrl:
                  "https://img.freepik.com/premium-photo/avatar-driver-generative-ai_962764-2065.jpg",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const DriverLoginScreen()),
                );
              },
            ),
            buildRoleCard(
              title: "Parent Login",
              imageUrl:
                  "https://img.freepik.com/premium-photo/indian-female-avatar-wearing-sari-generative-ai_934475-843.jpg",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ParentLoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
