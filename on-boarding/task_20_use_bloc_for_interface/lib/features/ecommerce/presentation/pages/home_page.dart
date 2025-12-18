import 'package:data_overview_layer/features/ecommerce/presentation/bloc/product_bloc.dart';
import 'package:data_overview_layer/features/ecommerce/presentation/bloc/product_event.dart';
import 'package:data_overview_layer/features/ecommerce/presentation/bloc/product_state.dart';
import 'package:data_overview_layer/features/ecommerce/presentation/pages/product_details_page.dart';
import 'package:data_overview_layer/features/ecommerce/presentation/pages/search_page.dart';
import 'package:data_overview_layer/features/ecommerce/presentation/widgets/product_card.dart';
import 'package:data_overview_layer/features/ecommerce/presentation/widgets/route_anim.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homePageAppBar(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            HomeTopSection(),

            SizedBox(height: 30),

            Expanded(
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is LoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is LoadedAllProductState) {
                    return ListView.builder(
                      itemCount: state.products.length,
                      itemBuilder: (_, index) {
                        final product = state.products[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ProductDetailsPage(productId: product.id),
                              ),
                            ).then((_) {
                              context.read<ProductBloc>().add(
                                LoadAllProductEvent(),
                              );
                            });
                          },
                          child: ProductCard(product: product),
                        );
                      },
                    );
                  }

                  if (state is ErrorState) {
                    return Center(child: Text(state.message));
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final product = await Navigator.push(
            context,
            // MaterialPageRoute(builder: (_) => AddProduct()),
            createRoute(),
          );

          if (product != null) {
            context.read<ProductBloc>().add(CreateProductEvent(product));
          }
        },
        backgroundColor: const Color.fromARGB(255, 10, 92, 216),
        shape: CircleBorder(),
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 40,
          semanticLabel: 'Add Product',
        ),
      ),
    );
  }
}

PreferredSizeWidget homePageAppBar() {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    title: Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Color(0xcccccccc),
            borderRadius: BorderRadius.circular(11),
          ),
        ),
        SizedBox(width: 12),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'July, 2023',
              style: TextStyle(
                fontFamily: 'Syne',
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Hello,',
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    text: 'Yohannes',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Spacer(),
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11),
            border: Border.all(color: Colors.grey),
          ),
          child: Icon(Icons.notifications_none),
        ),
      ],
    ),
  );
}

class HomeTopSection extends StatelessWidget {
  const HomeTopSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Available Products',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey),
          ),
          child: IconButton(
            onPressed: () {
              // Navigate to SearchPage
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SearchPage()),
              ).then((_) {
                context.read<ProductBloc>().add(LoadAllProductEvent());
              });
            },
            icon: const Icon(Icons.search_rounded, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
