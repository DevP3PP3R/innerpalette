import 'dart:io';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MainImage extends StatelessWidget {
  MainImage({
    super.key,
    required this.deviceWidth,
    required this.image,
  });

  final double deviceWidth;
  File? image;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: deviceWidth * 0.8,
        height: deviceWidth * 0.8,
        decoration: BoxDecoration(
            image:
                DecorationImage(image: FileImage(image!), fit: BoxFit.cover)));
  }
}
