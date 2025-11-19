import 'dart:io';
import 'package:flutter/material.dart';
import 'package:product_3/product_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';

class AddProduct extends StatefulWidget {
  static const routeName = 'addProduct';
  final Product? product;

  const AddProduct({this.product, super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  Uint8List? selectedWebImage;
  XFile? selectedFile;

  final nameCtrl = TextEditingController();
  final categoryCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.product != null) {
      nameCtrl.text = widget.product!.name;
      categoryCtrl.text = widget.product!.category;
      priceCtrl.text = widget.product!.price.toString();
      descCtrl.text = widget.product!.description;
    }
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    categoryCtrl.dispose();
    priceCtrl.dispose();
    descCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isEdit = widget.product != null;

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
            Center(
              child: AddImage(
                onImageSelected: (web, file) {
                  selectedWebImage = web;
                  selectedFile = file;
                },
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text('name', style: TextStyle(fontSize: 14)),
            ),
            SizedBox(height: 8),
            InputField(controller: nameCtrl),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text('Category', style: TextStyle(fontSize: 14)),
            ),
            SizedBox(height: 8),
            InputField(controller: categoryCtrl),
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
                  // check if any of the inputs are empty
                  if (nameCtrl.text.isEmpty ||
                      categoryCtrl.text.isEmpty ||
                      priceCtrl.text.isEmpty ||
                      descCtrl.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please fill all fields"), behavior: SnackBarBehavior.floating, margin: EdgeInsets.only(top: 10, left: 16, right: 16),),
                    );
                    return;
                  }

                  // check if the price entered is valid input
                  if (double.tryParse(priceCtrl.text) == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Price must be a number"),  behavior: SnackBarBehavior.floating, margin: EdgeInsets.only(top: 10, left: 16, right: 16),),
                    );
                    return;
                  }

                  final newProduct = Product(
                    name: nameCtrl.text,
                    category: categoryCtrl.text,
                    price: double.tryParse(priceCtrl.text) ?? 0,
                    description: descCtrl.text,
                    imagePath: !kIsWeb ? selectedFile?.path : null,
                    webImage: kIsWeb ? selectedWebImage : null,
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
                  isEdit ? 'UPDATE' : 'ADD',
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
                  nameCtrl.text = "";
                  categoryCtrl.text = "";
                  priceCtrl.text = "";
                  descCtrl.text = "";
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

class AddImage extends StatefulWidget {
  final Function(Uint8List? webImage, XFile? file) onImageSelected;

  const AddImage({super.key, required this.onImageSelected});

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  Uint8List? webImage;
  XFile? pickedFile;

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    if (kIsWeb) {
      final bytes = await image.readAsBytes();
      setState(() {
        webImage = bytes;
        pickedFile = image;
      });
      widget.onImageSelected(bytes, null);
    } else {
      setState(() {
        pickedFile = image;
      });
      widget.onImageSelected(null, image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pickImage,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        height: 190,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(16),
        ),
        child: getImageWidget(),
      ),
    );
  }

  Widget getImageWidget() {
    if (pickedFile == null && webImage == null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.photo_outlined, size: 48),
          SizedBox(height: 10),
          Text(
            'Upload Image',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      );
    }

    if (kIsWeb && webImage != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.memory(
          webImage!,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.file(
        File(pickedFile!.path),
        fit: BoxFit.cover,
        width: double.infinity,
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
