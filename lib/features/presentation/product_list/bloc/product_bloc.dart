import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shops2/wrappers/bloc/base_bloc.dart';
import 'package:shops2/wrappers/repo_response/repo_response.dart';
import 'package:shops2/features/data/repositories_impl/cart_repository_impl.dart';
import 'package:shops2/features/domain/repositories/product_repository.dart';
import 'package:shops2/features/domain/entities/product.dart';
import 'package:shops2/features/domain/repositories/cart_repository.dart';
import 'package:shops2/features/domain/usecases/update_cart_quantity.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends BaseBloc<ProductEvent, ProductState> {
  final ProductRepository repository;
  final UpdateCartQuantityUseCase updateCartQuantityUseCase;
  final CartRepository cartRepository = CartRepositoryImpl();
  ProductBloc(this.repository, {UpdateCartQuantityUseCase? updateCartQuantity})
    : updateCartQuantityUseCase =
          updateCartQuantity ?? UpdateCartQuantityUseCase(CartRepositoryImpl()),
      super(const ProductLoading()) {
    on<LoadProducts>(_onLoadProducts);
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<ChangeQuantity>(_onChangeQuantity);
    on<GoToCart>(_onGoToCart);
    on<ProductNavigateToDetail>(_onProductNavigateToDetail);
  }

  void _onProductNavigateToDetail(
    ProductNavigateToDetail event,
    Emitter<ProductState> emit,
  ) {
    emit(ProductNavigateToDetailState(event.product));
  }

  void _onGoToCart(GoToCart event, Emitter<ProductState> emit) {
    emit(const ProductNavigateToCart());
  }

  Future<void> _onLoadProducts(
    LoadProducts event,
    Emitter<ProductState> emit,
  ) async {
    emit(const ProductLoading());
    final response = await repository.fetchProducts();
    if (response is! Success<List<Product>>) {
      response.when(
        success: (_) {},
        error: (message) => emit(ProductError(message)),
      );
      return;
    }
    final products = response.data;
    final cart = await _getCartMap();
    emit(ProductLoaded(products: products, cart: cart));
  }

  Future<Map<String, int>> _getCartMap() async {
    final cartItems = await cartRepository.getCart();
    return {for (final item in cartItems) item.product.id: item.quantity};
  }

  Future<void> _onAddToCart(AddToCart event, Emitter<ProductState> emit) async {
    if (state is! ProductLoaded) return;
    final loaded = state as ProductLoaded;
    final quantity = (loaded.cart[event.product.id] ?? 0) + 1;
    await cartRepository.upsertCartItem(event.product, quantity);
    final cart = await _getCartMap();
    emit(ProductLoaded(products: loaded.products, cart: cart));
  }

  Future<void> _onRemoveFromCart(
    RemoveFromCart event,
    Emitter<ProductState> emit,
  ) async {
    if (state is! ProductLoaded) return;
    final loaded = state as ProductLoaded;
    await cartRepository.removeCartItem(event.product.id);
    final cart = await _getCartMap();
    emit(ProductLoaded(products: loaded.products, cart: cart));
  }

  Future<void> _onChangeQuantity(
    ChangeQuantity event,
    Emitter<ProductState> emit,
  ) async {
    if (state is! ProductLoaded) return;
    final loaded = state as ProductLoaded;
    if (event.quantity <= 0) {
      await cartRepository.removeCartItem(event.product.id);
    } else {
      await cartRepository.upsertCartItem(event.product, event.quantity);
    }
    final cart = await _getCartMap();
    emit(ProductLoaded(products: loaded.products, cart: cart));
  }
}
