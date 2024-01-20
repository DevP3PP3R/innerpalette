import 'dart:async';

import 'package:flutter/material.dart';

import 'package:palette_generator/palette_generator.dart';

const Color _kSelectionRectangleBackground = Color(0x15000000);
const Color _kSelectionRectangleBorder = Color(0x80000000);

class ColorPicker extends StatelessWidget {
  const ColorPicker({
    super.key,
    required this.previewImage,
  });
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

@immutable
class ImageColors extends StatefulWidget {
  const ImageColors({
    super.key,
    required this.previewImage,
    this.imageSize,
  });

  final ImageProvider previewImage;
  final Size? imageSize;

  @override
  State<ImageColors> createState() {
    return _ImageColorsState();
  }
}

class _ImageColorsState extends State<ImageColors> {
  Rect? region;
  Rect? dragRegion;
  Offset? startDrag;
  Offset? currentDrag;
  PaletteGenerator? paletteGenerator;

  final GlobalKey imageKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    if (widget.imageSize != null) {
      double imgWidth = widget.imageSize!.width * 0.7;
      double imgHeight = widget.imageSize!.height * 0.7;
      region = Offset(imgWidth / 2, imgHeight / 2) &
          Size(widget.imageSize!.width / 5, widget.imageSize!.height / 5);
    }
    _updatePaletteGenerator(region);
  }

  Future<void> _updatePaletteGenerator(Rect? newRegion) async {
    if (newRegion == null) {
      return;
    }
    paletteGenerator = await PaletteGenerator.fromImageProvider(
      widget.previewImage,
      size: widget.imageSize,
      region: newRegion,
      maximumColorCount: 1,
    );
    setState(() {});
  }

  void _onPanDown(DragDownDetails details) {
    final RenderBox box =
        imageKey.currentContext!.findRenderObject()! as RenderBox;
    final Offset localPosition = box.globalToLocal(details.globalPosition);
    setState(() {
      startDrag = localPosition;
      currentDrag = localPosition;
      dragRegion = Rect.fromPoints(localPosition, localPosition);
    });
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      currentDrag = currentDrag! + details.delta;
      dragRegion = Rect.fromPoints(startDrag!, currentDrag!);
    });
  }

  void _onPanCancel() {
    setState(() {
      dragRegion = null;
      startDrag = null;
    });
  }

  Future<void> _onPanEnd(DragEndDetails details) async {
    final Size? imageSize = imageKey.currentContext?.size;
    Rect? newRegion;

    if (imageSize != null) {
      newRegion = (Offset.zero & imageSize).intersect(dragRegion!);
    }

    await _updatePaletteGenerator(newRegion);
    setState(() {
      region = newRegion;
      dragRegion = null;
      startDrag = null;
    });
  }

  void _onTapDown(TapDownDetails details) async {
    final RenderBox box =
        imageKey.currentContext!.findRenderObject()! as RenderBox;
    final Offset localPosition = box.globalToLocal(details.globalPosition);

    final Rect newRegion = Rect.fromCircle(
      center: localPosition,
      radius: 3.0,
    );

    await _updatePaletteGenerator(newRegion);
    setState(() {
      region = newRegion;
    });
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
            onPanDown: _onPanDown,
            onPanUpdate: _onPanUpdate,
            onPanCancel: _onPanCancel,
            onPanEnd: _onPanEnd,
            child: Stack(children: [
              Container(
                key: imageKey,
                // 이미지 크기
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
              if (dragRegion != null || region != null)
                Positioned(
                    left: (dragRegion ?? region!).left,
                    top: (dragRegion ?? region!).top,
                    width: (dragRegion ?? region!).width,
                    height: (dragRegion ?? region!).height,
                    child: Container(
                      decoration: const ShapeDecoration(
                          color: _kSelectionRectangleBackground,
                          shape: CircleBorder(
                            side: BorderSide(
                              color: _kSelectionRectangleBorder,
                            ),
                          )),
                    )),
            ]),
          ),
        ),
        Container(
          width: deviceWidth * 0.3,
          height: deviceWidth * 0.3,
          decoration: BoxDecoration(
            color: paletteGenerator?.dominantColor?.color ??
                const Color.fromARGB(255, 182, 180, 180),
          ),
        )
      ],
    );
  }
}
