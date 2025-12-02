
import 'package:data_overview_layer/features/ecommerce/data/models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<ProductModel?> fetchProduct(String id);
  Future<void> insertProduct(ProductModel product);
  Future<void> updateProduct(ProductModel product);
  Future<void> deleteProduct(String id);
}