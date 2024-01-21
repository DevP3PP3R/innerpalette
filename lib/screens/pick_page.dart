import 'dart:io';

import 'package:flutter/material.dart';
import 'package:innerpalette/provider/img_provider.dart';
import 'package:innerpalette/widget/button_row.dart';
import 'package:innerpalette/widget/main_image.dart';
import 'package:provider/provider.dart';

import '../provider/color_provider.dart';

class PickPage extends StatelessWidget {
  const PickPage({super.key});

  @override
  Widget build(BuildContext context) {
    final imgProvider = Provider.of<ImgProvider>(context);
    final colorProvider = Provider.of<ColorProvider>(context);
    Color? selectedColor = colorProvider.selectedColor;
    Color? pickedColor = colorProvider.pickedColor;
    File? image = (imgProvider.previewImage != null)
        ? File(imgProvider.previewImage!)
        : null;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        MainImage(
          deviceWidth: deviceWidth,
          image: image,
        ),
        ButtonRow(
            deviceWidth: deviceWidth,
            pickedColor: pickedColor,
            selectedColor: selectedColor,
            colorProvider: colorProvider)
      ],
    );
  }
}
