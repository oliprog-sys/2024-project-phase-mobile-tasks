
import 'package:data_overview_layer/features/ecommerce/domain/entities/product.dart';
import 'package:data_overview_layer/features/ecommerce/domain/repository/product_repository.dart';

class InsertProduct {
  final ProductRepository repository;

  InsertProduct(this.repository);

  Future<void> call(Product product) {
    return repository.insertProduct(product);
  }
}