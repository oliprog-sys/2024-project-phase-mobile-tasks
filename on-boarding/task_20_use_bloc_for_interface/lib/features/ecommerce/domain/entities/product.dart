import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String description;
  final String? imageUrl;
  final double price;
  final String category;
  final Uint8List? webImage;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    this.imageUrl,
    this.webImage,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    price,
    description,
    imageUrl,
    category,
    webImage,
  ];
}
