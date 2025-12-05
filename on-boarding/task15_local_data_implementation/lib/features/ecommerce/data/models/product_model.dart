
import 'package:data_overview_layer/features/ecommerce/domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required super.id,
    required super.name,
    required super.price,
    required super.description,
    required super.imageUrl,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'], 
      name: json['name'], 
      price: (json['price'] as num).toDouble(), 
      description: json['description'],
      imageUrl: json['imageUrl'],
    );    
  }

  Map<String, dynamic> toJson() {
       return {
      "id": id,
      "name": name,
      "price": price,
      "description": description,
      "imageUrl": imageUrl,
    };
  }
}