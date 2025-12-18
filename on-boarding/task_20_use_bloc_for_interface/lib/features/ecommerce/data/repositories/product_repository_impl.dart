import 'package:dartz/dartz.dart';
import 'package:data_overview_layer/core/error/exception.dart';
import 'package:data_overview_layer/core/error/failure.dart';
import 'package:data_overview_layer/core/network/network_info.dart';
import 'package:data_overview_layer/features/ecommerce/data/data_source/product_local_data_source.dart';
import 'package:data_overview_layer/features/ecommerce/data/data_source/product_remote_data_source.dart';
import 'package:data_overview_layer/features/ecommerce/data/models/product_model.dart';
import 'package:data_overview_layer/features/ecommerce/domain/entities/product.dart';
import 'package:data_overview_layer/features/ecommerce/domain/repository/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    try {
      if (await networkInfo.isConnected) {
        try {
          final products = await remoteDataSource.fetchAllProducts();
          await localDataSource.cacheProducts(products);
          return Right(products);
        } on ServerException catch (_) {
          final cachedProducts = await localDataSource.getCachedProducts();
          return Right(cachedProducts);
        }
      } else {
        final cachedProducts = await localDataSource.getCachedProducts();
        return Right(cachedProducts);
      }
    } on CacheException {
      return Left(CacheFailure(message: "No product found"));
    }
  } 

  @override
  Future<Either<Failure, Unit>> deleteProduct(String id) async {
    try {
      if (await networkInfo.isConnected) {
        try {
          await remoteDataSource.deleteProduct(id);
        } on ServerException catch (_) {}
      }

      await localDataSource.deleteProduct(id);
      return Right(unit);
    } on CacheException {
      return Left(CacheFailure(message: "Cache error"));
    }
  }

  @override
  Future<Either<Failure, Product>> getProduct(String id) async {
    try {
      if (await networkInfo.isConnected) {
        try {
          final product = await remoteDataSource.fetchProduct(id);
          await localDataSource.cacheProduct(product);
          return Right(product);
        } on ServerException catch (_) {
          final cached = await localDataSource.getCachedProduct(id);
          return Right(cached);
        }
      } else {
        final cached = await localDataSource.getCachedProduct(id);
        return Right(cached);
      }
    } on CacheException {
      return Left(CacheFailure(message: "Cache error occurred"));
    }
  }

  @override
  Future<Either<Failure, Unit>> insertProduct(Product product) async {
    final model = ProductModel.fromEntity(product);

    try {
      if (await networkInfo.isConnected) {
        try {
          await remoteDataSource.insertProduct(model);
        } on ServerException catch (_) {}
      }

      await localDataSource.cacheProduct(model);
      return Right(unit);
    } on CacheException {
      return Left(CacheFailure(message: "Cache error"));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateProduct(Product product) async {
    final model = ProductModel.fromEntity(product);

    try {
      if (await networkInfo.isConnected) {
        try {
          await remoteDataSource.updateProduct(model);
        } on ServerException catch (_) {}
      }

      await localDataSource.cacheProduct(model);
      return Right(unit);
    } on CacheException {
      return Left(CacheFailure(message: "Cache error"));
    }
  }
}
