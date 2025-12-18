
import 'package:data_overview_layer/features/ecommerce/domain/entities/product.dart';
import 'package:data_overview_layer/features/ecommerce/presentation/bloc/product_event.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
   final product = Product(id: '1', name: 'Test name', category: 'test category', description: 'test description', imageUrl: 'image/url.png', price: 343.5);
   
   test('LoadAllProductEvent props should be empty', () {
    expect(LoadAllProductEvent().props, []);
  });

  test('GetSingleProductEvent props should contain id', () {
    expect(GetSingleProductEvent('1').props, ['1']);
  });

  test('CreateProductEvent props should contain product', () {
    expect(CreateProductEvent(product).props, [product]);
  });

  test('UpdateProductEvent props should contain product', () {
    expect(UpdateProductEvent(product).props, [product]);
  });

  test('DeleteProductEvent props should contain id', () {
    expect(DeleteProductEvent('1').props, ['1']);
  });
}