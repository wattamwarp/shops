import 'package:PoketFM/wrappers/repo_response/repo_response.dart';

import '../entities/product.dart';


abstract class ProductRepository {
  Future<RepoResponse<List<Product>>> fetchProducts();
}
