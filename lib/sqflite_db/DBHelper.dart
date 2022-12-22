import 'package:nov_02/models/cart_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;


class DBHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDatabase();
    return _db!;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'nike.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
      "CREATE TABLE cart (id INTEGER PRIMARY KEY AUTOINCREMENT, productId TEXT, productName TEXT, productPrice TEXT, productDescription TEXT, productCategory TEXT, productStyle TEXT, productImage TEXT, UNIQUE (productId) ON CONFLICT REPLACE)",
    );
  }

  Future<CartModel> insert(CartModel cartModel) async {
    var dbClient = await db;
    await dbClient!.insert('cart', cartModel.toMap());
    return cartModel;
  }

  Future close() async {
    var dbClient = await db;
    dbClient!.close();
  }

  Future<List<CartModel>> getCart() async {
    var dbClient = await db;

    final List<Map<String, Object?>> queryResult =
        await dbClient!.query('cart');
    return queryResult.map((e) => CartModel.fromMap(e)).toList();
  }

  Future deleteTableContent() async {
    var dbClient = await db;
    return await dbClient!.delete(
      'cart',
    );
  }

  Future<int> deleteProduct(String id) async {
    var dbClient = await db;
    return await dbClient!.delete(
      'cart',
      where: 'productId = ?',
      whereArgs: [id],
    );
  }
  Future<int> updateQuantity(CartModel cartModel) async {
    var dbClient = await db;
    return await dbClient!.update(
      'cart',
      cartModel.toMap(),
      where: 'productId = ?',
      whereArgs: [cartModel.productId],
    );
  }
  Future<String> getplantidCart(id)async{
    var dbClient = await db;
    var table = await dbClient?.rawQuery('SELECT * FROM cart WHERE productId = "$id"');
    var dbItem = table!.first;
    String resourceId =dbItem['productId'] as String;
    print('id from db $resourceId');

    return resourceId;
  }
  Future<double?> getTotal() async {
    var dbClient = await db;
    var result = await dbClient?.rawQuery("SELECT SUM(productPrice) FROM cart");
    double? value = result![0]["SUM(productPrice)"] as double?;
    print(value);// value = 220
    return value;
  }
}
