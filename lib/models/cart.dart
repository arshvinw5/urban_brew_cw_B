import 'dart:core';

import 'package:flutter/material.dart';
import 'package:urban_brew/models/coffee.dart';

class Cart extends ChangeNotifier {
  final String? name;
  final String? price;
  final String? imagePath;
  final String? description;
  int? quantity;

  // Constructor
  Cart({
    this.name,
    this.price,
    this.imagePath,
    this.description,
    this.quantity,
  });

  // list of coffee
  List<Coffee> coffeeShop = [
    Coffee(
      name: "Latte",
      description: "This is good",
      imagePath: "assets/images/Latte.png",
      price: '1075.00',
    ),
    Coffee(
      name: "Cappuccino",
      description: "Rich and creamy with a foamy top",
      imagePath: "assets/images/IceCoffee.png",
      price: '950.00',
    ),
    Coffee(
      name: "Espresso",
      description: "Strong and bold, a pure coffee experience",
      imagePath: "assets/images/Espresso.png",
      price: '850.00',
    ),
    Coffee(
      name: "Mocha",
      description: "A delightful mix of chocolate and coffee",
      imagePath: "assets/images/Mocha.png",
      price: '1150.00',
    ),
    Coffee(
      name: "Macchiato",
      description: "A shot of espresso with a touch of milk foam",
      imagePath: "assets/images/Latte.png",
      price: '925.00',
    ),
    Coffee(
      name: "Americano",
      description: "Espresso diluted with hot water",
      imagePath: "assets/images/Americano.png",
      price: '750.00',
    ),
    Coffee(
      name: "Flat White",
      description: "Smooth and velvety espresso with steamed milk",
      imagePath: "assets/images/Flat_White.png",
      price: '980.00',
    ),
    Coffee(
      name: "Iced Coffee",
      description: "Cold coffee with a refreshing twist",
      imagePath: "assets/images/IceCoffee.png",
      price: '880.00',
    ),
  ];

  //list of item in user cart
  List<Cart> userCart = [];

  //get list of item for sale
  List<Coffee> getCoffeeList() {
    return coffeeShop;
  }

  //get cart
  List<Cart> getCart() {
    return userCart;
  }

  //add item to cart
  void addItemToCart(Cart cart) {
    userCart.add(cart);
    notifyListeners();
  }

  //remove item from the cart
  void removeFromCart(Cart cart) {
    userCart.remove(cart);
    notifyListeners();
  }

  //If cart.quantity is null, it substitutes 0.

  void incrementQuantity(Cart cart) {
    cart.quantity = (cart.quantity ?? 0) + 1;
    notifyListeners();
  }

  void decrementQuantity(Cart cart) {
    if ((cart.quantity ?? 0) > 0) {
      cart.quantity = (cart.quantity ?? 0) - 1;
    }
    notifyListeners();
  }

  void clearCart() {
    userCart.clear();
    notifyListeners();
  }

  double get totalAmount {
    return userCart.fold(0.0, (sum, cart) {
      double price = double.tryParse(cart.price ?? '0') ?? 0.0;
      int quantity = cart.quantity ?? 0;
      return sum + (price * quantity);
    });
  }
}
