
import 'package:product_3/domain/entities/product.dart';
import 'package:product_3/domain/repositories/product_repository.dart';

class InsertProduct {
  final ProductRepository repository;

  InsertProduct(this.repository);

  Future<void> call(Product product) {
    return repository.insertProduct(product);
  }
}