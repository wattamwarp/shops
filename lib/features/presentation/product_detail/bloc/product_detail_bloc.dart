import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shops2/features/domain/entities/product.dart';
import 'package:shops2/features/data/repositories_impl/cart_repository_impl.dart';
import 'package:shops2/features/domain/repositories/cart_repository.dart';
import 'product_detail_event.dart';
import 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final CartRepositoryImpl cartRepository;
  ProductDetailBloc(this.cartRepository) : super(ProductDetailLoading()) {
    on<LoadProductDetail>(_onLoadProductDetail);
    on<AddToCartDetail>(_onAddToCart);
    on<IncreaseQuantityDetail>(_onIncreaseQuantity);
    on<DecreaseQuantityDetail>(_onDecreaseQuantity);
  }

  Future<void> _onLoadProductDetail(
    LoadProductDetail event,
    Emitter<ProductDetailState> emit,
  ) async {
    emit(ProductDetailLoading());
    try {
      final cartItems = await cartRepository.getCart();
      final cartItem = cartItems.firstWhere(
        (item) => item.product.id == event.product.id,
        orElse: () => CartItemData(product: event.product, quantity: 0),
      );
      emit(
        ProductDetailLoaded(
          product: event.product,
          quantity: cartItem.quantity,
        ),
      );
    } catch (e) {
      emit(ProductDetailError('Failed to load product details'));
    }
  }

  Future<void> _onAddToCart(
    AddToCartDetail event,
    Emitter<ProductDetailState> emit,
  ) async {
    try {
      await cartRepository.upsertCartItem(event.product, 1);
      emit(ProductDetailLoaded(product: event.product, quantity: 1));
    } catch (e) {
      emit(ProductDetailError('Failed to add to cart'));
    }
  }

  Future<void> _onIncreaseQuantity(
    IncreaseQuantityDetail event,
    Emitter<ProductDetailState> emit,
  ) async {
    if (state is ProductDetailLoaded) {
      final current = state as ProductDetailLoaded;
      final newQty = current.quantity + 1;
      try {
        await cartRepository.upsertCartItem(event.product, newQty);
        emit(ProductDetailLoaded(product: event.product, quantity: newQty));
      } catch (e) {
        emit(ProductDetailError('Failed to update quantity'));
      }
    }
  }

  Future<void> _onDecreaseQuantity(
    DecreaseQuantityDetail event,
    Emitter<ProductDetailState> emit,
  ) async {
    if (state is ProductDetailLoaded) {
      final current = state as ProductDetailLoaded;
      final newQty = current.quantity > 1 ? current.quantity - 1 : 0;
      try {
        await cartRepository.upsertCartItem(event.product, newQty);
        emit(ProductDetailLoaded(product: event.product, quantity: newQty));
      } catch (e) {
        emit(ProductDetailError('Failed to update quantity'));
      }
    }
  }
}
