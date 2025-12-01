 
import 'package:product_3/domain/repositories/product_repository.dart';

class DeleteProductUsecase {
  final ProductRepository repository;

  DeleteProductUsecase(this.repository);

  void call(String productId) {
    return repository.deleteProduct(productId);
  }
}