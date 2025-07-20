import 'package:shops2/wrappers/bloc/base_bloc.dart';
import 'package:shops2/features/domain/entities/product.dart';

abstract class ProductState extends BaseState {
  const ProductState();
}

class ProductNavigateToDetailState extends ProductState {
  final Product product;
  const ProductNavigateToDetailState(this.product);
}

class ProductNavigateToCart extends ProductState {
  const ProductNavigateToCart();
  @override
  List<Object?> get props => [];
}
class ProductLoading extends ProductState {
  const ProductLoading();
  @override
  List<Object?> get props => [];
}

class ProductLoaded extends ProductState {
  final List<Product> products;
  final Map<String, int> cart;
  final bool hasReachedEnd;
  final int page;
  final int pageSize;
  const ProductLoaded({
    this.products = const [],
    this.cart = const {},
    this.hasReachedEnd = false,
    this.page = 1,
    this.pageSize = 10,
  });
  @override
  List<Object?> get props => [products, cart, hasReachedEnd, page, pageSize];
}

class ProductError extends ProductState {
  final String error;
  const ProductError(this.error);
  @override
  List<Object?> get props => [error];
}
