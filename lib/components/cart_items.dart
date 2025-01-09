import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban_brew/models/cart.dart';

class CartItems extends StatefulWidget {
  Cart cart;
  CartItems({super.key, required this.cart});

  @override
  _CartItemsState createState() => _CartItemsState();
}

class _CartItemsState extends State<CartItems> {
  //item remove from cart
  void removeFromCart() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        // title: Text('Are you sure?'),
        content: Text('Do you really want to remove this item from the cart?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.black, // Black button background
            ),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.white, // White text color
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Provider.of<Cart>(context, listen: false)
                  .removeFromCart(widget.cart);
              Navigator.pop(context); // Close the dialog
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.black, // Black button background
            ),
            child: Text(
              'Confirm',
              style: TextStyle(
                color: Colors.white, // White text color
              ),
            ),
          ),
        ],
      ),
    );
  }

  void incrementQuantity() {
    Provider.of<Cart>(context, listen: false).incrementQuantity(widget.cart);
  }

  void decrementQuantity() {
    Provider.of<Cart>(context, listen: false).decrementQuantity(widget.cart);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(8.0)),
      margin: EdgeInsets.only(bottom: 10.0),
      child: ListTile(
        // leading: ClipRRect(
        //   child: Image.asset(
        //     widget.cart.imagePath ?? '',
        //     // width: MediaQuery.of(context).size.width,
        //     // height: MediaQuery.of(context).size.height / 3,r
        //     height: 50,
        //     width: 50,
        //     fit: BoxFit.fill,
        //   ),
        // ),
        title: Text(
          widget.cart.name ?? "",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Price : LKR ${widget.cart.price}',
          style: TextStyle(color: Colors.grey[500]),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: decrementQuantity,
              icon: const Icon(Icons.remove, color: Colors.white),
            ),
            Text(
              '${widget.cart.quantity ?? 0}',
              style: const TextStyle(color: Colors.white),
            ),
            IconButton(
              onPressed: incrementQuantity,
              icon: const Icon(Icons.add, color: Colors.white),
            ),
            IconButton(
              onPressed: removeFromCart,
              icon: const Icon(Icons.delete, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
