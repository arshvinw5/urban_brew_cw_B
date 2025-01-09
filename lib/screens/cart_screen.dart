import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban_brew/components/cart_items.dart';
import 'package:urban_brew/components/reusable_button_l.dart';
import 'package:urban_brew/models/cart.dart';
import 'package:urban_brew/screens/home.dart';
import 'package:urban_brew/services/stripe_service.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  //current logged user
  User? user = FirebaseAuth.instance.currentUser;

  Future<void> createPaymentHistory(
    double totalAmount,
  ) async {
    try {
      // Replace `userCredential` and `nameController` with the correct references
      if (user != null) {
        await FirebaseFirestore.instance
            .collection("payment_history")
            .doc(user?.email)
            .collection(
                "transactions") // Store multiple transactions under user email
            .add({
          'totalAmount': totalAmount,
          'timestamp': FieldValue
              .serverTimestamp(), // Use server timestamp for accurate time
        });
      } else {
        print("User not logged in.");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error while saving payment history: $e"),
        duration: Duration(seconds: 2),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalAmount = Provider.of<Cart>(context).totalAmount;

    return Consumer<Cart>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Color(0xFFFFF2D7),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'My Cart',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Expanded(
                  child: ListView.builder(
                itemCount: value.getCart().length,
                itemBuilder: (context, index) {
                  //get the individual coffee
                  Cart cartItem = value.getCart()[index];
                  //return the cart items
                  return CartItems(
                    cart: cartItem,
                  );
                },
              )),
              ReusableButtonL(
                  text: 'Tap to pay: Rs. ${totalAmount.toStringAsFixed(2)}',
                  onTap: () async {
                    await _handlePayment(totalAmount);
                  })
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handlePayment(double totalAmount) async {
    final success = await StripeService.instance.makePayment(totalAmount);

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Payment Successful')),
      );

      try {
        // Log payment history to Firestore
        await createPaymentHistory(totalAmount);

        Provider.of<Cart>(context, listen: false).clearCart();

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      } catch (e) {
        print("Error while clearing cart or navigating: $e");
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Payment Failed')),
      );
    }
  }
}
