import 'package:dartz/dartz.dart';
import 'package:data_overview_layer/core/error/failure.dart';
import 'package:data_overview_layer/features/ecommerce/domain/entities/product.dart';
import 'package:data_overview_layer/features/ecommerce/domain/repository/product_repository.dart';

class GetAllProducts {
  final ProductRepository repository;

  GetAllProducts(this.repository);

  Future<Either<Failure, List<Product>>> call() async {
    try {
      return await repository.getAllProducts();
    } catch (e) {
      rethrow;
    }
  }
}