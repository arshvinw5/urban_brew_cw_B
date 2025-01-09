import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:urban_brew/auth/auth.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});

  void resendVerificationEmail(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
      // Display a message that the email has been resent

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Email Verification"),
          content:
              const Text("Verification email sent. Please check your inbox."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Okay"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF2D7),
      appBar: AppBar(
        backgroundColor: Color(0xFFFFF2D7),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AuthScreen(),
                    ));
              },
              icon: Icon(Icons.home))
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.email_outlined,
                size: 80,
                color: Colors.black,
              ),
              const SizedBox(height: 20),
              const Text(
                'Please verify your email before continuing.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => resendVerificationEmail(context),
                child: const Text(
                  "Resend Verification Email",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
