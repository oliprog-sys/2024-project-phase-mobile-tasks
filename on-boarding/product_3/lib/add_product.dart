// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:product_3/product_model.dart';
// import 'package:image_picker/image_picker.dart';

class AddProduct extends StatelessWidget {

  static const routeName = 'addProduct';

  final nameCtrl = TextEditingController();
  final categoryCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  final Product? product;

  AddProduct({this.product, super.key}) {
    if (product != null) {
      nameCtrl.text = product!.name;
      categoryCtrl.text = product!.category;
      priceCtrl.text = product!.price.toString();
      descCtrl.text = product!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isEdit = product != null;

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(isEdit ? 'Update Product' : 'Add Product')),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20.0,
            color: const Color.fromARGB(255, 10, 92, 216),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),            
            Center(child: AddImage()),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text('name', style: TextStyle(fontSize: 14)),
            ),
            SizedBox(height: 8),
            InputField(controller: nameCtrl,),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text('Category', style: TextStyle(fontSize: 14)),
            ),
            SizedBox(height: 8),
            InputField(controller: categoryCtrl,),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text('price', style: TextStyle(fontSize: 14)),
            ),
            SizedBox(height: 8),
            Center(
              child: Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(6),
                ),
                child: TextField(
                  controller: priceCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                    suffixText: '\$',
                    suffixStyle: TextStyle(color: Colors.black54, fontSize: 16),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text('description', style: TextStyle(fontSize: 14)),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                width: double.infinity,
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(6),
                ),
                child: TextField(
                  controller: descCtrl,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(12),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  final newProduct = Product(
                    name: nameCtrl.text,
                    category: categoryCtrl.text,
                    price: double.tryParse(priceCtrl.text) ?? 0,
                    description: descCtrl.text,
                    imagePath: 'assets/shoeImg.jpg',
                  );

                  Navigator.pop(context, newProduct);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 10, 92, 216),                 
                  minimumSize: Size(366, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  isEdit ? 'UPDATE': 'ADD',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: OutlinedButton(
                onPressed: () {
                  debugPrint("Delete product pressed");
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.red),
                  minimumSize: Size(366, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'DELETE',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class AddImage extends StatelessWidget {
  const AddImage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        debugPrint("Image upload tapped");
      },
      child: Container(
        margin: EdgeInsets.only(left: 16, right: 16),
        width: double.infinity,
        height: 190,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(        
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.photo_outlined, size: 48),
            SizedBox(height: 10),
            Text(
              'Upload Image',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  final TextEditingController controller;
  const InputField({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {    
    return Center(
      child: Container(
        margin: EdgeInsets.only(left: 16, right: 16),
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(6),
        ),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(12),
          ),
        ),
      ),
    );
  }
}
