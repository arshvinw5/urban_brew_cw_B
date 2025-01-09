import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urban_brew/auth/auth.dart';
import 'package:urban_brew/components/reusable_button_l.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF2D7),
      body: Center(
        child: Column(
          //to make thigs center
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                "assets/images/OnBoard.png",
                height: 450,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Find the best coffee for you',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.bebasNeue(
                            fontSize: 56.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5.0),
                      const Text(
                        'The best time to savor is now. Take a moment to explore the world of coffee with us.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black45,
                            fontWeight: FontWeight.w500,
                            fontSize: 18.0),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            //button
            SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                child: ReusableButtonL(
                    text: 'Get Started',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AuthScreen()),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
