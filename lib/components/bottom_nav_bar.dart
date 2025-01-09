import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyBottomNavBar extends StatelessWidget {
  final void Function(int)? onTabChange;
  const MyBottomNavBar({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      child: GNav(
          mainAxisAlignment: MainAxisAlignment.center,
          color: Colors.black,
          activeColor: Colors.white,
          tabActiveBorder: Border.all(color: Colors.black),
          tabBackgroundColor: Colors.black,
          tabBorderRadius: 16,
          onTabChange: (value) => onTabChange!(value),
          tabs: [
            GButton(
              icon: Icons.home,
              iconSize: 30,
              text: 'Shop',
            ),
            GButton(
              icon: Icons.shopping_bag_rounded,
              text: 'Cart',
              iconSize: 30,
            ),
            GButton(
              icon: Icons.monetization_on,
              text: 'History',
              iconSize: 30,
            ),
            GButton(
              icon: Icons.favorite_border_outlined,
              text: 'Favorite',
              iconSize: 30,
            )
          ]),
    );
  }
}
