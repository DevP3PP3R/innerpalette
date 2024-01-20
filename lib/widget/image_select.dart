import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:innerpalette/widget/color_picker.dart';

class ImageSelect extends StatefulWidget {
  const ImageSelect({
    super.key,
    required this.setImage,
  });
  final Function setImage;
  @override
  State<ImageSelect> createState() => _ImageSelectState();
}

class _ImageSelectState extends State<ImageSelect> {
  final picker = ImagePicker();
  File? previewImage;
  int quality = 15;

  imageFromGallery() async {
    var image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: quality,
    );
    if (image != null) {
      setState(() {
        previewImage = File(image.path);
      });
    }
  }

  imageFromCamera() async {
    var image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: quality,
    );
    if (image != null) {
      setState(() {
        previewImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: deviceWidth * 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: imageFromCamera,
                icon: const Icon(Icons.camera_alt_rounded),
              ),
              IconButton(
                onPressed: imageFromGallery,
                icon: const Icon(Icons.photo),
              ),
            ],
          ),
          Container(
            child: (previewImage != null)
                ? ColorPicker(previewImage: FileImage(previewImage!))
                : const Text('이미지를 선택해주세요'),
          ),
        ],
      ),
    );
  }
}
