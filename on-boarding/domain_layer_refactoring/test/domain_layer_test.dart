
import 'package:product_3/domain/entities/product.dart';
import 'package:product_3/domain/repositories/product_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:product_3/domain/usecases/create_product_usecase.dart';
import 'package:product_3/domain/usecases/delete_product_usecase.dart';
import 'package:product_3/domain/usecases/update_product_usecase.dart';
import 'package:product_3/domain/usecases/view_all_products_usecase.dart';
import 'package:product_3/domain/usecases/view_product_usecase.dart';

class MockProductRepository implements ProductRepository {
  final List<Product> productsList = [];
  
  @override
  void createProduct(Product product) {
    // TODO: implement createProduct
    productsList.add(product);
  }
  
  @override
  void deleteProduct(String id) {
    // TODO: implement deleteProduct
    productsList.removeWhere((p) => p.id == id);
  }
  
  @override
  List<Product> getAllProducts() {
    return productsList;
  }
  
  @override
  Product? getProduct(String id) {
    // TODO: implement getProduct
    final match = productsList.where((p) => p.id == id);
    return match.isEmpty ? null : match.first;
  }
  
  @override
  void updateProduct(Product product) {
    // TODO: implement updateProduct
    final index = productsList.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      productsList[index] = product;
    }
  }
}

void main() {
  late MockProductRepository repository;
  late CreateProductUsecase createUsecase;
  late ViewAllProductsUsecase viewAllUsecase;
  late ViewProductUsecase viewProductUsecase;
  late UpdateProductUsecase updateUsecase;
  late DeleteProductUsecase deleteUsecase;

  setUp(() {
    repository = MockProductRepository();
    createUsecase = CreateProductUsecase(repository);
    viewAllUsecase = ViewAllProductsUsecase(repository);
    viewProductUsecase = ViewProductUsecase(repository);
    updateUsecase = UpdateProductUsecase(repository);
    deleteUsecase = DeleteProductUsecase(repository);
  });

  test('Create and View all produc', (){
    final product1 = Product(
      id: '1',
      name: 'Shoe',
      description: 'Nice shoe',
      imageUrl: 'assets/shoe.png',
      price: 100,
    );

    final product2 = Product(
      id: '2',
      name: 'Bag',
      description: 'Leather bag',
      imageUrl: 'assets/bag.png',
      price: 150,
    );

    createUsecase(product1);
    createUsecase(product2);

    final allProducts = viewAllUsecase();
    expect(allProducts.length, 2);
    expect(allProducts[0].name, 'Shoe');
    expect(allProducts[1].name, 'Bag');
  });

  test('View specific product by ID', () {
    final product = Product(
      id: '1',
      name: 'Shoe',
      description: 'Nice shoe',
      imageUrl: 'assets/shoe.png',
      price: 100,
    );

    createUsecase(product);

    final result = viewProductUsecase('1');
    expect(result, isNotNull);
    expect(result!.name, 'Shoe');

    final missing = viewProductUsecase('99');
    expect(missing, isNull);
  });

  test('Update existing product', () {
    final product = Product(
      id: '1',
      name: 'Shoe',
      description: 'Nice shoe',
      imageUrl: 'assets/shoe.png',
      price: 100,
    );

    createUsecase(product);

    final updatedProduct = Product(
      id: '1',
      name: 'Updated Shoe',
      description: 'Updated description',
      imageUrl: 'assets/shoe.png',
      price: 120,
    );

    updateUsecase(updatedProduct);

    final result = viewProductUsecase('1');
    expect(result!.name, 'Updated Shoe');
    expect(result.price, 120);
  });

  test('Delete product', () {
    final product = Product(
      id: '1',
      name: 'Shoe',
      description: 'Nice shoe',
      imageUrl: 'assets/shoe.png',
      price: 100,
    );

    createUsecase(product);
    expect(viewAllUsecase().length, 1);

    deleteUsecase('1');
    expect(viewAllUsecase().length, 0);
  });
}