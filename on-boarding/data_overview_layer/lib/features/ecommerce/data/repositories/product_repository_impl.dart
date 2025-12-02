
import 'package:data_overview_layer/core/platform/network_info.dart';
import 'package:data_overview_layer/features/ecommerce/data/data_source/product_local_data_source.dart';
import 'package:data_overview_layer/features/ecommerce/data/data_source/product_remote_data_source.dart';
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
   
  }

  @override
  Future<Product?> getProduct(String id) async {
    return null;
  
    // TODO: implement getProduct
    
  }

  @override
  Future<void> insertProduct(Product product) async {
    // TODO: implement insertProduct    
  }

  @override
  Future<void> updateProduct(Product product) async {
    // TODO: implement updateProduct    
  }

}