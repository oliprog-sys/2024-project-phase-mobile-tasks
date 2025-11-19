import 'dart:io';
import 'package:flutter/material.dart';
import 'package:product_3/add_product.dart';
import 'package:product_3/product_details.dart';
import 'package:product_3/search_product.dart';
import 'package:product_3/product_model.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: Padding(        
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [              
              // SizedBox(height: 32),
              Row(
                children: [
                  Text(
                    'Available Products',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          // MaterialPageRoute(
                          //   builder: (_) => SearchPage(
                          //     products: ProductList.instance!.products,
                          //     onDelete: (index) {
                          //       ProductList.instance!.deleteProduct(index);
                          //     },
                          //     onUpdate: (index, updatedProduct) {
                          //       ProductList.instance!.updateProduct(updatedProduct, index);
                          //     },
                          //   ),
                          // ),
                          SearchPage.routeName
                        );
                      },
                      icon: Icon(Icons.search_rounded, color: Colors.grey),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 30),

              // product cards
              Column(
                children: [
                  
                  SizedBox(height: 30),

                  ProductList(),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newProduct = await Navigator.push(
            context,
            // MaterialPageRoute(builder: (_) => AddProduct()),
            createRoute()
          );

          if (newProduct is Product) {
            ProductList.addProductExternally(newProduct);
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

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  static void addProductExternally(Product product) {
    _ProductListState? instance = _ProductListState._instance;
    instance?.addProduct(product);
  }

  static _ProductListState? get instance => _ProductListState._instance;

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  static _ProductListState? _instance;

  _ProductListState() {
    _instance = this;
  }  

  final List<Product> products = [];

  void addProduct(Product product) {
    setState(() {
      products.add(product);
    });
  }

  void updateProduct(Product updated, int index) {
    setState(() {
      products[index] = updated;
    });
  }

  void deleteProduct(int index) {
    setState(() {
      products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(products.length, (index) {
        final p = products[index];

        return GestureDetector(
          onTap: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => Details(product: p, index: index),
              ),
            );

            if (result != null && result["delete"] == true) {
              deleteProduct(index);
              debugPrint("Product item deleted successfully.");
            }

            if (result != null && result["update"] != null) {
              updateProduct(result["update"], index);
            }
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  spreadRadius: 2,
                  blurRadius: 7,
                  color: Colors.grey.shade200,
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
                  padding: const EdgeInsets.all(16),
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
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
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
                                "(4.0)",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
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
          ),
        );
      }),
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
