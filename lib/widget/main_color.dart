import 'dart:io';

import 'package:flutter/material.dart';

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
    return Container(
        width: deviceWidth * 0.8,
        height: deviceWidth * 0.8,
        decoration: BoxDecoration(color: color));
  }
}
