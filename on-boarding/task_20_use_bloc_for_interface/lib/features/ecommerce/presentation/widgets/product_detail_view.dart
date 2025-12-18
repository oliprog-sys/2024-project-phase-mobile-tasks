import 'package:data_overview_layer/features/ecommerce/domain/entities/product.dart';
import 'package:data_overview_layer/features/ecommerce/presentation/widgets/back_button_widget.dart';
import 'package:data_overview_layer/features/ecommerce/presentation/widgets/details_product_image.dart';
import 'package:data_overview_layer/features/ecommerce/presentation/widgets/product_actions.dart';
import 'package:data_overview_layer/features/ecommerce/presentation/widgets/product_description.dart';
import 'package:data_overview_layer/features/ecommerce/presentation/widgets/product_header.dart';
import 'package:data_overview_layer/features/ecommerce/presentation/widgets/size_selector.dart';
import 'package:flutter/material.dart';

class ProductDetailView extends StatelessWidget {
  final Product product;
  const ProductDetailView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              ProductImage(product: product),
              ProductHeader(product: product),
              const SizeSelector(),
              ProductDescription(description: product.description),
              ProductActions(product: product),
            ],
          ),
        ),
         BackButtonWidget(),
      ],
    );
  }
}