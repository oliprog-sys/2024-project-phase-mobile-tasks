
import 'package:data_overview_layer/core/platform/network_info.dart';
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
    if (await networkInfo.isConnected) {
      await remoteDataSource.deleteProduct(id);
    }
  }

  @override
  Future<Product?> getProduct(String id) async {
    // TODO: implement getProduct
    if (await networkInfo.isConnected) {
      final product = await remoteDataSource.fetchProduct(id);
      if (product != null) {
        await localDataSource.cacheProduct(product);
      }
      return product;
    }
    else {
      return await localDataSource.getCachedProduct(id);
    }
  }

  @override
  Future<void> insertProduct(Product product) async {
    // TODO: implement insertProduct
    final productSample = ProductModel(
      id: product.id,
      name: product.name,
      price: product.price,
      description: product.description,
      imageUrl: product.imageUrl,
    );
    if (await networkInfo.isConnected) {
      await remoteDataSource.insertProduct(productSample);
    }
    await localDataSource.cacheProduct(productSample);
  }

  @override
  Future<void> updateProduct(Product product) async {
    // TODO: implement updateProduct
    final productSample = ProductModel(
      id: product.id,
      name: product.name,
      price: product.price,
      description: product.description,
      imageUrl: product.imageUrl,
    );

    if (await networkInfo.isConnected) {
      await remoteDataSource.updateProduct(productSample);
    }
    await localDataSource.cacheProduct(productSample);
  }

}