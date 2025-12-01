
import 'dart:typed_data';

class Product {
  final String name;
  final String category;
  final double price;
  final String description;
  final String? imagePath;
  final Uint8List? webImage;

  Product({required this.name, required this.category, required this.price, required this.description, this.imagePath, this.webImage});
}