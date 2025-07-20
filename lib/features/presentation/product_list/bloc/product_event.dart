import 'package:PoketFM/wrappers/bloc/base_bloc.dart';
import 'package:PoketFM/features/domain/entities/product.dart';

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

class LoadProducts extends ProductEvent {
  final int page;
  final int pageSize;
  const LoadProducts({this.page = 1, this.pageSize = 10});
  @override
  List<Object?> get props => [page, pageSize];
}

class LoadMoreProducts extends ProductEvent {
  final int page;
  final int pageSize;
  const LoadMoreProducts({required this.page, required this.pageSize});
  @override
  List<Object?> get props => [page, pageSize];
}

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
