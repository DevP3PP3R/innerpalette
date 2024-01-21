import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:provider/provider.dart';

import '../provider/color_provider.dart';
import '../provider/img_provider.dart';

class ImageSelect extends StatelessWidget {
  ImageSelect({
    Key? key,
  }) : super(key: key);

  final picker = ImagePicker();
  final int quality = 15;

  Future<void> imageFromGallery(BuildContext context) async {
    var image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: quality,
    );
    if (!context.mounted) return;
    if (image != null) {
      Provider.of<ImgProvider>(context, listen: false)
          .setpreviewImage(image.path);
    }
  }

  Future<void> imageFromCamera(BuildContext context) async {
    var image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: quality,
    );

    if (!context.mounted) return;
    if (image != null) {
      Provider.of<ImgProvider>(context, listen: false)
          .setpreviewImage(image.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    final imgProvider = Provider.of<ImgProvider>(context);
    final colorProvider = Provider.of<ColorProvider>(context);
    final selectedColor = colorProvider.selectedColor;
    File? previewImage = imgProvider.previewImage != null
        ? File(imgProvider.previewImage!)
        : null;

    return SizedBox(
      width: deviceWidth * 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding:
                EdgeInsets.symmetric(vertical: (previewImage == null) ? 20 : 0),
            child: Column(
              children: [
                Text(
                    (previewImage == null) ? '사진을 선택하세요' : '사진을 터치해서\n색상을 고르세요',
                    style: const TextStyle(fontSize: 27)),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () => imageFromCamera(context),
                icon: Icon(
                  Icons.camera_alt_rounded,
                  size: (previewImage == null) ? 50 : 25,
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              IconButton(
                  onPressed: () => imageFromGallery(context),
                  icon: Icon(
                    Icons.photo,
                    size: (previewImage == null) ? 50 : 25,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
