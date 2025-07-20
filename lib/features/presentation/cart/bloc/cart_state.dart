import 'package:equatable/equatable.dart';
import 'package:PoketFM/features/domain/entities/product.dart';
import 'package:PoketFM/wrappers/bloc/base_bloc.dart';

abstract class CartState extends BaseState {
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
