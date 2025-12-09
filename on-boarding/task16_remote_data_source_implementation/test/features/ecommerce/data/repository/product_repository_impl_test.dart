
import 'package:data_overview_layer/core/error/exception.dart';
import 'package:data_overview_layer/core/network/network_info.dart';
import 'package:data_overview_layer/features/ecommerce/data/data_source/product_local_data_source.dart';
import 'package:data_overview_layer/features/ecommerce/data/data_source/product_remote_data_source.dart';
import 'package:data_overview_layer/features/ecommerce/data/models/product_model.dart';
import 'package:data_overview_layer/features/ecommerce/data/repositories/product_repository_impl.dart';

import 'package:flutter_test/flutter_test.dart';

class DemoNetworkInfo implements NetworkInfo {
  bool connected;
  DemoNetworkInfo({this.connected = true});

  @override
  Future<bool> get isConnected async => connected;
}

class DemoLocalDataSource implements ProductLocalDataSource {
  final Map<String, ProductModel> tempStorage = {};
  
  @override
  Future<void> cacheProduct(ProductModel product) async {
    // TODO: implement cacheProduct
    tempStorage[product.id] = product;
  }
  
  @override
  Future<void> deleteProduct(String id) async {
    // TODO: implement deleteProduct
    if (!tempStorage.containsKey(id)) throw CacheException();
    tempStorage.remove(id);
  }
  
  @override
  Future<ProductModel> getCachedProduct(String id) async {
    // TODO: implement getCachedProduct
    if (!tempStorage.containsKey(id)) throw CacheException();
    return tempStorage[id]!;
  }
  
  @override
  Future<void> insertProduct(ProductModel product) async {
    // TODO: implement insertProduct
    tempStorage[product.id] = product;
  }
  
  @override
  Future<void> updateProduct(ProductModel product) async {
    // TODO: implement updateProduct
     if (!tempStorage.containsKey(product.id)) throw CacheException();
    tempStorage[product.id] = product;
  }
  
}

class DemoRemoteDataSource implements ProductRemoteDataSource {
  final Map<String, ProductModel> tempStorage = {};
  @override
  Future<ProductModel> fetchProduct(String id) async {
    // TODO: implement fetchProduct
    if (!tempStorage.containsKey(id)) throw ServerException();
    return tempStorage[id]!;
  }
  
  @override
  Future<void> deleteProduct(String id) async {
    // TODO: implement deleteProduct
    if (!tempStorage.containsKey(id)) throw ServerException();
    tempStorage.remove(id);
  }
  
  @override
  Future<List<ProductModel>> fetchAllProducts() async {
    // TODO: implement fetchAllProducts
    if (tempStorage.isEmpty) throw ServerException();

    return tempStorage.values.toList();
  }
  
  @override
  Future<void> insertProduct(ProductModel product) async {
    // TODO: implement insertProduct
    tempStorage[product.id] = product;
  }
  
  @override
  Future<void> updateProduct(ProductModel product) async {
    // TODO: implement updateProduct
    if (!tempStorage.containsKey(product.id)) throw ServerException();
    tempStorage[product.id] = product;
  }

}


void main() {
  late ProductRepositoryImpl impl;
  late DemoRemoteDataSource remote;
  late DemoLocalDataSource local;
  late DemoNetworkInfo networkMock;

  final testProduct = ProductModel(
    id: '1',
    name: 'Shoe',
    price: 100.0,
    description: 'quality shoe description',
    imageUrl: '/assets/shoe.png',
  );

   setUp(() {
    remote = DemoRemoteDataSource();
    local = DemoLocalDataSource();
    networkMock = DemoNetworkInfo();

    remote.tempStorage[testProduct.id] = testProduct;

    impl = ProductRepositoryImpl(
      remoteDataSource: remote,
      localDataSource: local,
      networkInfo: networkMock,
    );
  });

  

  group('ProductRepositoryImpl tests', () {
    test('getProduct returns remote product when online', () async {
      final result = await impl.getProduct('1');
      expect(result, testProduct);

      final cached = await local.getCachedProduct('1');
      expect(cached, testProduct);
    });

    test('getProduct returns cached product when offline', () async {
      await local.cacheProduct(testProduct);
      networkMock.connected = false;

      final result = await impl.getProduct('1');
      expect(result, testProduct);
    });

    test('getProduct throws ServerException if remote fails', () async {
      networkMock.connected = true;

      remote.tempStorage.clear();

      expect(() => impl.getProduct('1'), throwsA(isA<ServerException>()));
    });

    test('getProduct throws CacheException if offline cache fails', () async {
      networkMock.connected = false;
      expect(() => impl.getProduct('1'), throwsA(isA<CacheException>()));
    });

    test('insertProduct stores product locally', () async {
      await impl.insertProduct(testProduct);
      final cached = await local.getCachedProduct('1');
      expect(cached.id, testProduct.id);
      expect(cached.name, testProduct.name);
      expect(cached.price, testProduct.price);

    });

    test('updateProduct updates existing product locally', () async {
      await impl.insertProduct(testProduct);
      final updatedProduct = ProductModel(
        id: '1',
        name: 'Updated Shoe',
        price: 120.0,
        description: 'Updated description',
        imageUrl: '/assets/shoe2.png',
      );
      await impl.updateProduct(updatedProduct);

      final cached = await local.getCachedProduct('1');
      expect(cached.name, 'Updated Shoe');
    });

    test('deleteProduct removes product locally', () async {
      await impl.insertProduct(testProduct);
      await impl.deleteProduct('1');

      expect(() => local.getCachedProduct('1'), throwsA(isA<CacheException>()));
    });
  });
}