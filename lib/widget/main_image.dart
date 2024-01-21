import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/color_provider.dart';
import '../provider/img_provider.dart';

// ignore: must_be_immutable
class MainImage extends StatelessWidget {
  MainImage({
    super.key,
    required this.deviceWidth,
    required this.image,
  });

  final double deviceWidth;
  File? image;

  @override
  Widget build(BuildContext context) {
    Future<ui.Image> loadImage(ImageProvider provider) async {
      final Completer<ui.Image> completer = Completer<ui.Image>();
      final ImageStream stream = provider.resolve(ImageConfiguration.empty);
      final listener = ImageStreamListener(
          (ImageInfo info, bool _) => completer.complete(info.image));
      stream.addListener(listener);
      return completer.future;
    }

    void onTap(TapDownDetails details) async {
      final RenderBox box = context.findRenderObject() as RenderBox;
      final Offset localPosition =
          box.globalToLocal(details.globalPosition) + const Offset(10, 90);

      final imgProvider = Provider.of<ImgProvider>(context, listen: true);
      File? previewImage = imgProvider.previewImage != null
          ? File(imgProvider.previewImage!)
          : null;
      final ui.Image image = await loadImage(FileImage(previewImage!));
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

      Color color = Color.fromARGB(a, r, g, b);

      if (!context.mounted) {
        return;
      }
      Provider.of<ColorProvider>(context, listen: true).setPickedColor(color);
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: deviceWidth * 0.8,
          height: deviceWidth * 0.8,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: FileImage(image!), fit: BoxFit.cover))),
    );
  }
}
