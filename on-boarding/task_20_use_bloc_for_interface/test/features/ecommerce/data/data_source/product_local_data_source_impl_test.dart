import 'dart:convert';

import 'package:mockito/mockito.dart';
import 'package:data_overview_layer/features/ecommerce/data/data_source/product_local_data_source.dart';
import 'package:data_overview_layer/features/ecommerce/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late ProductLocalDataSourceImpl localImpl;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    localImpl = ProductLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  const testJsonProduct = {
    "id": "1",
    "name": "Test Product",
    "price": 100,
    "description": "test description",
    "imageUrl": "/assets/shoe.png",
  };

  final testModel = ProductModel.fromJson(testJsonProduct);

  group('getCachedProduct', () {
    test('should return ProductModel when product exists in cache', () async {
      final cachedMap = {"1": testJsonProduct};

      when(
        mockSharedPreferences.getString("PRODUCT_KEY"),
      ).thenReturn(jsonEncode(cachedMap));

      final result = await localImpl.getCachedProduct("1");

      verify(mockSharedPreferences.getString("PRODUCT_KEY"));
      expect(result, equals(testModel));
    });

    test('should throw Exception when no cached products exist', () async {
      when(mockSharedPreferences.getString("PRODUCT_KEY")).thenReturn(null);

      final call = localImpl.getCachedProduct;

      expect(() => call("1"), throwsException);
    });

    test('should throw Exception when specific product is missing', () async {
      final cachedMap = {"2": testJsonProduct};

      when(
        mockSharedPreferences.getString("PRODUCT_KEY"),
      ).thenReturn(jsonEncode(cachedMap));

      final call = localImpl.getCachedProduct;
      
      expect(() => call("1"), throwsException);
    });
  });   
   

}
