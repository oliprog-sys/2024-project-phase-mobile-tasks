 import 'dart:convert';

import 'package:data_overview_layer/core/error/exception.dart';
import 'package:data_overview_layer/features/ecommerce/data/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getCachedProducts();
  Future<void> cacheProducts(List<ProductModel> products);
  Future<ProductModel> getCachedProduct(String id);
  Future<void> cacheProduct(ProductModel product);
  Future<void> insertProduct(ProductModel product);
  Future<void> updateProduct(ProductModel product);
  Future<void> deleteProduct(String id);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final SharedPreferences sharedPreferences;

  ProductLocalDataSourceImpl({required this.sharedPreferences});

  static String preferenceKey = "PRODUCT_KEY";

  Map<String, dynamic> getCache() {
    final jsonString = sharedPreferences.getString(preferenceKey);
    if (jsonString == null || jsonString.isEmpty) return {};
    return jsonDecode(jsonString);
  }

  Future<void> save(Map<String, dynamic> map) async {
    await sharedPreferences.setString(preferenceKey, jsonEncode(map));
  }

  @override
  Future<void> cacheProduct(ProductModel product) async {
    final map = getCache();
    map[product.id] = product.toJson();
    await save(map);
  }

  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    final Map<String, dynamic> map = {};

    for (var product in products) {
      map[product.id] = product.toJson();
    }

    await save(map);
  }

  @override
  Future<void> deleteProduct(String id) async {
    final map = getCache();
    map.remove(id);
    await save(map);
  }

  @override
  Future<ProductModel> getCachedProduct(String id) async {
    final map = getCache();
    if (!map.containsKey(id)) throw CacheException();
    return ProductModel.fromJson(map[id]);
  }

  @override
  Future<List<ProductModel>> getCachedProducts() async {
    final map = getCache();
    if (map.isEmpty) throw CacheException();

    return map.values.map((json) => ProductModel.fromJson(json)).toList();
  }

  @override
  Future<void> insertProduct(ProductModel product) async {
    await cacheProduct(product);
  }

  @override
  Future<void> updateProduct(ProductModel product) async {
    await cacheProduct(product);
  }
}
