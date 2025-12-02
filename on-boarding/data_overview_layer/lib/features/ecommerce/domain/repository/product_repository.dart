import 'package:data_overview_layer/features/ecommerce/domain/entities/product.dart';

abstract class ProductRepository {
  Future<Product?> getProduct(String id);
  Future<void> insertProduct(Product product);
  Future<void> updateProduct(Product product);
  Future<void> deleteProduct(String id);
}
