

import 'package:product_3/domain/repositories/product_repository.dart';

class DeleteProduct {
  final ProductRepository repository;

  DeleteProduct(this.repository);

  Future<void> call(String id) async {
    return repository.deleteProduct(id);
  }
}