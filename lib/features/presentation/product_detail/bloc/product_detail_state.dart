import 'package:PoketFM/features/domain/entities/product.dart';
import 'package:PoketFM/wrappers/bloc/base_bloc.dart';

abstract class ProductDetailState extends BaseState {
  const ProductDetailState();
  @override
  List<Object?> get props => [];
}

class ProductDetailLoading extends ProductDetailState {}

class ProductDetailLoaded extends ProductDetailState {
  final Product product;
  final int quantity;
  const ProductDetailLoaded({required this.product, required this.quantity});
  @override
  List<Object?> get props => [product, quantity];
}

class ProductDetailError extends ProductDetailState {
  final String message;
  const ProductDetailError(this.message);
  @override
  List<Object?> get props => [message];
}
