import 'dart:io';

import 'package:flutter/material.dart';
import 'package:innerpalette/provider/img_provider.dart';
import 'package:innerpalette/widget/button_row.dart';
import 'package:innerpalette/widget/main_color.dart';
import 'package:innerpalette/widget/main_image.dart';
import 'package:provider/provider.dart';

import '../provider/color_provider.dart';

class SelectPage extends StatelessWidget {
  const SelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    Color? selectedColor = colorProvider.selectedColor;
    Color? pickedColor = colorProvider.pickedColor;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        MainColor(deviceWidth: deviceWidth, color: selectedColor),
        selectedColor != null
            ? ButtonRow(
                deviceWidth: deviceWidth,
                pickedColor: pickedColor,
                selectedColor: selectedColor,
                colorProvider: colorProvider)
            : Container(),
      ],
    );
  }
}
