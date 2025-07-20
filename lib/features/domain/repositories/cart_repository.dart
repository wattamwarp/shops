import '../entities/product.dart';

abstract class CartRepository {
  Future<void> upsertCartItem(Product product, int quantity);
  Future<void> removeCartItem(String productId);
  Future<List<CartItemData>> getCart();
}

class CartItemData {
  final Product product;
  final int quantity;
  CartItemData({required this.product, required this.quantity});
}
