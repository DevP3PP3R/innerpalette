import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

Widget pickerLayoutBuilder(
    BuildContext context, List<Color> colors, PickerItem child) {
  Orientation orientation = MediaQuery.of(context).orientation;
  int portraitCrossAxisCount = 4;
  int landscapeCrossAxisCount = 5;
  return SizedBox(
    width: 300,
    height: orientation == Orientation.portrait ? 360 : 240,
    child: GridView.count(
      crossAxisCount: orientation == Orientation.portrait
          ? portraitCrossAxisCount
          : landscapeCrossAxisCount,
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      children: [for (Color color in colors) child(color)],
    ),
  );
}

Widget pickerItemBuilder(
    Color color, bool isCurrentColor, void Function() changeColor) {
  double borderRadius = 30;
  double blurRadius = 5;
  double iconSize = 24;

  return Container(
    margin: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius),
      color: color,
      boxShadow: [
        BoxShadow(
            color: color.withOpacity(0.8),
            offset: const Offset(1, 2),
            blurRadius: blurRadius)
      ],
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: changeColor,
        borderRadius: BorderRadius.circular(borderRadius),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 250),
          opacity: isCurrentColor ? 1 : 0,
          child: Icon(
            Icons.done,
            size: iconSize,
            color: useWhiteForeground(color) ? Colors.white : Colors.black,
          ),
        ),
      ),
    ),
  );
}
