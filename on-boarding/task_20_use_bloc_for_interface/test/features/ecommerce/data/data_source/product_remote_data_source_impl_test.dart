import 'dart:convert';
import 'package:data_overview_layer/core/network/api_client.dart';
import 'package:data_overview_layer/features/ecommerce/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:data_overview_layer/features/ecommerce/data/data_source/product_remote_data_source.dart';

import 'product_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late ProductRemoteDataSourceImpl dataSource;
  late MockApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockApiClient();
    dataSource = ProductRemoteDataSourceImpl(mockApiClient);
  });

  group('fetch all products tests', () {
    test(
      "should perform GET request to correct URL with JSON headers",
      () async {
        when(mockApiClient.get(any)).thenAnswer((_) async => []);

        await dataSource.fetchAllProducts();

        verify(mockApiClient.get("")).called(1);
      },
    );

    test(
      "should return a list of ProductModel when response code is 200",
      () async {
        final jsonList = jsonEncode([
          {
            "id": "1",
            "name": "Phone",
            "price": 1000,
            "description": "A smartphone",
            "imageUrl": "https://page.com/phone.jpg",
          },
          {
            "id": "2",
            "name": "Laptop",
            "price": 2500,
            "description": "A powerful laptop",
            "imageUrl": "https://page.com/laptop.jpg",
          },
        ]);

        when(mockApiClient.get(any)).thenAnswer((_) async => jsonList);

        final result = await dataSource.fetchAllProducts();
        expect(result.length, 2);
        expect(result[0].id, "1");
      },
    );
    test("should throw exception when response code is not 200", () async {
      when(mockApiClient.get(any)).thenThrow(Exception("Error"));

      expect(() => dataSource.fetchAllProducts(), throwsException);
    });
  });

  group("fetchProduct", () {
    const tId = "1";

    test("should call GET on correct URL with JSON headers", () async {
      final dummyJson = jsonEncode({
        "id": "1",
        "name": "product name",
        "price": 1234,
        "description": "",
        "imageUrl": "",
      });
      when(mockApiClient.get(any)).thenAnswer((_) async => dummyJson);

      await dataSource.fetchProduct(tId);

      verify(mockApiClient.get("1")).called(1);
    });

    test("should return ProductModel on 200 response", () async {
      final jsonBody = jsonEncode({
        "id": "1",
        "name": "Phone",
        "price": 1000,
        "description": "A smartphone",
        "imageUrl": "https://page.com/phone.jpg",
      });

      when(mockApiClient.get(any)).thenAnswer((_) async => jsonBody);

      final result = await dataSource.fetchProduct(tId);

      expect(result.id, "1");
      expect(result.name, "Phone");
    });

    test("should throw exception for non-200 response", () {
      when(mockApiClient.get(any)).thenThrow(Exception("Failed"));

      expect(() => dataSource.fetchProduct(tId), throwsException);
    });
  });

  group("insertProduct", () {
    final tProduct = ProductModel(
      id: "1",
      name: "Phone",
      category: 'phone',
      price: 0,
      description: '',
      imageUrl: '',
    );

    test(
      "should call POST request with correct URL, headers, and body",
      () async {
        when(mockApiClient.post(any, any)).thenAnswer((_) async => {});

        await dataSource.insertProduct(tProduct);

        verify(mockApiClient.post("", tProduct.toJson())).called(1);
      },
    );

    test("should throw exception if status is not 200 or 201", () {
      when(mockApiClient.post(any, any)).thenThrow(Exception("Fail"));

      expect(() => dataSource.insertProduct(tProduct), throwsException);
    });
  });

  group("updateProduct", () {
    final tProduct = ProductModel(
      id: "1",
      name: "Updated Phone",
      category: 'phone',
      price: 0,
      description: '',
      imageUrl: '',
    );

    test(
      "should perform PUT request with correct URL, headers and body",
      () async {
        when(mockApiClient.put(any, any)).thenAnswer((_) async => {});

        await dataSource.updateProduct(tProduct);

        verify(mockApiClient.put("1", tProduct.toJson())).called(1);
      },
    );

    test("should throw exception for non-200 response", () {
      when(mockApiClient.put(any, any)).thenThrow(Exception("Fail"));

      expect(() => dataSource.updateProduct(tProduct), throwsException);
    });
  });

  group("deleteProduct", () {
    const tId = "1";

    test("should call DELETE on correct URL", () async {
      when(mockApiClient.delete(any)).thenAnswer((_) async => null);

      await dataSource.deleteProduct(tId);

      verify(mockApiClient.delete("1")).called(1);
    });

    test("should throw exception on non-200/204 response", () {
      when(mockApiClient.delete(any)).thenThrow(Exception("Fail"));

      expect(() => dataSource.deleteProduct(tId), throwsException);
    });
  });
}
