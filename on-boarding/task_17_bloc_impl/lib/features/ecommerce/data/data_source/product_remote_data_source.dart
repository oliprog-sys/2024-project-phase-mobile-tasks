
import 'package:data_overview_layer/core/error/exception.dart';
import 'package:data_overview_layer/core/network/api_client.dart';
import 'package:data_overview_layer/features/ecommerce/data/models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> fetchAllProducts();
  Future<ProductModel> fetchProduct(String id);
  Future<void> insertProduct(ProductModel product);
  Future<void> updateProduct(ProductModel product);
  Future<void> deleteProduct(String id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ApiClient api;

  ProductRemoteDataSourceImpl(this.api);

  final String endpoint = "products";  

  @override
  Future<List<ProductModel>> fetchAllProducts() async {
    final response = await api.get(endpoint);

    return response.map((e) => ProductModel.fromJson(e)).toList();
  }

  @override
  Future<ProductModel> fetchProduct(String id) async {
    final response = await api.get("$endpoint/$id");
    if (response == null) throw ServerException();
    return ProductModel.fromJson(response);
  }

  @override
  Future<void> insertProduct(ProductModel product) async {
    await api.post(endpoint, product.toJson());
   
  }

  @override
  Future<void> updateProduct(ProductModel product) async {
    await api.put(product.id, product.toJson());
  }

  @override
  Future<void> deleteProduct(String id) async {
    await api.delete("$endpoint/$id");
  }
}
