import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:PoketFM/utils/constants/asset_paths.dart';
import 'package:PoketFM/wrappers/repo_response/repo_response.dart';
import 'package:PoketFM/features/domain/entities/product.dart';
import 'package:PoketFM/features/domain/repositories/product_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:PoketFM/utils/constants/logger.dart';

class ProductRepositoryImpl implements ProductRepository {
  @override
  Future<RepoResponse<List<Product>>> fetchProducts() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      final String jsonString = await rootBundle.loadString(
        AssetPaths.productJson,
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
