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
  Future<Either<Failure, Unit>> deleteProduct(String id) async {
    try {
      await remoteDataSource.deleteProduct(id);
      await localDataSource.deleteProduct(id);
      return Right(unit);
    } on ServerException {
      return Left(ServerFailure(message: "Server error"));
    } on CacheException {
      return Left(CacheFailure(message: "Cache error"));
    }
  }

  @override
  Future<Either<Failure, Product>> getProduct(String id) async {
    try {
      if (await networkInfo.isConnected) {
        final product = await remoteDataSource.fetchProduct(id);
        await localDataSource.cacheProduct(product);
        return Right(product);
      } else {
        final cached = await localDataSource.getCachedProduct(id);
        return Right(cached);
      }
    } on ServerException {
      return Left(ServerFailure(message: "Server error occurred"));
    } on CacheException {
      return Left(CacheFailure(message: "Cache error occurred"));
    }
  }

  @override
  Future<Either<Failure, Unit>> insertProduct(Product product) async {
    final modelExample = ProductModel.fromEntity(product);

    try {
      await remoteDataSource.insertProduct(modelExample);
      await localDataSource.cacheProduct(modelExample);
      return Right(unit);
    } on ServerException {
      return Left(ServerFailure(message: "Server error"));
    } on CacheException {
      return Left(CacheFailure(message: "Cache error"));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateProduct(Product product) async {
    final updatedModelExample = ProductModel.fromEntity(product);

    try {
      await remoteDataSource.updateProduct(updatedModelExample);
      await localDataSource.cacheProduct(updatedModelExample);
      return Right(unit);
    } on ServerException {
      return Left(ServerFailure(message: "Server error"));
    } on CacheException {
      return Left(CacheFailure(message: "Cache error"));
    }
  }
}
