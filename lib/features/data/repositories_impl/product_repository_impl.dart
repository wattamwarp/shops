import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shops2/wrappers/repo_response/repo_response.dart';
import 'package:shops2/features/domain/entities/product.dart';
import 'package:shops2/features/domain/repositories/product_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:shops2/utils/constants/logger.dart';

class ProductRepositoryImpl implements ProductRepository {
  @override
  Future<RepoResponse<List<Product>>> fetchProducts() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      final String jsonString = await rootBundle.loadString(
        'lib/features/data/datasources/products.json',
      );
      final List<dynamic> jsonList = json.decode(jsonString);
      final products = jsonList
          .map((json) => Product.fromJson(json as Map<String, dynamic>))
          .toList();
      return RepoResponse.success(products);
    } catch (e) {
      GetIt.I<Logger>().error(e.toString());
      return RepoResponse.error(e.toString());
    }
  }
}
