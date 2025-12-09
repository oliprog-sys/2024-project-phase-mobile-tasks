

import 'package:data_overview_layer/features/ecommerce/domain/repository/product_repository.dart';

class DeleteProduct {
  final ProductRepository repository;

  DeleteProduct(this.repository);

  Future<void> call(String id) async {
    return repository.deleteProduct(id);
  }
}