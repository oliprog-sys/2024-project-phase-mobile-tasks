import 'package:data_overview_layer/features/ecommerce/domain/entities/product.dart';
import 'package:data_overview_layer/features/ecommerce/presentation/pages/add_product_page.dart';
import 'package:flutter/material.dart';

Route<Product?> createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => AddProduct(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1, 1);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(position: animation.drive(tween), child: child);
    },
    transitionDuration: const Duration(milliseconds: 600),
  );
}