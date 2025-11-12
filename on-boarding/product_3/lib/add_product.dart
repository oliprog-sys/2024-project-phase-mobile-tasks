// import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Add Product')),
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
            // Center(child: ProductImagePicker()),
            Center(child: AddImage()),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Text('name', style: TextStyle(fontSize: 14)),
            ),
            SizedBox(height: 8),
            InputField(),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 50.0),
              child: Text('Category', style: TextStyle(fontSize: 14)),
            ),
            SizedBox(height: 8),
            InputField(),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 50.0),
              child: Text('price', style: TextStyle(fontSize: 14)),
            ),
            SizedBox(height: 8),
            InputField(),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 50.0),
              child: Text('description', style: TextStyle(fontSize: 14)),
            ),
            Center(
              child: Container(
                width: 366,
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Center(
              child: ElevatedButton(
                onPressed: (){
                  debugPrint("Add product button pressed");
                }, 
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 10, 92, 216),                
                  // padding: EdgeInsets.symmetric(horizontal: 100, vertical: 50),
                  minimumSize: Size(366, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'ADD',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Center(
              child: OutlinedButton(
                onPressed: (){
                  debugPrint("Delete product pressed");
                }, 
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.red),
                  minimumSize: Size(366, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  )
                ),
                child: Text(
                  'DELETE',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.red)
                )
              ),
            )
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
        width: 366,
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
  const InputField({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 366,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(6.0),
        ),
      ),
    );
  }
}
