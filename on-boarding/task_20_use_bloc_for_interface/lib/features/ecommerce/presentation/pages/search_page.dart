import 'package:data_overview_layer/features/ecommerce/domain/entities/product.dart';
import 'package:data_overview_layer/features/ecommerce/presentation/bloc/product_bloc.dart';
import 'package:data_overview_layer/features/ecommerce/presentation/bloc/product_event.dart';
import 'package:data_overview_layer/features/ecommerce/presentation/bloc/product_state.dart';
import 'package:data_overview_layer/features/ecommerce/presentation/pages/product_details_page.dart';
import 'package:data_overview_layer/features/ecommerce/presentation/widgets/product_card.dart';
import 'package:data_overview_layer/features/ecommerce/presentation/widgets/search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search';
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchText = "";
  String? selectedCategory;

  RangeValues priceRange = const RangeValues(50, 400);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('Search Product')),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Color.fromARGB(255, 10, 92, 216),
          ),
          onPressed: () => Navigator.pop(context, {"reload": true}),
        ),
      ),

      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (BuildContext context, ProductState state) {
          if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ErrorState) {
            return Center(child: Text(state.message));
          }

          List<Product> products = [];
          if (state is LoadedAllProductState) {
            products = state.products;
          }

          final filteredProducts = products.where((p) {
            final matchesText =
                searchText.isEmpty ||
                p.name.toLowerCase().contains(searchText.toLowerCase()) ||
                p.category.toLowerCase().contains(searchText.toLowerCase());

            final matchesCategory =
                selectedCategory == null || selectedCategory == p.category;

            final matchesPrice =
                p.price >= priceRange.start && p.price <= priceRange.end;

            return matchesText && matchesCategory && matchesPrice;
          }).toList();

          return Column(
            children: [
              SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: SearchField(
                      onChanged: (value) {
                        setState(() {
                          searchText = value;
                        });
                      },
                    ),
                  ),

                  SizedBox(width: 10),

                  FilterButton(onPressed: _openFilterSheet),
                ],
              ),

              SizedBox(height: 20),

              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];

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
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _openFilterSheet() {
    final state = context.read<ProductBloc>().state;
    List<Product> products = [];
    if (state is LoadedAllProductState) {
      products = state.products;
    }
    final categories = products.map((p) => p.category).toSet().toList();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 18),
                child: Text(
                  'Category',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: SizedBox(
                  width: 366,
                  height: 48,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),  
                    ),
                    initialValue: selectedCategory ?? 'All',
                    items: [
                      const DropdownMenuItem(value: 'All', child: Text('All')),
                      ...categories.map(
                        (c) => DropdownMenuItem(value: c, child: Text(c)),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value == 'All' ? null : value;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(left: 18),
                child: Text(
                  'Price',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: RangeSlider(
                  values: priceRange,
                  min: 0,
                  max: 500,
                  divisions: 50,
                  labels: RangeLabels(
                    "${priceRange.start.round()}",
                    "${priceRange.end.round()}",
                  ),
                  onChanged: (newRange) {
                    setState(() => priceRange = newRange);
                  },
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 10, 92, 216),
                    minimumSize: const Size(377, 54),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'APPLY',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
