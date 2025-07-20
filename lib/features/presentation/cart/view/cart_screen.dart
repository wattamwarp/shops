import 'package:flutter/material.dart';
import 'package:PoketFM/utils/constants/app_colors.dart';
import 'package:PoketFM/utils/reusable_widgets/app_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:PoketFM/features/data/repositories_impl/cart_repository_impl.dart';
import 'package:PoketFM/features/presentation/cart/bloc/cart_bloc.dart';
import 'package:PoketFM/features/presentation/cart/bloc/cart_event.dart';
import 'package:PoketFM/features/presentation/cart/bloc/cart_state.dart';
import 'package:PoketFM/utils/extensions/app_text_extension.dart';
import 'package:PoketFM/utils/reusable_widgets/app_image.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CartBloc(CartRepositoryImpl())..add(LoadCart()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: 'Cart'.heading()),
        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CartError) {
              return Center(
                child: 'Error: ${state.message}'.subheading(
                  color: AppColors.error,
                ),
              );
            } else if (state is CartLoaded) {
              if (state.items.isEmpty) {
                return Center(child: 'Cart is empty'.subheading());
              }
              final totalAmount = state.items.fold<double>(
                0,
                (sum, item) => sum + item.product.price * item.quantity,
              );
              return Column(
                children: [
                  Expanded(child: _CartList(items: state.items)),
                  _CartTotalRow(totalAmount: totalAmount),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _CartList extends StatelessWidget {
  final List<CartItem> items;
  const _CartList({required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final totalPrice = item.product.price * item.quantity;
        return ListTile(
          leading: AppImage(
            item.product.imageUrl,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            borderRadius: BorderRadius.circular(8),
          ),
          title: item.product.name.heading(fontSize: 16),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              item.product.description.subheading(fontSize: 14),
              AppContainer(height: 4),
              'Total: ₹${totalPrice.toStringAsFixed(2)}'.subheading(
                fontWeight: FontWeight.bold,
                color: AppColors.text
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  context.read<CartBloc>().add(
                    UpdateCartItemQuantity(item.product, item.quantity - 1),
                  );
                },
              ),
              '${item.quantity}'.subheading(),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  context.read<CartBloc>().add(
                    UpdateCartItemQuantity(item.product, item.quantity + 1),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CartTotalRow extends StatelessWidget {
  final double totalAmount;
  const _CartTotalRow({required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      padding: const EdgeInsets.all(16),
      color: AppColors.background,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          'Total Amount:'.heading(fontSize: 18),
          '₹${totalAmount.toStringAsFixed(2)}'.heading(fontSize: 18,color: AppColors.text),
        ],
      ),
    );
  }
}
