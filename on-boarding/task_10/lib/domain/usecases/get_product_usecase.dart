
import 'package:product_3/domain/entities/product.dart';
import 'package:product_3/domain/repositories/product_repository.dart';

class GetProduct {
  final ProductRepository repository;

  GetProduct(this.repository);

  Future<Product?> call(String id) async {
    try {
      return await repository.getProduct(id);
    }
    catch(e) {
      rethrow;
    }
  }
}