import 'package:data_overview_layer/features/ecommerce/domain/entities/product.dart';
import 'package:data_overview_layer/features/ecommerce/presentation/widgets/product_image.dart';
import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final Product product;
  const ProductImage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 266,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: getImageProvider(product),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
