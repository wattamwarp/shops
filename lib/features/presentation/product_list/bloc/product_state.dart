import 'package:shops2/wrappers/bloc/base_bloc.dart';
import 'package:shops2/features/domain/entities/product.dart';

class ProductNavigateToDetailState extends ProductState {
  final Product product;
  ProductNavigateToDetailState(this.product);
}

class ProductNavigateToCart extends ProductState {
  const ProductNavigateToCart();
  @override
  List<Object?> get props => [];
}

abstract class ProductState extends BaseState {
  const ProductState();
}

class ProductLoading extends ProductState {
  const ProductLoading();
  @override
  List<Object?> get props => [];
}

class ProductLoaded extends ProductState {
  final List<Product> products;
  final Map<String, int> cart;
  const ProductLoaded({this.products = const [], this.cart = const {}});
  @override
  List<Object?> get props => [products, cart];
}

class ProductError extends ProductState {
  final String error;
  const ProductError(this.error);
  @override
  List<Object?> get props => [error];
}
