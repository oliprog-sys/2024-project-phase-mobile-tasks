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
    try {
      final response = await api.get(endpoint);

      if (response == null || response.isEmpty) {
        throw ServerException();
      }

      return response.map((e) => ProductModel.fromJson(e)).toList();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> fetchProduct(String id) async {
    try {
      final response = await api.get("$endpoint/$id");
      if (response == null) throw ServerException();
      return ProductModel.fromJson(response);
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> insertProduct(ProductModel product) async {
    try {
      await api.post(endpoint, product.toJson());
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> updateProduct(ProductModel product) async {
    try {
    await api.put(product.id, product.toJson());
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    try {
    await api.delete("$endpoint/$id");
    } catch (e) {
      throw ServerException();
    }
  }
}
