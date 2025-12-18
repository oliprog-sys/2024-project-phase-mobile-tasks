
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
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