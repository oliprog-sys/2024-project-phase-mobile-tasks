import 'dart:io';

import 'package:data_overview_layer/features/ecommerce/domain/entities/product.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


ImageProvider getImageProvider(Product p) {
  if (kIsWeb && p.webImage != null) {
    return MemoryImage(p.webImage!);
  }

  if (!kIsWeb && p.imageUrl != null && p.imageUrl!.isNotEmpty) {
    return FileImage(File(p.imageUrl!));
  }

  return const AssetImage('assets/shoeImg.jpg');
}