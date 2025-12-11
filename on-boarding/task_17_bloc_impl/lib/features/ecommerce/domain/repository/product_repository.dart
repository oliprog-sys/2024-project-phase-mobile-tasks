import 'package:dartz/dartz.dart';
import 'package:data_overview_layer/core/error/failure.dart';
import 'package:data_overview_layer/features/ecommerce/domain/entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getAllProducts();
  Future<Either<Failure, Product>> getProduct(String id);
  Future<Either<Failure, Unit>> insertProduct(Product product);
  Future<Either<Failure, Unit>> updateProduct(Product product);
  Future<Either<Failure, Unit>> deleteProduct(String id);
}
