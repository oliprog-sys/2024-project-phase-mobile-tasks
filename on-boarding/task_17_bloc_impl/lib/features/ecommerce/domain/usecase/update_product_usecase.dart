
import 'package:dartz/dartz.dart';
import 'package:data_overview_layer/core/error/failure.dart';
import 'package:data_overview_layer/features/ecommerce/domain/entities/product.dart';
import 'package:data_overview_layer/features/ecommerce/domain/repository/product_repository.dart';

class UpdateProduct {
  final ProductRepository repository;

  UpdateProduct(this.repository);

  Future<Either<Failure, Unit>> call(Product product) {
    return repository.updateProduct(product);
  }
}