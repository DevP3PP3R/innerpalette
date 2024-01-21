import 'package:flutter/material.dart';
import 'package:innerpalette/provider/color_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class MainColor extends StatelessWidget {
  MainColor({
    super.key,
    required this.deviceWidth,
    required this.color,
  });

  final double deviceWidth;

  Color? color;

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    Color? pickedColor = colorProvider.pickedColor;
    return Container(
      width: deviceWidth * 0.8,
      height: deviceWidth * 0.5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(deviceWidth * 0.05),
          color: pickedColor ?? Colors.green[700]),
    );
  }
}
