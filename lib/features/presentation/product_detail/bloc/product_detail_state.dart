import 'package:equatable/equatable.dart';
import 'package:shops2/features/domain/entities/product.dart';

abstract class ProductDetailState extends Equatable {
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
