import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urban_brew/auth/auth.dart';
import 'package:urban_brew/components/auth_button.dart';
import 'package:urban_brew/components/text_feild.dart';
import 'package:urban_brew/screens/forget_password.dart';
import 'package:urban_brew/screens/home.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  //current logged user
  User? currentUser = FirebaseAuth.instance.currentUser;

  //future to fetch the user details
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.email)
        .get();
  }

  Future<void> changeName() async {
    String newName = nameController.text.trim();

    try {
      // Update the user's name in Firestore
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(currentUser!.email)
          .update({'name': newName});

      // After Firestore operation, check if widget is mounted
      if (!mounted) return;

      // Show success message and navigate to AuthScreen
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Name updated successfully!')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AuthScreen()),
      );
    } catch (e) {
      // Handle any errors during the update
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating name: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF2D7),
      appBar: AppBar(
          backgroundColor: Color(0xFFFFF2D7),
          automaticallyImplyLeading: false,
          elevation: 0.0,
          leading: IconButton(
              onPressed: () => Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Home())),
              icon: Icon(Icons.arrow_back))),
      body: Container(
        child: Column(
          children: [
            FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              future: getUserDetails(),
              builder: (context, snapshot) {
                //loading...
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                  //error
                } else if (snapshot.hasError) {
                  return Text("Error:${snapshot.error}");
                }

                //data
                else if (snapshot.hasData) {
                  //extract data
                  Map<String, dynamic>? user = snapshot.data!.data();

                  return Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person,
                            size: 80,
                            color: Colors.black,
                          ),
                          const SizedBox(
                            height: 25.0,
                          ),
                          Text(
                            'Urban Brew User Profile',
                            style: GoogleFonts.bebasNeue(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                          const SizedBox(
                            height: 50.0,
                          ),
                          ReuseableTextFelid(
                              hintText: user!['name'],
                              controller: nameController,
                              obscureText: false),
                          const SizedBox(
                            height: 25.0,
                          ),
                          ReuseableTextFelid(
                              hintText: user['email'],
                              controller: emailController,
                              obscureText: false),
                          const SizedBox(
                            height: 25.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Change Password',
                                style: TextStyle(fontSize: 18),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ForgetPassword()));
                                },
                                child: Text(
                                  'Click Here',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 25.0,
                          ),
                          AuthButton(text: "Save", onTap: changeName)
                        ],
                      ),
                    ),
                  );
                } else {
                  return Text('No Data');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}




// Text(user!['email']), Text(user['name'])



// Expanded(
//               child: StreamBuilder(
//                 stream:
//                     FirebaseFirestore.instance.collection("Users").snapshots(),
//                 builder: (context, snapshot) {
//                   //any error
//                   if (snapshot.hasError) {
//                     displayMessageToUser('Connection Error!',
//                         'Error fetching all user from firebase.', context);
//                   }

//                   //loading
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   }

//                   if (snapshot.data == null) {
//                     return const Text('No Data');
//                   }

//                   //all users

//                   final users = snapshot.data!.docs;
//                   return ListView.builder(
//                     itemCount: users.length,
//                     itemBuilder: (context, index) {
//                       //get individual user
//                       final user = users[index];

//                       return ListTile(
//                           title: Text(user['name']),
//                           subtitle: Text(user['email']));
//                     },
//                   );
//                 },
//               ),
//             // )