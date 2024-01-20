import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageUpload extends StatefulWidget {
  const ImageUpload({
    super.key,
    required this.setImage,
  });
  final Function setImage;
  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  final picker = ImagePicker();
  File? previewImage;

  imageFromGallery() async {
    var image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 30,
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
      imageQuality: 30,
    );
    if (image != null) {
      setState(() {
        previewImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: (previewImage != null)
                ? Image.file(
                    previewImage!,
                    width: 200,
                  )
                : const Text('이미지를 선택해주세요'),
          ),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  if (previewImage != null) {
                    widget.setImage(previewImage);
                  }
                  Navigator.of(context).pop(true);
                },
                icon: const Icon(Icons.check),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close),
              ),
            ],
          )
        ],
      ),
    );
  }
}
