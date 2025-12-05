
import 'package:data_overview_layer/features/ecommerce/data/models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<ProductModel> fetchProduct(String id);
  
}