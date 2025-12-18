import 'package:data_overview_layer/features/ecommerce/presentation/bloc/product_bloc.dart';
import 'package:data_overview_layer/features/ecommerce/presentation/bloc/product_event.dart';
import 'package:data_overview_layer/features/ecommerce/presentation/bloc/product_state.dart';
import 'package:data_overview_layer/features/ecommerce/presentation/widgets/product_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsPage extends StatelessWidget {
  static const routeName = '/details';
  final String productId;
  
  const ProductDetailsPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<ProductBloc>()..add(GetSingleProductEvent(productId)),
      child: Scaffold(
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is LoadedSingleProductState) {
              return ProductDetailView(product: state.product);
            }

            if (state is ErrorState) {
              return Center(child: Text(state.message));
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
