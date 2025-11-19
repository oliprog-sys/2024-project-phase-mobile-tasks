
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:product_3/home_page.dart';
import 'package:product_3/product_model.dart';


void main() {
  testWidgets('Nothing is found in the product list', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: ProductList())),
    );

    expect(find.byType(GestureDetector), findsNothing);
  });

  testWidgets('Add a product to the list', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: ProductList())),
    );

    final newProduct = Product(
      name: 'first addition',
      category: 'first category',
      price: 99,
      description: 'First product description',
    );

    ProductList.addProductExternally(newProduct);

    await tester.pumpAndSettle();

    expect(find.text('first addition'), findsOneWidget);
    expect(find.text('first category'), findsOneWidget);
    expect(find.text('\$99.0'), findsOneWidget);

  });

  testWidgets('Deleting a product updates the list', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: ProductList())),
    );

    final product = Product(
      name: 'for deleting product',
      category: 'new category',
      price: 80,
      description: 'to be deleted product',
    );
    ProductList.addProductExternally(product);
    await tester.pumpAndSettle();

    expect(find.text('for deleting product'), findsOneWidget);

    final state = ProductList.instance!;
    state.deleteProduct(0);

    await tester.pumpAndSettle();

    expect(find.text('for deleting product'), findsNothing);
  });
}