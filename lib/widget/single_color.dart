import 'package:flutter/material.dart';

class SingleColorDisplay extends StatelessWidget {
  final Color? color;

  const SingleColorDisplay({
    Key? key,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      width: deviceWidth * 0.3,
      height: deviceWidth * 0.3,
      decoration: BoxDecoration(
        color: color,
      ),
    );
  }
}
