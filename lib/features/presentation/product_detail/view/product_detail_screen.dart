import 'package:flutter/material.dart';
import 'package:PoketFM/features/domain/entities/product.dart';
import 'package:PoketFM/utils/extensions/app_text_extension.dart';
import 'package:PoketFM/utils/reusable_widgets/app_image.dart';
import 'package:PoketFM/utils/constants/app_colors.dart';
import 'package:PoketFM/utils/reusable_widgets/app_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/product_detail_bloc.dart';
import '../bloc/product_detail_event.dart';
import '../bloc/product_detail_state.dart';
import 'package:PoketFM/features/data/repositories_impl/cart_repository_impl.dart';
import 'package:PoketFM/utils/reusable_widgets/app_button.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ProductDetailBloc(CartRepositoryImpl())
            ..add(LoadProductDetail(product)),
      child: Scaffold(
        appBar: AppBar(title: product.name.heading()),
        body: BlocBuilder<ProductDetailBloc, ProductDetailState>(
          builder: (context, state) {
            if (state is ProductDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductDetailError) {
              return Center(
                child: state.message.subheading(color: AppColors.error),
              );
            } else if (state is ProductDetailLoaded) {
              return _buildProductDetail(context, state);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildProductDetail(BuildContext context, ProductDetailLoaded state) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildProductCard(context, state),
            SizedBox(height: MediaQuery.of(context).size.height * 0.12),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, ProductDetailLoaded state) {
    return Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(18),
      color: AppColors.card,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildImageWithPriceBadge(context, state),
            AppContainer(height: 20),
            state.product.name.heading(fontSize: 24),
            AppContainer(height: 10),
            _buildDescriptionRow(),
            AppContainer(height: 6),
            state.product.description.subheading(fontSize: 16),
            AppContainer(height: 28),
            _buildQuantityRow(context, state),
            AppContainer(height: 18),
            Center(
              child:
                  'Total: ₹${(state.product.price * state.quantity).toStringAsFixed(2)}'
                      .heading(fontSize: 20, color: AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageWithPriceBadge(
    BuildContext context,
    ProductDetailLoaded state,
  ) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: AppImage(
            state.product.imageUrl,
            width: MediaQuery.of(context).size.width * 0.8,
            height: 220,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          right: 12,
          top: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.9),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: '₹${state.product.price.toStringAsFixed(2)}'.heading(
              fontSize: 18,
              color: AppColors.buttonText,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.info_outline, color: AppColors.primary, size: 20),
        AppContainer(width: 6),
        'Description'.heading(fontSize: 16, color: AppColors.primary),
      ],
    );
  }

  Widget _buildQuantityRow(BuildContext context, ProductDetailLoaded state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppButton(
          label: '-',
          onPressed: state.quantity > 0
              ? () {
                  context.read<ProductDetailBloc>().add(
                    DecreaseQuantityDetail(state.product),
                  );
                }
              : null,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(36, 36),
            padding: EdgeInsets.zero,
          ),
        ),
        AppContainer(width: 18),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.border),
          ),
          child: '${state.quantity}'.heading(fontSize: 20),
        ),
        AppContainer(width: 18),
        AppButton(
          label: '+',
          onPressed: () {
            context.read<ProductDetailBloc>().add(
              IncreaseQuantityDetail(state.product),
            );
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(36, 36),
            padding: EdgeInsets.zero,
          ),
        ),
      ],
    );
  }
}
