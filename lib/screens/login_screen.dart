import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urban_brew/auth/auth.dart';
import 'package:urban_brew/auth/verification_email.dart';
import 'package:urban_brew/components/auth_button.dart';
import 'package:urban_brew/components/text_feild.dart';
import 'package:urban_brew/helper/helper_function.dart';
import 'package:urban_brew/screens/forget_password.dart';

class LoginScreen extends StatefulWidget {
  final void Function()? onTap;

  const LoginScreen({super.key, required this.onTap});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //text editing controller
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login() async {
    //show loading cycle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      // Attempt to sign in the user
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);

      if (mounted) {
        // Pop the loading spinner if mounted
        Navigator.pop(context);

        //clear inputs
        emailController.clear();
        passwordController.clear();

        // Check if the user's email is verified
        User? user = FirebaseAuth.instance.currentUser;

        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => const Temp()), // Navigate to the Temp page
        // );

        if (user != null && user.emailVerified) {
          // If email is verified, navigate to Temp screen
          //Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const AuthScreen()),
          );
        } else {
          if (!mounted) return;
          // If email is not verified, show a message and redirect to Email Verification screen
          displayMessageToUser('User Credential Alert',
              'Please verify your email before logging in.', context);

          // Optionally, sign out the user immediately if you don't want them to stay logged in
          await FirebaseAuth.instance.signOut();

          // Navigate to the EmailVerificationScreen to prompt user to verify email
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const EmailVerificationScreen()),
            );
          }
        }
      }
    } on FirebaseAuthException catch (err) {
      if (mounted) {
        Navigator.pop(context);
        displayMessageToUser('User Credential Alert', err.code, context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF2D7),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              Icon(
                Icons.password,
                size: 80,
                color: Colors.black,
              ),
              const SizedBox(
                height: 25.0,
              ),
              Text(
                'Urban Brew Login',
                style: GoogleFonts.bebasNeue(
                    fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 50.0,
              ),
              //email
              ReuseableTextFelid(
                  hintText: 'Email',
                  controller: emailController,
                  obscureText: false),
              //email
              const SizedBox(
                height: 10.0,
              ),
              ReuseableTextFelid(
                  hintText: 'Password',
                  controller: passwordController,
                  obscureText: true),

              const SizedBox(
                height: 10.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgetPassword(),
                      ));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Forgot Password ?",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25.0,
              ),
              AuthButton(
                text: 'Login',
                onTap: login,
              ),
              const SizedBox(
                height: 25.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Do not have an account?'),
                  const SizedBox(
                    width: 5.0,
                  ),
                  GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Register here',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
