import 'package:dartz/dartz.dart';
import 'package:data_overview_layer/core/error/failure.dart';
import 'package:data_overview_layer/features/ecommerce/domain/entities/product.dart';
import 'package:data_overview_layer/features/ecommerce/domain/repository/product_repository.dart';

class GetProduct {
  final ProductRepository repository;

  GetProduct(this.repository);

  Future<Either<Failure, Product>> call(String id) async {
    try {
      return await repository.getProduct(id);
    } catch (e) {
      rethrow;
    }
  }
}
