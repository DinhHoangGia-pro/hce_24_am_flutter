import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'Product.dart';

class SQLiteDbProvider {
  SQLiteDbProvider._();
  static final SQLiteDbProvider db = SQLiteDbProvider._();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  initDB() async {

    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "ProductDB1.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Product ("
          "id INTEGER PRIMARY KEY,"
          "name TEXT,"
          "description TEXT,"
          "price INTEGER,"
          "image TEXT"
          ")");
      await db.execute(
          "INSERT INTO Product ('id', 'name', 'description', 'price', 'image') "
          "values (?, ?, ?, ?, ?)",
          [
            1,
            "iPhone",
            "iPhone is the stylist phone ever",
            1000,
            "bag_1.png"
          ]);
      await db.execute(
          "INSERT INTO Product ('id', 'name', 'description', 'price', 'image') "
          "values (?, ?, ?, ?, ?)",
          [
            2,
            "Pixel",
            "Pixel is the most feature phone ever",
            800,
            "bag_2.png"
          ]);
      await db.execute(
          "INSERT INTO Product ('id', 'name', 'description', 'price', 'image') "
          "values (?, ?, ?, ?, ?)",
          [
            3,
            "Laptop",
            "Laptop is most productive development tool",
            2000,
            "bag_3.png"
          ]);
      await db.execute(
          "INSERT INTO Product ('id', 'name', 'description', 'price', 'image') "
          "values (?, ?, ?, ?, ?)",
          [
            4,
            "Tablet",
            "Laptop is most productive development tool",
            1500,
            "bag_4.png"
          ]);
      await db.execute(
          "INSERT INTO Product ('id', 'name', 'description', 'price', 'image') "
          "values (?, ?, ?, ?, ?)",
          [
            5,
            "Pendrive",
            "Pendrive is useful storage medium",
            100,
            "bag_5.png"
          ]);
      await db.execute(
          "INSERT INTO Product ('id', 'name', 'description', 'price', 'image') "
          "values (?, ?, ?, ?, ?)",
          [
            6,
            "Floppy Drive",
            "Floppy drive is useful rescue storage medium",
            20,
            "bag_6.png"
          ]);
    });
  }

  Future<List<Product>> getAllProducts() async {
    final db = await database;
    List<Map> results =
        await db.query("Product", columns: Product.columns, orderBy: "id ASC");
    List<Product> products1 = [];
    results.forEach((result) {
      Product product = Product.fromMap(result.cast<String, dynamic>());
      print("product=" + product.name.toString());

      products1.add(product);
    });
    return products1;
  }

  Future<Product?> getProductById(int id) async {
    final db = await database;
    var result = await db.query("Product", where: "id = ", whereArgs: [id]);
    if (result.isNotEmpty) {
      return Product.fromMap(result.first.cast<String, dynamic>());
    }
    return null;
  }

  insert(Product product) async {
    final db = await database;
    var maxIdResult =
        await db.rawQuery("SELECT MAX(id)+1 as last_inserted_id FROM Product");
    var id = maxIdResult.first["last_inserted_id"];
    var result = await db.rawInsert(
        "INSERT Into Product (id, name, description, price, image)"
        " VALUES (?, ?, ?, ?, ?)",
        [id, product.name, product.description, product.price, product.image]);
    return result;
  }

  update(Product product) async {
    final db = await database;
    var result = await db.update("Product", product.toMap(),
        where: "id = ?", whereArgs: [product.id]);
    return result;
  }

  delete(int id) async {
    final db = await database;
    db.delete("Product", where: "id = ?", whereArgs: [id]);
  }
}
