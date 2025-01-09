import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:urban_brew/models/coffee.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('favorites.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE favorites(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        price TEXT,
        imagePath TEXT,
        description TEXT
      )
    ''');
  }

  Future<int> addFavorite(Coffee coffee) async {
    final db = await database;
    return await db.insert('favorites', {
      'name': coffee.name,
      'price': coffee.price,
      'imagePath': coffee.imagePath,
      'description': coffee.description,
    });
  }

  Future<int> removeFavorite(String name) async {
    final db = await database;
    return await db.delete('favorites', where: 'name = ?', whereArgs: [name]);
  }

  Future<List<Coffee>> getFavorites() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('favorites');
    return List.generate(maps.length, (i) {
      return Coffee(
        name: maps[i]['name'],
        price: maps[i]['price'],
        imagePath: maps[i]['imagePath'],
        description: maps[i]['description'],
      );
    });
  }

  Future<bool> isFavorite(String name) async {
    final db = await database;
    final result = await db.query(
      'favorites',
      where: 'name = ?',
      whereArgs: [name],
      limit: 1,
    );
    return result.isNotEmpty;
  }
}
