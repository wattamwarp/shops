import 'package:flutter/material.dart';
import '../../../../utils/constants/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shops2/features/data/repositories_impl/product_repository_impl.dart';
import 'package:shops2/features/presentation/product_list/bloc/product_bloc.dart';
import 'package:shops2/features/presentation/product_list/bloc/product_event.dart';
import 'package:shops2/features/presentation/product_list/bloc/product_state.dart';
import 'package:shops2/features/presentation/product_list/vew/product_list_item.dart';
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
                ..add(LoadProducts()),
        ),
      ],
      child: BlocListener<ProductBloc, ProductState>(
        listenWhen: (previous, current) =>
            current is ProductNavigateToCart ||
            current is ProductNavigateToDetailState,
        listener: (context, state) {
          if (state is ProductNavigateToCart) {
            Navigator.of(context).pushNamed('/cart').then((value) {
              context.read<ProductBloc>().add(LoadProducts());
            });
          } else if (state is ProductNavigateToDetailState) {
            Navigator.of(
              context,
            ).pushNamed('/productDetail', arguments: state.product).then((_) {
              context.read<ProductBloc>().add(LoadProducts());
            });
          }
        },
        child: Scaffold(
          appBar: AppBar(title: 'Menu'.heading()),
          body: const _ProductListView(),
          bottomNavigationBar: const _GoToCartButton(),
        ),
      ),
    );
  }
}

class _ProductListView extends StatelessWidget {
  const _ProductListView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProductError) {
          return Center(
            child: 'Error: ${state.error}'.subheading(color: AppColors.error),
          );
        } else if (state is ProductLoaded) {
          return ListView.builder(
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              final product = state.products[index];
              final quantity = state.cart[product.id] ?? 0;
              return GestureDetector(
                onTap: () {
                  context.read<ProductBloc>().add(
                    ProductNavigateToDetail(product),
                  );
                },
                child: ProductListItem(
                  product: product,
                  quantity: quantity,
                  onAdd: () =>
                      context.read<ProductBloc>().add(AddToCart(product)),
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
            },
          );
        }
        return const SizedBox.shrink();
      },
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
