import 'package:PoketFM/features/domain/entities/product.dart';
import 'package:PoketFM/features/domain/repositories/cart_repository.dart';


class UpdateCartQuantityUseCase {
  final CartRepository repository;
  UpdateCartQuantityUseCase(this.repository);

  Future<void> call({required Product product, required int quantity}) async {
    if (quantity > 0) {
      await repository.upsertCartItem(product, quantity);
    } else {
      await repository.removeCartItem(product.id);
    }
  }
}
