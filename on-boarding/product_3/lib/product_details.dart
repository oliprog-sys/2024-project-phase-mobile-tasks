import 'package:flutter/material.dart';
import 'package:product_3/add_product.dart';
import 'product_model.dart';

class Details extends StatelessWidget {
  static const routeName = 'details';
  final Product product;
  final int index;

  const Details({required this.product, required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // Product Image
                Container(
                  width: double.infinity,
                  height: 266,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    image: DecorationImage(
                      image: AssetImage('assets/shoeImg.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Product Details
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            product.category,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 18),
                          Text(
                            product.name,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 24),
                              Text(
                                '(4.0)',
                                style: TextStyle(
                                  fontFamily: 'Sora',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 18),
                          Text(
                            '\$${product.price}',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              height: 1.2,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // size selection
                SizeSelector(),

                // product info
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    product.description,
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 14),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context, {"delete": true});
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.red),
                          minimumSize: Size(152, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Delete',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.red,
                          ),
                        ),
                      ),

                      ElevatedButton(
                        onPressed: () async {
                          final updated = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AddProduct(product: product),
                            ),
                          );

                          if (updated != null) {
                            Navigator.pop(context, {"update": updated});
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            10,
                            92,
                            216,
                          ),
                          minimumSize: Size(152, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Update',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // back button
          Positioned(
            top: 25,
            left: 24,
            //   child: const Icon(Icons.arrow_back_ios),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              elevation: 1,
              mini: true,
              shape: CircleBorder(),
              backgroundColor: Colors.white,
              child: Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: const Color.fromARGB(255, 10, 92, 216),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SizeSelector extends StatefulWidget {
  const SizeSelector({super.key});

  @override
  State<SizeSelector> createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {
  int selectedSize = 41;

  final List<int> sizes = [39, 40, 41, 42, 43, 44];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Size:',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: sizes.map((size) {
                final bool isSelected = size == selectedSize;
                return Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedSize = size;
                      });
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color.fromARGB(255, 10, 92, 216)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 228, 223, 223),
                            blurRadius: 2,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          '$size',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
