import 'package:flutter/material.dart';
import 'package:shops2/features/domain/entities/product.dart';
import 'package:shops2/utils/constants/app_colors.dart';
import 'package:shops2/utils/extensions/app_text_extension.dart';
import 'package:shops2/utils/reusable_widgets/app_button.dart';
import 'package:shops2/utils/reusable_widgets/app_container.dart';
import 'package:shops2/utils/reusable_widgets/app_image.dart';

class ProductListItem extends StatelessWidget {
  final Product product;
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const ProductListItem({
    super.key,
    required this.product,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppImage(
              product.imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              borderRadius: BorderRadius.circular(8),
            ),
            AppContainer(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  product.name.heading(fontSize: 18),
                  product.description.subheading(fontSize: 14),
                  product.price.toString().toRupees().subheading(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.text,
                  ),
                  quantity == 0
                      ? AppButton(
                          label: 'Add to Cart',
                          onPressed: onAdd,
                          textColor: AppColors.card,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.button,
                          ),
                        )
                      : Row(
                          children: [
                            AppButton(
                              label: '-',
                              onPressed: onDecrease,
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(36, 36),
                                padding: EdgeInsets.zero,
                              ),
                            ),
                            AppContainer(width: 8),
                            '$quantity'.subheading(),
                            AppContainer(width: 8),
                            AppButton(
                              label: '+',
                              onPressed: onIncrease,
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(36, 36),
                                padding: EdgeInsets.zero,
                              ),
                            ),
                            AppContainer(width: 8),
                            AppButton(
                              label: 'Remove',
                              onPressed: onRemove,
                              textColor: AppColors.card,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.button,
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
