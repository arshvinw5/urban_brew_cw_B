import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban_brew/components/auth_button.dart';
import 'package:urban_brew/helper/database_helper.dart';
import 'package:urban_brew/models/cart.dart';
import 'package:urban_brew/models/coffee.dart';
import 'package:urban_brew/screens/home.dart';

class Details extends StatefulWidget {
  Coffee coffee;

  Details({super.key, required this.coffee});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final String imgUrl = "assets/images/coffee05.jpg";
  int quantity = 1;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  void _checkFavoriteStatus() async {
    bool isFav = await DatabaseHelper.instance.isFavorite(widget.coffee.name);
    if (mounted) {
      setState(() {
        _isFavorite = isFav;
      });
    }
  }

  //add coffee to cart

  void addCoffeeToCart(Coffee coffee) {
    // Add item to the cart with the selected quantity
    Cart cartItem = Cart(
      name: coffee.name,
      price: coffee.price,
      imagePath: coffee.imagePath,
      description: coffee.description,
      quantity: quantity,
    );

    //add quantity of the item to cart list array
    Provider.of<Cart>(context, listen: false).addItemToCart(cartItem);

    //then use is push back to home screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Home()),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$quantity x ${coffee.name} added to cart!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void toggleFavorite() async {
    if (_isFavorite) {
      await DatabaseHelper.instance.removeFavorite(widget.coffee.name);
    } else {
      await DatabaseHelper.instance.addFavorite(widget.coffee);
    }
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFF2D7),
        automaticallyImplyLeading: false,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Home())),
            icon: Icon(Icons.arrow_back)),
        actions: [
          IconButton(
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? Colors.red : null,
            ),
            onPressed: toggleFavorite,
          ),
        ],
      ),
      backgroundColor: Color(0xFFFFF2D7),
      body: Container(
        margin: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ClipRRect(
            //   child: Image.asset(
            //     widget.coffee.imagePath,
            //     width: MediaQuery.of(context).size.width,
            //     height: MediaQuery.of(context).size.height / 3,
            //     // height: 50,
            //     // width: 50,
            //     fit: BoxFit.fill,
            //   ),
            // ),
            const SizedBox(height: 25.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.coffee.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      Text(
                        widget.coffee.price,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(8)),
                        child: IconButton(
                            onPressed: () {
                              if (quantity > 1) {
                                setState(() {
                                  quantity--;
                                });
                              }
                            },
                            icon: Icon(
                              Icons.remove,
                              color: Colors.white,
                            )),
                      ),
                      const SizedBox(width: 20.0),
                      Text(
                        '$quantity',
                        style: TextStyle(
                          fontSize: 28, // Big and bold
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 20.0),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(8)),
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                quantity++;
                              });
                            },
                            icon: Icon(
                              Icons.add,
                              color: Colors.white,
                            )),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              widget.coffee.description,
              style: TextStyle(fontSize: 20.0),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Delivery time in UberEats",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.alarm,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 10.0),
                    Text(
                      "30mis",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            AuthButton(
                text: 'Add To Cart',
                onTap: () => addCoffeeToCart(widget.coffee))
          ],
        ),
      ),
    );
  }
}
