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
          Column(
            children: [
              Text((previewImage == null) ? '사진을 선택하세요' : '사진을 터치해서\n색상을 고르세요',
                  style: const TextStyle(fontSize: 27)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: imageFromCamera,
                icon: Icon(
                  Icons.camera_alt_rounded,
                  size: (previewImage == null) ? 50 : 25,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              IconButton(
                  onPressed: imageFromGallery,
                  icon: Icon(
                    Icons.photo,
                    size: (previewImage == null) ? 50 : 25,
                  )),
            ],
          ),
          previewImage == null
              ? Container(
                  height: 30,
                )
              : ColorPicker(previewImage: FileImage(previewImage!))
        ],
      ),
    );
  }
}
