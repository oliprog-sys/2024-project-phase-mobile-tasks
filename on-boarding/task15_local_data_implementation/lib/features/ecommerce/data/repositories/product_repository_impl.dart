import 'package:data_overview_layer/core/error/exception.dart';
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
  Future<void> deleteProduct(String id) async {
    // TODO: implement deleteProduct
    try {
      await localDataSource.deleteProduct(id);
    } on CacheException {
      throw CacheException();
    }
  }

  @override
  Future<Product?> getProduct(String id) async {
    // TODO: implement getProduct 

    if (await networkInfo.isConnected) {
      try {
        final remoteProduct = await remoteDataSource.fetchProduct(id);

        await localDataSource.cacheProduct(remoteProduct);
        return remoteProduct;
      } on ServerException {
        throw ServerException();
      }
    } else {
      try {
        return await localDataSource.getCachedProduct(id);
      } on CacheException {
        throw CacheException();
      }
    }
  }

  @override
  Future<void> insertProduct(Product product) async {
    // TODO: implement insertProduct
    final modelExample = ProductModel(
      id: product.id,
      name: product.name,
      price: product.price,
      description: product.description,
      imageUrl: product.imageUrl,
    );

    try {
      await localDataSource.insertProduct(modelExample);
      await localDataSource.cacheProduct(modelExample);
    } on CacheException {
      throw CacheException();
    }
  }

  @override
  Future<void> updateProduct(Product product) async {
    // TODO: implement updateProduct
    final updatedModelExample = ProductModel(
      id: product.id,
      name: product.name,
      price: product.price,
      description: product.description,
      imageUrl: product.imageUrl,
    );

    try {
      await localDataSource.updateProduct(updatedModelExample);
      await localDataSource.cacheProduct(updatedModelExample);
    } on CacheException {
      throw CacheException();
    }
  }
}
