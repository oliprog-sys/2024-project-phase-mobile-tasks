import 'package:dartz/dartz.dart';
import 'package:data_overview_layer/core/error/failure.dart';
import 'package:data_overview_layer/features/ecommerce/domain/repository/product_repository.dart';

class DeleteProduct {
  final ProductRepository repository;

  DeleteProduct(this.repository);

  Future<Either<Failure, Unit>> call(String id) async {
    return repository.deleteProduct(id);
  }
}
