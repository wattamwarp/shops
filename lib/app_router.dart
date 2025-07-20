import 'package:flutter/material.dart';
import 'package:shops2/features/presentation/cart/view/cart_screen.dart';
import 'package:shops2/utils/constants/route_paths.dart';
import 'features/presentation/product_list/vew/product_list_screen.dart';
import 'features/presentation/product_detail/view/product_detail_screen.dart';
import 'features/domain/entities/product.dart';
import 'utils/extensions/app_text_extension.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.home:
        return MaterialPageRoute(builder: (_) => const ProductListScreen());
      case RoutePaths.cart:
        return MaterialPageRoute(builder: (_) => const CartScreen());
      case RoutePaths.productDetail:
        final product = settings.arguments as Product;
        return MaterialPageRoute(
          builder: (_) => ProductDetailScreen(product: product),
        );
      default:
        return MaterialPageRoute(
          builder: (_) =>
              Scaffold(body: Center(child: 'No route defined'.heading())),
        );
    }
  }
}
