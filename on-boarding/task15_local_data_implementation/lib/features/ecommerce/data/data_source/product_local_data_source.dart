import 'dart:convert';

import 'package:data_overview_layer/features/ecommerce/data/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProductLocalDataSource {
  Future<ProductModel> getCachedProduct(String id);
  Future<void> cacheProduct(ProductModel product);
  Future<void> insertProduct(ProductModel product);
  Future<void> updateProduct(ProductModel product);
  Future<void> deleteProduct(String id);
}

const String preferenceKey = "PRODUCT_KEY";

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final SharedPreferences sharedPreferences;

  ProductLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheProduct(ProductModel product) async {
    // TODO: implement cacheProduct
    final cachedJson = sharedPreferences.getString(preferenceKey);

    // Initialize with empty map
    Map<String, dynamic> productList = {};

    // Only decode if cachedJson exists and is not empty
    if (cachedJson != null && cachedJson.isNotEmpty) {
      productList = Map<String, dynamic>.from(jsonDecode(cachedJson));
    }

    productList[product.id] = product.toJson();
    await sharedPreferences.setString(preferenceKey, jsonEncode(productList));
  }

  @override
  Future<void> deleteProduct(String id) async {
    // TODO: implement deleteProduct
    final cachedJson = sharedPreferences.getString(preferenceKey);

    if (cachedJson == null) {
      return;
    }
    Map<String, dynamic> productmap = jsonDecode(cachedJson);

    productmap.remove(id);

    await sharedPreferences.setString(preferenceKey, jsonEncode(productmap));
  }

  @override
  Future<ProductModel> getCachedProduct(String id) async {
    // TODO: implement getCachedProduct
    final cachedJson = sharedPreferences.getString(preferenceKey);

    if (cachedJson == null) {
      throw Exception("No cached product found");
    }

    final Map<String, dynamic> productMap = jsonDecode(cachedJson);

    if (!productMap.containsKey(id)) {
      throw Exception("Product is not found");
    }

    return ProductModel.fromJson(productMap[id]);
  }

  @override
  Future<void> insertProduct(ProductModel product) async {
    // TODO: implement insertProduct
    await cacheProduct(product);
  }

  @override
  Future<void> updateProduct(ProductModel product) async {
    // TODO: implement updateProduct
    await cacheProduct(product);
  }
}
