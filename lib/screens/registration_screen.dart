import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urban_brew/components/auth_button.dart';
import 'package:urban_brew/components/text_feild.dart';
import 'package:urban_brew/helper/helper_function.dart';

class RegistrationScreen extends StatefulWidget {
  final void Function()? onTap;

  const RegistrationScreen({super.key, required this.onTap});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  //text editing controller
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void registerUser() async {
    // Show loading spinner
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // Ensure passwords match
    if (passwordController.text != confirmPasswordController.text) {
      if (mounted) {
        // Pop the loading spinner if mounted
        Navigator.pop(context);
        displayMessageToUser(
            "User Credential Alert", "Passwords don't match!", context);
      }
      return;
    }

    try {
      // Create user
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: confirmPasswordController.text,
      );

      //create a user doc and add to firestore

      createUserDocument(userCredential);

      User? user = userCredential.user;
      if (user != null) {
        // Update the user's display name
        await user.updateProfile(displayName: nameController.text);

        // Send email verification
        await user.sendEmailVerification();

        if (mounted) {
          // Pop the loading spinner if mounted
          Navigator.pop(context);

          // Show a success message to the user
          displayMessageToUser(
            "User Credential Alert",
            "Registration successful! Please verify your email.",
            context,
          );

          // Clear input fields after successful registration
          nameController.clear();
          emailController.clear();
          passwordController.clear();
          confirmPasswordController.clear();
        }
      }
    } on FirebaseAuthException catch (err) {
      if (mounted) {
        // Handle error and pop spinner if mounted
        Navigator.pop(context);
        displayMessageToUser("User Credential Alert", err.code, context);
      }
    }
  }

  //create a user document and collect them in firestore

  Future<void> createUserDocument(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .set({
        'name': nameController.text,
        'email': userCredential.user!.email,
      });
    }
  }

  //The concept of "mounted" in Flutter is related to the lifecycle of a widget. It indicates whether
  //the widget is currently part of the widget tree. In simpler terms, it checks if the widget
  //is "alive" and actively rendered in the app.

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
                Icons.person,
                size: 80,
                color: Colors.black,
              ),
              const SizedBox(
                height: 25.0,
              ),
              Text(
                'Urban Brew User Registration',
                style: GoogleFonts.bebasNeue(
                    fontWeight: FontWeight.bold, fontSize: 30),
              ),
              const SizedBox(
                height: 50.0,
              ),
              //email
              ReuseableTextFelid(
                  hintText: 'Name',
                  controller: nameController,
                  obscureText: false),
              //email
              const SizedBox(
                height: 25.0,
              ),
              ReuseableTextFelid(
                  hintText: 'Email',
                  controller: emailController,
                  obscureText: false),
              //email
              const SizedBox(
                height: 25.0,
              ),
              ReuseableTextFelid(
                  hintText: 'Password',
                  controller: passwordController,
                  obscureText: true),
              const SizedBox(
                height: 25.0,
              ),
              ReuseableTextFelid(
                  hintText: 'Confirm Password',
                  controller: confirmPasswordController,
                  obscureText: true),
              //email
              const SizedBox(
                height: 25.0,
              ),
              AuthButton(
                text: 'Register',
                onTap: registerUser,
              ),
              const SizedBox(
                height: 25.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('You have an account?'),
                  const SizedBox(
                    width: 5.0,
                  ),
                  GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Login',
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
