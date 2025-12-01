
import 'package:product_3/domain/entities/product.dart';
import 'package:product_3/domain/repositories/product_repository.dart';

class UpdateProduct {
  final ProductRepository repository;

  UpdateProduct(this.repository);

  Future<void> call(Product product) {
    return repository.updateProduct(product);
  }
}