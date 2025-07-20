import 'package:equatable/equatable.dart';
import '../../../domain/entities/product.dart';

abstract class CartState extends Equatable {
  const CartState();
  @override
  List<Object?> get props => [];
}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItem> items;
  const CartLoaded(this.items);
  @override
  List<Object?> get props => [items];
}

class CartError extends CartState {
  final String message;
  const CartError(this.message);
  @override
  List<Object?> get props => [message];
}

class CartItem extends Equatable {
  final Product product;
  final int quantity;
  const CartItem({required this.product, required this.quantity});
  @override
  List<Object?> get props => [product, quantity];
}
