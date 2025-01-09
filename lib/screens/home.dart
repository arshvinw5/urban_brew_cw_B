import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:urban_brew/auth/login_or_reg.dart';
import 'package:urban_brew/components/bottom_nav_bar.dart';
import 'package:urban_brew/components/custom_drawer.dart';
import 'package:urban_brew/screens/cart_screen.dart';
import 'package:urban_brew/screens/favoirt_screen.dart';
import 'package:urban_brew/screens/payment_history_screen.dart';
import 'package:urban_brew/screens/shop_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //this selected index is to control the bottom nav bar
  int _selectedIndex = 0;

  //this method will update the selected index
  //when the user is tap on bottom bar

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  //pages to display items
  final List<Widget> _page = [
    // shop page
    const ShopScreen(),
    //cart screen
    const CartScreen(),
    //payment history screen
    const PaymentHistoryScreen(),
    //favorite screen
    const FavoritesScreen(),
  ];

  void logout() {
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginOrReg()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFF2D7),
        elevation: 0,
        leading: Builder(builder: (context) {
          return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(
                Icons.menu,
                color: Colors.black,
                size: 30,
              ));
        }),
        actions: [IconButton(onPressed: logout, icon: Icon(Icons.logout))],
      ),
      backgroundColor: Color(0xFFFFF2D7),
      bottomNavigationBar: MyBottomNavBar(
        onTabChange: (index) => navigateBottomBar(index),
      ),
      //ToDo : Drawer to work on
      drawer: CustomDrawer(),
      body: _page[_selectedIndex],
    );
  }
}
