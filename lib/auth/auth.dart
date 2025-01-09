import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:urban_brew/auth/verification_email.dart';
import 'package:urban_brew/screens/home.dart';
import 'package:urban_brew/auth/login_or_reg.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // If user is logged in
          if (snapshot.hasData) {
            User? user = FirebaseAuth.instance.currentUser;

            // Check if the email is verified
            if (user != null && user.emailVerified) {
              return const Home(); // Proceed to home page
            } else {
              // If email is not verified, show the email verification screen
              return const EmailVerificationScreen();
            }
          } else {
            // User is not logged in, show login/registration screen
            return const LoginOrReg();
          }
        },
      ),
    );
  }
}
