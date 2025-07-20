import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
  @override
  List<Object?> get props => [];
}

class LoadCart extends CartEvent {}

class UpdateCartItemQuantity extends CartEvent {
  final dynamic product;
  final int quantity;
  const UpdateCartItemQuantity(this.product, this.quantity);
  @override
  List<Object?> get props => [product, quantity];
}
