import 'package:sqflite/sqflite.dart';
import 'package:PoketFM/core/db/app_database.dart';
import 'package:get_it/get_it.dart';

class CartLocalDatasource {
  final AppDatabase db;
  CartLocalDatasource({AppDatabase? db}) : db = db ?? GetIt.I<AppDatabase>();

  Future<void> upsertCartItem(
    String productId,
    Map<String, dynamic> productJson,
    int quantity,
  ) async {
    final database = await db.database;
    await database.insert('cart', {
      'productId': productJson['id'],
      'name': productJson['name'],
      'description': productJson['description'],
      'imageUrl': productJson['imageUrl'],
      'price': productJson['price'],
      'quantity': quantity,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> removeCartItem(String productId) async {
    final database = await db.database;
    await database.delete(
      'cart',
      where: 'productId = ?',
      whereArgs: [productId],
    );
  }

  Future<List<Map<String, dynamic>>> getCart() async {
    final database = await db.database;
    final result = await database.query('cart', orderBy: 'productId ASC');
    return result;
  }
}
