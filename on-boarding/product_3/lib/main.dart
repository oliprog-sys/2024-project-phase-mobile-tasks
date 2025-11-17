import 'package:flutter/material.dart';
import 'package:product_3/home_page.dart';
// import 'package:product_3/product_details.dart';
import 'package:product_3/add_product.dart';
// import 'package:product_3/product_model.dart';
import 'package:product_3/search_product.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute: HomePage.routeName,

      routes: {
        HomePage.routeName: (_) => const HomePage(),
        SearchPage.routeName: (_) => SearchPage(
          products: ProductList.instance!.products,
          onDelete: (index) {
            ProductList.instance!.deleteProduct(index);
          },
          onUpdate: (index, updatedProduct) {
            ProductList.instance!.updateProduct(updatedProduct, index);
          },
        ),
        AddProduct.routeName: (_) => AddProduct(),
      },

      // home: const HomePage(),
    );
  }
}
