import 'package:flutter/material.dart';

class SingleColorDisplay extends StatelessWidget {
  final Color? color;

  const SingleColorDisplay({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      width: deviceWidth * 0.8,
      color: color ?? Colors.transparent,
    );
  }
}
