import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urban_brew/auth/auth.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();

    bool isLoading = false;

    //function recover password
    void recoverPassword() async {
      setState(() {
        isLoading = true;
      });

      //get the email add
      String email = emailController.text.trim();

      if (email.isEmpty || !email.contains('@')) {
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Please enter a valid email address.'),
              duration: Duration(seconds: 2),
            ),
          );
          isLoading = false;
        });
        return;
      }

      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text('A password recovery email has been sent to $email.'),
              duration: Duration(seconds: 2),
            ),
          );
          isLoading = false;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const AuthScreen()),
          );
        });
      } on FirebaseAuthException catch (e) {
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text(e.message ?? 'An error occurred. Please try again.'),
              duration: Duration(seconds: 2),
            ),
          );
          isLoading = false;
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AuthScreen(),
                    ));
              },
              icon: Icon(
                Icons.home,
                color: Colors.grey.shade500,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.password,
                size: 80,
                color: Colors.white,
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                alignment: Alignment.topCenter,
                child: Text(
                  'Password Recovery',
                  style: GoogleFonts.bebasNeue(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text('Enter your mail',
                  style: GoogleFonts.bebasNeue(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: emailController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.white)),
              ),
              const SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                onTap: recoverPassword,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  padding: EdgeInsets.all(25),
                  child: isLoading
                      ? CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        )
                      : Text(
                          'Send Email',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black),
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
