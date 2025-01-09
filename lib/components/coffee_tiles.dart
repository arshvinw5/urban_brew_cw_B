import 'package:flutter/material.dart';
import 'package:urban_brew/models/coffee.dart';

class CoffeeTiles extends StatelessWidget {
  Coffee coffee;
  void Function()? onTap;

  CoffeeTiles({super.key, required this.coffee, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.0),
      width: 300,
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(12.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //image path
          // ClipRRect(
          //   child: Image.asset(
          //     coffee.imagePath,
          //     width: MediaQuery.of(context).size.width,
          //     height: MediaQuery.of(context).size.height / 3,
          //     // height: 50,
          //     // width: 50,
          //     fit: BoxFit.fill,
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              coffee.description,
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      coffee.name,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                    Text(
                      'LKR ${coffee.price}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Color(0xffF39E60),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12.0),
                            bottomRight: Radius.circular(12))),
                    child: Icon(
                      Icons.add,
                    ),
                  ),
                )
              ],
            ),
          )
          //discription

          //price and details
          //button to add cart
        ],
      ),
    );
  }
}



// child: Image.asset(
//               coffee.imagePath,
//               height: 400,
//               width: double.infinity,
//               fit: BoxFit.cover,
//             ),