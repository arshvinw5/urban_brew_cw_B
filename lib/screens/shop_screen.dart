import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban_brew/components/coffee_tiles.dart';
import 'package:urban_brew/components/details.dart';
import 'package:urban_brew/models/cart.dart';
import 'package:urban_brew/models/coffee.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  String _searchQuery = '';

  void addCoffeeToCart(Coffee coffee) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Details(coffee: coffee),
      ),
    );
  }

  List<Coffee> _getFilteredCoffeeList(List<Coffee> coffeeList) {
    if (_searchQuery.isEmpty) {
      return coffeeList;
    }
    return coffeeList
        .where((coffee) =>
            coffee.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            coffee.description
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, value, child) {
        List<Coffee> filteredCoffeeList =
            _getFilteredCoffeeList(value.getCoffeeList());

        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: const TextStyle(color: Colors.black),
                  suffixIcon: const Icon(
                    Icons.search,
                    color: Colors.black,
                    weight: 2,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.red, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.black, width: 2.0),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 20.0),
            const SizedBox(height: 30.0),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Hot Pick',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => {},
                    child: Text(
                      'View all',
                      style: TextStyle(
                        color: Color(0xFF503C3C),
                        fontWeight: FontWeight.w500,
                        fontSize: 15.0,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            Expanded(
              child: ListView.builder(
                itemCount: _getFilteredCoffeeList(value.getCoffeeList()).length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  Coffee coffee =
                      _getFilteredCoffeeList(value.getCoffeeList())[index];
                  return CoffeeTiles(
                    coffee: coffee,
                    onTap: () => addCoffeeToCart(coffee),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 50, left: 25, right: 25),
              child: Divider(
                color: Colors.grey[700],
              ),
            )
          ],
        );
      },
    );
  }
}
