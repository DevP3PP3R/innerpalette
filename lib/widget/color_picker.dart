import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class ColorPicker extends StatelessWidget {
  const ColorPicker({
    Key? key,
    required this.previewImage,
  }) : super(key: key);

  final ImageProvider previewImage;

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return ImageColors(
      previewImage: previewImage,
      imageSize: Size(deviceWidth * 0.8, deviceWidth * 0.8),
    );
  }
}

class ImageColors extends StatefulWidget {
  const ImageColors({
    Key? key,
    required this.previewImage,
    this.imageSize,
  }) : super(key: key);

  final ImageProvider previewImage;
  final Size? imageSize;

  @override
  _ImageColorsState createState() => _ImageColorsState();
}

class _ImageColorsState extends State<ImageColors> {
  Color? pickedColor;
  final GlobalKey imageKey = GlobalKey();

  void _onTapDown(TapDownDetails details) async {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset localPosition = box.globalToLocal(details.globalPosition);

    final ui.Image image = await _loadImage(widget.previewImage);
    final double scaleX = image.width / box.size.width;
    final double scaleY = image.height / box.size.height;

    final int x = (localPosition.dx * scaleX).round();
    final int y = (localPosition.dy * scaleY).round();

    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.rawRgba);
    final Uint8List uint8list = byteData!.buffer.asUint8List();

    final int offset = ((y * image.width) + x) * 4;
    final int r = uint8list[offset];
    final int g = uint8list[offset + 1];
    final int b = uint8list[offset + 2];
    final int a = uint8list[offset + 3];

    final Color color = Color.fromARGB(a, r, g, b);

    setState(() {
      pickedColor = color;
    });
  }

  Future<ui.Image> _loadImage(ImageProvider provider) async {
    final Completer<ui.Image> completer = Completer<ui.Image>();
    final ImageStream stream = provider.resolve(ImageConfiguration.empty);
    final listener = ImageStreamListener(
        (ImageInfo info, bool _) => completer.complete(info.image));
    stream.addListener(listener);
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 15),
          child: GestureDetector(
            onTapDown: _onTapDown,
            child: Container(
              key: imageKey,
              width: deviceWidth * 0.8,
              height: deviceWidth * 0.8,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                image: DecorationImage(
                  image: widget.previewImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Container(
          width: deviceWidth * 0.3,
          height: deviceWidth * 0.3,
          decoration: BoxDecoration(
            color: pickedColor ?? const Color.fromARGB(255, 182, 180, 180),
          ),
        )
      ],
    );
  }
}
