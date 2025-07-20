import 'package:shops2/wrappers/bloc/base_bloc.dart';
import 'package:shops2/features/domain/entities/product.dart';

class ProductNavigateToDetail extends ProductEvent {
  final Product product;
  ProductNavigateToDetail(this.product);
}

class GoToCart extends ProductEvent {}

abstract class ProductEvent extends BaseEvent {
  const ProductEvent();
  @override
  List<Object?> get props => [];
}

class LoadProducts extends ProductEvent {}

class AddToCart extends ProductEvent {
  final Product product;
  const AddToCart(this.product);
  @override
  List<Object?> get props => [product];
}

class RemoveFromCart extends ProductEvent {
  final Product product;
  const RemoveFromCart(this.product);
  @override
  List<Object?> get props => [product];
}

class ChangeQuantity extends ProductEvent {
  final Product product;
  final int quantity;
  const ChangeQuantity(this.product, this.quantity);
  @override
  List<Object?> get props => [product, quantity];
}
