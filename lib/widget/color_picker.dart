import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:innerpalette/provider/img_provider.dart';
import 'package:innerpalette/widget/button_row.dart';
import 'package:innerpalette/widget/main_image.dart';
import 'package:provider/provider.dart';
import '../provider/color_provider.dart';

class ColorPicker extends StatelessWidget {
  const ColorPicker({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    final colorProvider = Provider.of<ColorProvider>(context);
    final imgProvider = Provider.of<ImgProvider>(context);
    final selectedColor = colorProvider.selectedColor;
    File? previewImage = (imgProvider.previewImage != null)
        ? File(imgProvider.previewImage!)
        : null;

    return (selectedColor != null)
        // 고른 색상 있으면 고른색상 크게 표시
        ? Container(
            width: deviceWidth * 0.8,
            height: deviceWidth * 0.8,
            decoration: BoxDecoration(
              color: selectedColor,
            ),
          )
        : (previewImage != null) // 고른 색상 없고 이미지 있으면
            ? ImageColors(
                // 색상고르기 표시
                imageSize: Size(deviceWidth * 0.8, deviceWidth * 0.8),
              )
            : Container(); // 둘다 없으면 아무것도 안보여줌
  }
}

class ImageColors extends StatelessWidget {
  const ImageColors({
    Key? key,
    this.imageSize,
  }) : super(key: key);

  final Size? imageSize;

  @override
  Widget build(BuildContext context) {
    final GlobalKey imageKey = GlobalKey();

    Future<ui.Image> loadImage(ImageProvider provider) async {
      final Completer<ui.Image> completer = Completer<ui.Image>();
      final ImageStream stream = provider.resolve(ImageConfiguration.empty);
      final listener = ImageStreamListener(
          (ImageInfo info, bool _) => completer.complete(info.image));
      stream.addListener(listener);
      return completer.future;
    }

    void onTapDown(TapDownDetails details) async {
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

      if (!context.mounted) return;
      Provider.of<ColorProvider>(context, listen: true).setPickedColor(color);
    }

    double deviceWidth = MediaQuery.of(context).size.width;
    final colorProvider = Provider.of<ColorProvider>(context);
    final selectedColor = colorProvider.selectedColor;
    final pickedColor = colorProvider.pickedColor;
    final ImgProvider imgProvider = Provider.of<ImgProvider>(context);
    File? previewImage = (imgProvider.previewImage != null)
        ? File(imgProvider.previewImage!)
        : null;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 15),
          child: GestureDetector(
            onTapDown: onTapDown,
            // child: (selectedColor == null)
            //     ? MainImage(deviceWidth: deviceWidth, imageArea: previewImage)
            //     : Container(
            //         width: deviceWidth * 0.8,
            //         height: deviceWidth * 0.8,
            //         decoration: BoxDecoration(
            //           color: selectedColor,
            //         ),
            //       ),
          ),
        ),
        (selectedColor == null)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (selectedColor == null)
                      // 누른 색상 없으면
                      ? ButtonRow(
                          deviceWidth: deviceWidth,
                          pickedColor: pickedColor,
                          selectedColor: selectedColor,
                          colorProvider: colorProvider)
                      : SlidePicker(
                          // 누른 색상 있으면
                          sliderSize: Size(deviceWidth * 0.8, 40),
                          pickerColor: selectedColor,
                          onColorChanged:
                              colorProvider.setSelectedColorFromPicked,
                          colorModel: ColorModel.rgb,
                          enableAlpha: false,
                          displayThumbColor: true,
                          showParams: true,
                          showIndicator: true,
                          indicatorBorderRadius: const BorderRadius.vertical(
                            top: Radius.circular(5),
                            bottom: Radius.circular(5),
                          ),
                        ),
                ],
              )
            : Container(),
      ],
    );
  }
}
