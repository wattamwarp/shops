import 'package:flutter/material.dart';
import 'package:shops2/features/data/repositories_impl/product_repository_impl.dart';
import 'package:shops2/features/data/repositories_impl/cart_repository_impl.dart';
import 'package:shops2/utils/constants/logger.dart';
import 'package:shops2/core/db/app_database.dart';
import 'package:shops2/features/data/datasources/cart_local_datasource.dart';
import 'package:get_it/get_it.dart';
import 'app_router.dart';

void main() {
  _setupDependencies();
  runApp(const MyApp());
}

void _setupDependencies() {
  final getIt = GetIt.I;
  getIt.registerLazySingleton<AppDatabase>(() => AppDatabase());
  getIt.registerLazySingleton<CartLocalDatasource>(() => CartLocalDatasource());
  getIt.registerLazySingleton<ProductRepositoryImpl>(
    () => ProductRepositoryImpl(),
  );
  getIt.registerLazySingleton<CartRepositoryImpl>(() => CartRepositoryImpl());
  getIt.registerLazySingleton<Logger>(() => Logger());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopsy Product Menu',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: '/',
    );
  }
}
