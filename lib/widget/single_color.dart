import 'package:flutter/material.dart';

class SingleColorDisplay extends StatelessWidget {
  final Color? color;
  final ImageProvider? image;

  const SingleColorDisplay({Key? key, this.color, this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;

    return image != null
        ? Container(
            width: deviceWidth * 0.3,
            height: deviceWidth * 0.3,
            decoration: BoxDecoration(
              color: color ?? const Color.fromARGB(255, 18, 143, 128),
              image: DecorationImage(
                image: image!,
                fit: BoxFit.cover,
              ),
            ),
          )
        : Container();
  }
}
