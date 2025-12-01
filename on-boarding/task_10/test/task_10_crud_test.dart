

import 'package:flutter_test/flutter_test.dart';
import 'package:product_3/domain/entities/product.dart';
import 'package:product_3/domain/repositories/product_repository.dart';

class MockProductRepository extends ProductRepository {

  final List<Product> productList = [];

  @override
  Future<void> deleteProduct(String id) async {
    // TODO: implement deleteProduct
    productList.removeWhere((p) => p.id == id);
  }

  @override
  Future<Product?> getProduct(String id) async {
    try {
      return productList.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }


  @override
  Future<void> insertProduct(Product product) async {
    // TODO: implement insertProduct
    productList.add(product);
  }

  @override
  Future<void> updateProduct(Product product) async {
    // TODO: implement updateProduct
    final index = productList.indexWhere((p) => p.id == product.id);

    if (index != -1) {
      productList[index] = product;
    } else {
      throw Exception('Product not found');
    }
  }

}

void main() {
  late MockProductRepository repo;
  

  setUp(() {
    repo = MockProductRepository();    
  });

  final product1 = Product(
    id: '1',
    name: 'Shoe',
    description: 'A nice shoe',
    imageUrl: 'assets/shoe.png',
    price: 100,
  );
  
  final productUpdated = Product(
    id: '1',
    name: 'Running Shoe',
    description: 'Comfortable running shoe',
    imageUrl: 'assets/shoe.png',
    price: 120,
  );

  test('insert and get product', () async {
    await repo.insertProduct(product1);

    final fetched = await repo.getProduct('1');
    expect(fetched, product1);
  });

  test('update product', () async {
    await repo.insertProduct(product1);

    await repo.updateProduct(productUpdated);

    final fetched = await repo.getProduct('1');
    expect(fetched!.name, 'Running Shoe');
    expect(fetched.price, 120);
  });

  test('delete product', () async {
    await repo.insertProduct(product1);

    await repo.deleteProduct('1');

    final fetched = await repo.getProduct('1');
    expect(fetched, null); 
  });

}