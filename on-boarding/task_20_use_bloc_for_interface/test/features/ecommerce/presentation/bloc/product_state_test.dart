
import 'package:data_overview_layer/features/ecommerce/domain/entities/product.dart';
import 'package:data_overview_layer/features/ecommerce/presentation/bloc/product_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final product = Product(id: '1', name: 'Test', category: 'test category', description: 'some description', imageUrl: 'image/url.png', price: 123.3);
  final productList = [product];

  test('IntialState props should be empty', (){
    expect(IntialState().props, []);
  });

   test('LoadingState props should be empty', () {
    expect(LoadingState().props, []);
  });

  test('LoadedAllProductState props should contain products', () {
    expect(LoadedAllProductState(productList).props, [productList]);
  });

  test('LoadedSingleProductState props should contain product', () {
    expect(LoadedSingleProductState(product).props, [product]);
  });

  test('ErrorState props should contain message', () {
    expect(ErrorState('Error').props, ['Error']);
  });
}