
import 'package:get_it/get_it.dart';
import 'package:PoketFM/features/data/datasources/cart_local_datasource.dart';
import 'package:PoketFM/features/domain/entities/product.dart';
import 'package:PoketFM/features/domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDatasource localDatasource;
  CartRepositoryImpl({CartLocalDatasource? datasource})
    : localDatasource = datasource ?? GetIt.I<CartLocalDatasource>();

  @override
  Future<void> upsertCartItem(Product product, int quantity) async {
    await localDatasource.upsertCartItem(
      product.id,
      product.toJson(),
      quantity,
    );
  }

  @override
  Future<void> removeCartItem(String productId) async {
    await localDatasource.removeCartItem(productId);
  }

  @override
  Future<List<CartItemData>> getCart() async {
    final rows = await localDatasource.getCart();
    return rows
        .map(
          (row) => CartItemData(
            product: Product(
              id: row['productId'] as String,
              name: row['name'] as String,
              description: row['description'] as String,
              imageUrl: row['imageUrl'] as String,
              price: (row['price'] as num).toDouble(),
            ),
            quantity: row['quantity'] as int,
          ),
        )
        .toList();
  }
}
