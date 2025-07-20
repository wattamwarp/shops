import 'package:get_it/get_it.dart';
import 'core/db/app_database.dart';
import 'features/data/datasources/cart_local_datasource.dart';
import 'features/data/repositories_impl/product_repository_impl.dart';
import 'features/data/repositories_impl/cart_repository_impl.dart';
import 'utils/constants/logger.dart';

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
