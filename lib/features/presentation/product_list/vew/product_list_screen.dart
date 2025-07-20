import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shops2/features/data/repositories_impl/product_repository_impl.dart';
import 'dart:async';
import 'package:shops2/features/presentation/product_list/bloc/product_bloc.dart';
import 'package:shops2/features/presentation/product_list/bloc/product_event.dart';
import 'package:shops2/features/presentation/product_list/bloc/product_state.dart';
import 'package:shops2/features/presentation/product_list/vew/product_list_item.dart';
import 'package:shops2/utils/constants/app_colors.dart';
import 'package:shops2/utils/extensions/app_text_extension.dart';
import 'package:shops2/utils/reusable_widgets/app_button.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              ProductBloc(GetIt.I<ProductRepositoryImpl>())
                ..add(const LoadProducts(page: 1)),
        ),
      ],
      child: BlocListener<ProductBloc, ProductState>(
        listenWhen: (previous, current) =>
            current is ProductNavigateToCart ||
            current is ProductNavigateToDetailState,
        listener: (context, state) {
          if (state is ProductNavigateToCart) {
            Navigator.of(context).pushNamed('/cart').then((value) {
              _reloadPage(context);
            });
          } else if (state is ProductNavigateToDetailState) {
            Navigator.of(
              context,
            ).pushNamed('/productDetail', arguments: state.product).then((_) {
              _reloadPage(context);
            });
          }
        },
        child: Scaffold(
          appBar: AppBar(title: 'Menu'.heading()),
          body: _ProductListView(),
          bottomNavigationBar: const _GoToCartButton(),
        ),
      ),
    );
  }

  void _reloadPage(BuildContext context) {
    context.read<ProductBloc>().add(const LoadProducts(page: 1));
  }
}

class _ProductListView extends StatefulWidget {
  const _ProductListView();

  @override
  State<_ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<_ProductListView> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoadingMore) {
      final bloc = context.read<ProductBloc>();
      final state = bloc.state;
      if (state is ProductLoaded && !state.hasReachedEnd) {
        _isLoadingMore = true;
        bloc.add(
          LoadMoreProducts(page: state.page + 1, pageSize: state.pageSize),
        );
        Timer(const Duration(seconds: 2), () {
          _isLoadingMore = false;
        });
      }
    }
  }

  Future<void> _onRefresh() async {
    context.read<ProductBloc>().add(LoadProducts(page: 1));
    await Future.delayed(const Duration(milliseconds: 600));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        } else if (state is ProductError) {
          return Center(
            child: 'Error: ${state.error}'.subheading(color: AppColors.error),
          );
        } else if (state is ProductLoaded) {
          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: ListView.builder(
              controller: _scrollController,
              itemCount: state.hasReachedEnd
                  ? state.products.length
                  : state.products.length + 1,
              itemBuilder: (context, index) {
                if (index >= state.products.length) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    ),
                  );
                }
                final product = state.products[index];
                final quantity = state.cart[product.id] ?? 0;
                return _ProductListItemWrapper(
                  product: product,
                  quantity: quantity,
                );
              },
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _ProductListItemWrapper extends StatelessWidget {
  final dynamic product;
  final int quantity;

  const _ProductListItemWrapper({
    required this.product,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<ProductBloc>().add(ProductNavigateToDetail(product));
      },
      child: ProductListItem(
        product: product,
        quantity: quantity,
        onAdd: () => context.read<ProductBloc>().add(AddToCart(product)),
        onRemove: () =>
            context.read<ProductBloc>().add(RemoveFromCart(product)),
        onIncrease: () => context.read<ProductBloc>().add(
          ChangeQuantity(product, quantity + 1),
        ),
        onDecrease: () => context.read<ProductBloc>().add(
          ChangeQuantity(product, quantity - 1),
        ),
      ),
    );
  }
}

class _GoToCartButton extends StatelessWidget {
  const _GoToCartButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: AppButton(
          label: 'Go to Cart',
          textColor: AppColors.text,
          onPressed: () {
            context.read<ProductBloc>().add(GoToCart());
          },
        ),
      ),
    );
  }
}
