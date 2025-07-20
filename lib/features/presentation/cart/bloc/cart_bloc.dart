import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:PoketFM/features/domain/repositories/cart_repository.dart';
import 'package:PoketFM/wrappers/bloc/base_bloc.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends BaseBloc<CartEvent, CartState> {
  final CartRepository repository;
  CartBloc(this.repository) : super(CartLoading()) {
    on<LoadCart>(_onLoadCart);
    on<UpdateCartItemQuantity>(_onUpdateCartItemQuantity);
  }
  Future<void> _onUpdateCartItemQuantity(
    UpdateCartItemQuantity event,
    Emitter<CartState> emit,
  ) async {
    try {
      if (event.quantity <= 0) {
        await repository.removeCartItem(event.product.id);
      } else {
        await repository.upsertCartItem(event.product, event.quantity);
      }
      add(LoadCart());
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      final cartItems = await repository.getCart();
      final items = cartItems
          .map(
            (item) => CartItem(product: item.product, quantity: item.quantity),
          )
          .toList();
      emit(CartLoaded(items));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }
}
