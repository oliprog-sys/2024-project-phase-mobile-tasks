import 'dart:io';
import 'package:flutter/material.dart';
import 'package:product_3/product_details.dart';
import 'product_model.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search';
  final List<Product> products;
  final Function(int) onDelete;
  final Function(int, Product) onUpdate;

  const SearchPage({
    super.key,
    required this.products,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchText = "";
  String? selectedCategory;


  RangeValues priceRange = const RangeValues(50, 400);

  @override
  Widget build(BuildContext context) {
    
    // filters products
    final filteredProducts = widget.products.where((p) {
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

    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('Search Product')),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Color.fromARGB(255, 10, 92, 216),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: Column(
        children: [
          const SizedBox(height: 10),
        
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 261,
                height: 48,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    hintText: "Leather",
                    hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  onChanged: (text) {
                    setState(() {
                      searchText = text;
                    });
                  },
                ),
              ),

             
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 10, 92, 216),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  onPressed: () => _openFilterSheet(),
                  icon: const Icon(Icons.filter_list, color: Colors.white),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
          
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final p = filteredProducts[index];

                return GestureDetector(
                  onTap: () async {
                    final originalIndex = widget.products.indexOf(
                      p,
                    ); 

                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            Details(product: p, index: originalIndex),
                      ),
                    );

                    if (result["delete"] == true) {
                      widget.onDelete(originalIndex);
                    }

                    if (result["update"] != null) {
                      widget.onUpdate(originalIndex, result["update"]);
                    }
                  },
                  child: buildCard(p),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // filter user interface
  void _openFilterSheet() {
    
    final categories = widget.products.map((p) => p.category).toSet().toList();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, 
      builder: (_) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [               
                const Padding(
                  padding: EdgeInsets.only(left: 18.0),
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
                        const DropdownMenuItem(
                          value: 'All',
                          child: Text('All'),
                        ),
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
                  padding: EdgeInsets.only(left: 18.0),
                  child: Text(
                    'Price',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),

                const SizedBox(height: 8),

                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: RangeSlider(
                    values: priceRange,
                    min: 0,
                    max: 500,
                    divisions: 50,
                    labels: RangeLabels(
                      "${priceRange.start.round()}",
                      "${priceRange.end.round()}",
                    ),
                    onChanged: (newVals) {
                      setState(() {
                        priceRange = newVals;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 30),

                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
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
        );
      },
    );
  }


  Widget buildCard(Product p) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      // height: 240,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [          
          Container(
            height: 160,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              image: DecorationImage(
                image: getImageProvider(p),
                fit: BoxFit.cover,
              ),
            ),
          ),
         
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      p.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      p.category,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),

               
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "\$${p.price}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 7),
                    const Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 20),
                        Text(
                          '(4.0)',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


ImageProvider getImageProvider(Product p) {
  if (p.webImage != null) {
    return MemoryImage(p.webImage!);
  }

  if (p.imagePath != null && p.imagePath!.isNotEmpty) {
    return FileImage(File(p.imagePath!));
  }

  return const AssetImage('assets/shoeImg.jpg');
}