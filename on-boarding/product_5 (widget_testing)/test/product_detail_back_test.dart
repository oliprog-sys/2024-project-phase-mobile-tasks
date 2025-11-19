import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:product_3/home_page.dart';
import 'package:product_3/product_model.dart';

void main() {
  testWidgets(
    'The tap button in the product detail navigates to the product list',
    (WidgetTester tester) async {
      final testProduct = Product(
        name: 'Test shirt',
        category: 'shirt',
        price: 100,
        description: 'The new test shirt description',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: ProductList()),
        ),
      );

      final state = ProductList.instance!;
      state.addProduct(testProduct);

      await tester.pumpAndSettle();

      await tester.tap(find.byType(GestureDetector).first, warnIfMissed: false);
      await tester.pumpAndSettle();

      expect(find.text('Test shirt'), findsOneWidget);

      final backBtn = find.byIcon(Icons.arrow_back_ios);
      expect(backBtn, findsOneWidget);
      await tester.tap(backBtn);
      await tester.pumpAndSettle();

      expect(find.byType(ProductList), findsOneWidget);
    },
  );
}
