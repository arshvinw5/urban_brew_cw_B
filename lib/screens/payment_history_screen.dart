import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PaymentHistoryScreen extends StatelessWidget {
  const PaymentHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Color(0xFFFFF2D7),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("payment_history")
            .doc(user?.email)
            .collection("transactions")
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error fetching payment history."));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No payment history found."));
          }

          final paymentDocs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: paymentDocs.length,
            itemBuilder: (context, index) {
              final payment = paymentDocs[index].data() as Map<String, dynamic>;
              final totalAmount = payment['totalAmount'] ?? 0.0;
              final timestamp =
                  payment['timestamp']?.toDate() ?? DateTime.now();

              return Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: ListTile(
                  title: Text(
                    "Amount: LKR ${totalAmount.toStringAsFixed(2)}",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "Date: ${timestamp.toString()}",
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                  trailing: Icon(
                    Icons.history,
                    color: Colors.white,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
