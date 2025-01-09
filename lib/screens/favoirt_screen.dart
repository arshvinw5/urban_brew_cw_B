import 'package:flutter/material.dart';
import 'package:urban_brew/helper/database_helper.dart';
import 'package:urban_brew/models/coffee.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late Future<List<Coffee>> _favoritesFuture;

  @override
  void initState() {
    super.initState();
    _favoritesFuture = DatabaseHelper.instance.getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
        backgroundColor: Color(0xFFFFF2D7),
      ),
      backgroundColor: Color(0xFFFFF2D7),
      body: FutureBuilder<List<Coffee>>(
        future: _favoritesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No favorites yet.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final coffee = snapshot.data![index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: ListTile(
                    // leading: Image.asset(
                    //   coffee.imagePath,
                    //   width: 50,
                    //   height: 50,
                    //   fit: BoxFit.cover,
                    // ),
                    title: Text(
                      coffee.name,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "Price: ${coffee.price}",
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.white),
                      onPressed: () async {
                        await DatabaseHelper.instance
                            .removeFavorite(coffee.name);
                        setState(() {
                          _favoritesFuture =
                              DatabaseHelper.instance.getFavorites();
                        });
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
