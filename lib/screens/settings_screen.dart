import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:urban_brew/screens/home.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //to get user
    User? user = FirebaseAuth.instance.currentUser;
    Future<void> deleteAllPaymentHistory() async {
      try {
        if (user != null) {
          CollectionReference transactionsRef = FirebaseFirestore.instance
              .collection("payment_history")
              .doc(user.email)
              .collection("transactions");

          QuerySnapshot querySnapshot = await transactionsRef.get();

          WriteBatch batch = FirebaseFirestore.instance.batch();

          for (QueryDocumentSnapshot doc in querySnapshot.docs) {
            batch.delete(doc.reference);
          }

          await batch.commit();

          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Payment history has been deleted"),
              duration: Duration(seconds: 2),
            ));
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("EUser not logged in."),
            duration: Duration(seconds: 2),
          ));
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Error while deleting payment history: $e"),
            duration: Duration(seconds: 2),
          ));
        }
      }
    }

    Future<void> showDeleteConfirmationDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button for close dialog
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Delete All Payment History'),
            content: Text(
                'Are you sure you want to delete all payment history? This action cannot be undone.'),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Delete'),
                onPressed: () {
                  Navigator.of(context).pop();
                  deleteAllPaymentHistory();
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFFF2D7),
      appBar: AppBar(
        backgroundColor: Color(0xFFFFF2D7),
        automaticallyImplyLeading: false,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Home())),
            icon: Icon(Icons.arrow_back)),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        children: [
          // Dark Mode Toggle
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            margin: const EdgeInsets.only(bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Dark Mode',
                  style: TextStyle(color: Colors.white),
                ),
                // Uncomment and modify this switch toggle when integrating theme logic
                // Switch(
                //   value: Provider.of<ThemeProvider>(context).isDarkMode,
                //   onChanged: (value) {
                //     Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
                //   },
                // ),
              ],
            ),
          ),
          //toggle to delete payment history
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            margin: const EdgeInsets.only(bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Clear Payment History',
                  style: TextStyle(color: Colors.white),
                ),
                // Add a toggle or other widget for this setting
                IconButton(
                    onPressed: showDeleteConfirmationDialog,
                    icon: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ))
              ],
            ),
          ),
          // Add more settings containers as needed
        ],
      ),
    );
  }
}
