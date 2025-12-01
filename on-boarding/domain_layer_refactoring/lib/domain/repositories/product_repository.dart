import 'package:product_3/domain/entities/product.dart';

abstract class ProductRepository {
  List<Product> getAllProducts();
  Product? getProduct(String id);
  void createProduct(Product product);
  void updateProduct(Product product);
  void deleteProduct(String id);
}
