import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final int itemId;
  final String name;
  final double price;
  final int quantity;

  CartItem({
    required this.id,
    required this.itemId,
    required this.name,
    required this.price,
    this.quantity = 1,
  });
}

class Cart with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => _items;

  double get totalAmount {
    return _items.values.fold(0.0, (sum, item) => sum + item.price * item.quantity);
  }

  void addItem(String id, int itemId, String name, double price) {
    if (_items.containsKey(id)) {
      _items.update(
        id,
            (existingItem) => CartItem(
          id: existingItem.id,
          itemId: existingItem.itemId,
          name: existingItem.name,
          price: existingItem.price,
          quantity: existingItem.quantity + 1,
        ),
      );
    } else {
      _items[id] = CartItem(id: id, itemId: itemId, name: name, price: price);
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
