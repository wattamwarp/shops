import 'package:get_it/get_it.dart';
import 'package:shops2/core/db/app_database.dart';
import 'package:shops2/features/data/datasources/cart_local_datasource.dart';
import 'package:shops2/features/data/repositories_impl/product_repository_impl.dart';
import 'package:shops2/features/data/repositories_impl/cart_repository_impl.dart';
import 'package:shops2/utils/constants/logger.dart';

void setupDependencies() {
  final getIt = GetIt.I;
  getIt.registerLazySingleton<AppDatabase>(() => AppDatabase());
  getIt.registerLazySingleton<CartLocalDatasource>(() => CartLocalDatasource());
  getIt.registerLazySingleton<ProductRepositoryImpl>(
    () => ProductRepositoryImpl(),
  );
  getIt.registerLazySingleton<CartRepositoryImpl>(() => CartRepositoryImpl());
  getIt.registerLazySingleton<Logger>(() => Logger());
}
