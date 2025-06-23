import 'package:bustracking/parentdash.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class collegeloginscreen extends StatefulWidget {
  const collegeloginscreen({super.key});

  @override
  State<collegeloginscreen> createState() => _collegeloginscreenState();
}

class _collegeloginscreenState extends State<collegeloginscreen> {
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoading = false;

  void _login() async {
    final email = _emailcontroller.text.trim();
    final password = _passwordcontroller.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter email and password')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Navigate to StudentDashboard after successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ParentDashboardScreen()),
      );
    } on FirebaseAuthException catch (e) {
      String message = 'Login failed';

      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided.';
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('An error occurred. Try again.')));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Admin Login"))),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            CircleAvatar(
              backgroundColor: Colors.green,
              child: Text('👨‍👨‍👧', style: TextStyle(fontSize: 30)),
              radius: 35,
            ),
            const SizedBox(height: 16),
            Text(
              "Admin Portal",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text("Monitor the  journey"),
            const SizedBox(height: 16),
            TextField(
              controller: _emailcontroller,
              decoration: InputDecoration(
                labelText: 'Enter the admin mail',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordcontroller,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Enter the password",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            _isLoading
                ? CircularProgressIndicator()
                : InkWell(
                    onTap: _login,
                    child: Container(
                      height: 40,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Color(0xff6A1B9A),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(fontSize: 17, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
