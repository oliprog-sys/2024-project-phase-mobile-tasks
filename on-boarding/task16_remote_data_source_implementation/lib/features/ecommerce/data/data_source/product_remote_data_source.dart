import 'dart:convert';
import 'package:data_overview_layer/core/error/exception.dart';
import 'package:data_overview_layer/features/ecommerce/data/models/product_model.dart';
import 'package:http/http.dart' as http;


abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> fetchAllProducts();
  Future<ProductModel> fetchProduct(String id);
  Future<void> insertProduct(ProductModel product);
  Future<void> updateProduct(ProductModel product);
  Future<void> deleteProduct(String id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {

  final http.Client client;

  ProductRemoteDataSourceImpl(this.client);

  final baseUrl = "https://g5-flutter-learning-path-be.onrender.com/api/v1/products";

  @override
  Future<void> deleteProduct(String id) async {
    // TODO: implement deleteProduct
     final response = await client.delete(Uri.parse("$baseUrl/$id"));

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception("Failed to delete product");
    }
  }

  @override
  Future<List<ProductModel>> fetchAllProducts() async {
    // TODO: implement fetchAllProducts
    final response = await client.get(Uri.parse(baseUrl), headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      final List decoded = jsonDecode(response.body);
      return decoded.map((e) => ProductModel.fromJson(e)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> fetchProduct(String id) async {
    final response = await client.get(
      Uri.parse("$baseUrl/$id"),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      return ProductModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> insertProduct(ProductModel product) async {
    // TODO: implement insertProduct
    final response = await client.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(product.toJson()),
    );

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw ServerException();
    }
  }

  @override
  Future<void> updateProduct(ProductModel product) async {
    // TODO: implement updateProduct
    final response = await client.put(
      Uri.parse("$baseUrl/${product.id}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(product.toJson()),
    );

    if (response.statusCode != 200) {
      throw ServerException();
    }
  }

}