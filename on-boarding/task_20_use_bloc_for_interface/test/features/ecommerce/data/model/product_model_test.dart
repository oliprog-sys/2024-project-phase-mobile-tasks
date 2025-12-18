
import 'package:data_overview_layer/features/ecommerce/data/models/product_model.dart';
import 'package:data_overview_layer/features/ecommerce/domain/entities/product.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final productModelTest = ProductModel(
    id: '1', 
    name: 'Shoe', 
    category: 'shoe',
    price: 99.99, 
    description: 'Derby leather shoe with high quality', 
    imageUrl: '/assets/shoe.png'
  );

  final jsonFileTest = {
    'id': '1', 
    'name': 'Shoe', 
    'price': 99.99, 
    'description': 'Derby leather shoe with high quality', 
    'imageUrl': '/assets/shoe.png'
  };


  // A test to check if the product model is sub type of Product
  test('test product model should be subtype of Product', () {
    expect(productModelTest, isA<Product>());
  });

  // A test to check fromJson works results the right object
  test('fromJson method should return a valid object model', () {
    final model = ProductModel.fromJson(jsonFileTest);

    expect(model.id, "1");
    expect(model.price, 99.99);
    expect(model.imageUrl, "/assets/shoe.png");
  });

  // A test to checkk toJson function results the right json data
  test('toJson should result a valid json data', () {
    final jsonFile = productModelTest.toJson();

    expect(jsonFile, jsonFileTest);
  });
}