import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:innerpalette/widget/button_row.dart';
import 'package:innerpalette/widget/main_color.dart';

import 'package:provider/provider.dart';

import '../pickers/hsv_picker.dart';
import '../provider/color_provider.dart';

class SelectPage extends StatelessWidget {
  const SelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    Color? selectedColor = colorProvider.selectedColor;
    Color? pickedColor = colorProvider.pickedColor;
    double deviceWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          selectedColor != null
              ? ButtonRow(
                  deviceWidth: deviceWidth,
                  pickedColor: pickedColor,
                  selectedColor: selectedColor,
                  colorProvider: colorProvider)
              : SlidePicker(
                  indicatorSize: Size(deviceWidth * 0.7, 20),
                  sliderSize: Size(deviceWidth * 0.8, 100),
                  pickerColor: selectedColor ?? Color(Colors.green[700]!.value),
                  onColorChanged: colorProvider.setSelectedColor,
                  colorModel: ColorModel.rgb,
                  enableAlpha: false,
                  displayThumbColor: true,
                  showParams: false,
                  showIndicator: true,
                  indicatorBorderRadius:
                      const BorderRadius.vertical(top: Radius.circular(25)),
                ),
        ],
      ),
    );
  }
}
