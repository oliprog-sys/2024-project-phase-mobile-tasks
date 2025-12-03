
import 'package:data_overview_layer/features/ecommerce/data/models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<ProductModel> getCachedProduct(String id);
  Future<void> cacheProduct(ProductModel product);
  Future<void> insertProduct(ProductModel product);
  Future<void> updateProduct(ProductModel product);
  Future<void> deleteProduct(String id);
}