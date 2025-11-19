import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:product_3/add_product.dart';
// import 'package:product_3/product_model.dart';

// import 'package:product_3/main.dart';
// import 'package:product_3/home_page.dart';

void main() {
  testWidgets('AddProduct creates a new product with valid input', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(MaterialApp(home: AddProduct()));

    final nameInput = find.byType(TextField).at(0);
    final categoryInput = find.byType(TextField).at(1);
    final priceInput = find.byType(TextField).at(2);
    final descInput = find.byType(TextField).at(3);
    final addButton = find.text('ADD');

    await tester.enterText(nameInput, 'product name');
    await tester.enterText(categoryInput, 'category name');
    await tester.enterText(priceInput, '100');
    await tester.enterText(descInput, 'A test product description');

    await tester.tap(addButton);
    await tester.pumpAndSettle();

    expect(addButton, findsOneWidget);
  });

  testWidgets('AddProduct shows error when input fields are empty', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(MaterialApp(home: AddProduct()));

    final addButton = find.text('ADD');

    await tester.ensureVisible(find.text('ADD'));
    await tester.tap(addButton);
    await tester.pump();

    await tester.pump();
    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Please fill all fields'), findsOneWidget);
  });

  testWidgets('AddProduct shows error when price is not a number', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(MaterialApp(home: AddProduct()));

    final nameField = find.byType(TextField).at(0);
    final categoryField = find.byType(TextField).at(1);
    final priceField = find.byType(TextField).at(2);
    final descField = find.byType(TextField).at(3);
    final addButton = find.text('ADD');

    await tester.enterText(nameField, 'new product');
    await tester.enterText(categoryField, 'new Category');
    await tester.enterText(priceField, 'Not a number');
    await tester.enterText(descField, 'A test product description');

    await tester.ensureVisible(addButton);
    await tester.tap(addButton);

    await tester.pumpAndSettle();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Price must be a number'), findsOneWidget);
  });
}
