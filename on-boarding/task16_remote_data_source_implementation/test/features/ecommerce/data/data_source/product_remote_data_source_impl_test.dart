import 'dart:convert';
import 'package:data_overview_layer/features/ecommerce/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:data_overview_layer/features/ecommerce/data/data_source/product_remote_data_source.dart';

import 'product_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([http.Client, ProductRemoteDataSource])
void main() {
  late ProductRemoteDataSourceImpl dataSource;
  late MockClient mockHttpClient;

  const baseUrl = "https://g5-flutter-learning-path-be.onrender.com/api/v1/products";

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = ProductRemoteDataSourceImpl(mockHttpClient);
  });

  group('fetch all products tests', () {
    test(
      "should perform GET request to correct URL with JSON headers",
      () async {
        when(
          mockHttpClient.get(any, headers: anyNamed("headers")),
        ).thenAnswer((_) async => http.Response("[]", 200));

        await dataSource.fetchAllProducts();

        verify(
          mockHttpClient.get(
            Uri.parse(baseUrl),
            headers: {"Content-Type": "application/json"},
          ),
        ).called(1);
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

        when(
          mockHttpClient.get(any, headers: anyNamed("headers")),
        ).thenAnswer((_) async => http.Response(jsonList, 200));

        final result = await dataSource.fetchAllProducts();
        expect(result.length, 2);
        expect(result[0].id, "1");
      },
    );
    test("should throw exception when response code is not 200", () async {
      when(
        mockHttpClient.get(any, headers: anyNamed("headers")),
      ).thenAnswer((_) async => http.Response("Error", 404));

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
        "description": "product name description",
        "imageUrl": "http://somepage.com/product.png"
      });
      when(
        mockHttpClient.get(any, headers: anyNamed("headers")),
      ).thenAnswer((_) async => http.Response(dummyJson, 200));

      await dataSource.fetchProduct(tId);

      verify(
        mockHttpClient.get(
          Uri.parse("$baseUrl/$tId"),
          headers: {"Content-Type": "application/json"},
        ),
      );
    });

    test("should return ProductModel on 200 response", () async {
      final jsonBody = jsonEncode({"id": "1", "name": "Phone","price": 1000, "description": "A smartphone", "imageUrl": "https://page.com/phone.jpg",});

      when(
        mockHttpClient.get(any, headers: anyNamed("headers")),
      ).thenAnswer((_) async => http.Response(jsonBody, 200));

      final result = await dataSource.fetchProduct(tId);

      expect(result.id, "1");
      expect(result.name, "Phone");
    });

    test("should throw exception for non-200 response", () {
      when(
        mockHttpClient.get(any, headers: anyNamed("headers")),
      ).thenAnswer((_) async => http.Response("Error", 500));

      expect(() => dataSource.fetchProduct(tId), throwsException);
    });
  });

  group("insertProduct", () {
    final tProduct = ProductModel(
      id: "1",
      name: "Phone",
      price: 0,
      description: '',
      imageUrl: '',
    );

    test(
      "should call POST request with correct URL, headers, and body",
      () async {
        when(
          mockHttpClient.post(
            any,
            headers: anyNamed("headers"),
            body: anyNamed("body"),
          ),
        ).thenAnswer((_) async => http.Response("", 201));

        await dataSource.insertProduct(tProduct);

        verify(
          mockHttpClient.post(
            Uri.parse(baseUrl),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(tProduct.toJson()),
          ),
        ).called(1);
      },
    );

    test("should throw exception if status is not 200 or 201", () {
      when(
        mockHttpClient.post(
          any,
          headers: anyNamed("headers"),
          body: anyNamed("body"),
        ),
      ).thenAnswer((_) async => http.Response("Error", 400));

      expect(() => dataSource.insertProduct(tProduct), throwsException);
    });
  });

  group("updateProduct", () {
    final tProduct = ProductModel(
      id: "1",
      name: "Updated Phone",
      price: 0,
      description: '',
      imageUrl: '',
    );

    test(
      "should perform PUT request with correct URL, headers and body",
      () async {
        when(
          mockHttpClient.put(
            any,
            headers: anyNamed("headers"),
            body: anyNamed("body"),
          ),
        ).thenAnswer((_) async => http.Response("", 200));

        await dataSource.updateProduct(tProduct);

        verify(
          mockHttpClient.put(
            Uri.parse("$baseUrl/${tProduct.id}"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(tProduct.toJson()),
          ),
        ).called(1);
      },
    );

    test("should throw exception for non-200 response", () {
      when(
        mockHttpClient.put(
          any,
          headers: anyNamed("headers"),
          body: anyNamed("body"),
        ),
      ).thenAnswer((_) async => http.Response("Error", 500));

      expect(() => dataSource.updateProduct(tProduct), throwsException);
    });
  });

  group("deleteProduct", () {
    const tId = "1";

    test("should call DELETE on correct URL", () async {
      when(
        mockHttpClient.delete(any),
      ).thenAnswer((_) async => http.Response("", 200));

      await dataSource.deleteProduct(tId);

      verify(mockHttpClient.delete(Uri.parse("$baseUrl/$tId"))).called(1);
    });

    test("should throw exception on non-200/204 response", () {
      when(
        mockHttpClient.delete(any),
      ).thenAnswer((_) async => http.Response("Error", 400));

      expect(() => dataSource.deleteProduct(tId), throwsException);
    });
  });
}
