import 'package:PoketFM/features/domain/entities/product.dart';
import 'package:PoketFM/wrappers/bloc/base_bloc.dart';

abstract class ProductDetailEvent extends BaseEvent {
  const ProductDetailEvent();
  @override
  List<Object?> get props => [];
}

class LoadProductDetail extends ProductDetailEvent {
  final Product product;
  const LoadProductDetail(this.product);
  @override
  List<Object?> get props => [product];
}

class AddToCartDetail extends ProductDetailEvent {
  final Product product;
  const AddToCartDetail(this.product);
  @override
  List<Object?> get props => [product];
}

class IncreaseQuantityDetail extends ProductDetailEvent {
  final Product product;
  const IncreaseQuantityDetail(this.product);
  @override
  List<Object?> get props => [product];
}

class DecreaseQuantityDetail extends ProductDetailEvent {
  final Product product;
  const DecreaseQuantityDetail(this.product);
  @override
  List<Object?> get props => [product];
}
