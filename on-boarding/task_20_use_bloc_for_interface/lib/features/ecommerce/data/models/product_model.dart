import 'dart:typed_data';

import 'package:data_overview_layer/features/ecommerce/domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.name,
    required super.price,
    required super.description,
    required super.imageUrl,
    required super.category,
    super.webImage,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      imageUrl: json['imageUrl'],
      category: json['category'],
      webImage: json['webImage'] != null
          ? Uint8List.fromList(List<int>.from(json['webImage']))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "price": price,
      "description": description,
      "imageUrl": imageUrl,
      "category": category,
      "webImage": webImage,
    };
  }

  factory ProductModel.fromEntity(Product product) {
    return ProductModel(
      id: product.id,
      name: product.name,
      price: product.price,
      description: product.description,
      imageUrl: product.imageUrl,
      category: product.category,
      webImage: product.webImage,
    );
  }

  Product toEntity() {
    return Product(
      id: id,
      name: name,
      price: price,
      description: description,
      imageUrl: imageUrl,
      category: category,
      webImage: webImage,
    );
  }
}
