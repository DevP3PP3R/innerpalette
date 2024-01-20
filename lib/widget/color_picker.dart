import 'dart:async';

import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'single_color.dart';

const Color _kBackgroundColor = Color(0xffa0a0a0);
const Color _kSelectionRectangleBackground = Color(0x15000000);
const Color _kSelectionRectangleBorder = Color(0x80000000);

class ColorPicker extends StatelessWidget {
  const ColorPicker({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return const MaterialApp(
      title: 'Image Colors',
      home: ImageColors(
        title: 'Image Colors',
        image: AssetImage('assets/magic.png'),
        imageSize: Size(256.0, 170.0),
      ),
    );
  }
}

@immutable
class ImageColors extends StatefulWidget {
  const ImageColors({
    super.key,
    this.title,
    this.image,
    this.imageSize,
  });

  final String? title;
  final ImageProvider? image;
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
      region = Offset.zero & widget.imageSize!;
    }
  }

  Future<void> _onTapDown(TapDownDetails details) async {
    final RenderBox box =
        imageKey.currentContext!.findRenderObject()! as RenderBox;
    final Offset localPosition = box.globalToLocal(details.globalPosition);
    final newRegion = (localPosition & const Size(1, 1));

    setState(() {
      region = newRegion;
    });
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
    setState(() {
      region = newRegion;
      dragRegion = null;
      startDrag = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBackgroundColor,
      appBar: AppBar(
        title: Text(widget.title ?? ''),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: GestureDetector(
              onPanDown: _onPanDown,
              onPanUpdate: _onPanUpdate,
              onPanCancel: _onPanCancel,
              onPanEnd: _onPanEnd,
              onTapDown: _onTapDown,
              child: Stack(children: <Widget>[
                Image(
                  key: imageKey,
                  image: widget.image ?? const AssetImage('/assets/magic.png'),
                  width: widget.imageSize?.width,
                  height: widget.imageSize?.height,
                ),
                Positioned.fromRect(
                  rect: dragRegion ?? region ?? Rect.zero,
                  child: Container(
                    decoration: const ShapeDecoration(
                      color: _kSelectionRectangleBackground,
                      shape: CircleBorder(
                        side: BorderSide(
                          color: _kSelectionRectangleBorder,
                        ),
                      ),
                    ),
                  ),
                )
              ]),
            ),
          ),
          SingleColorDisplay(color: paletteGenerator?.dominantColor?.color),
        ],
      ),
    );
  }
}
