import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:innerpalette/widget/single_color.dart';
import 'package:palette_generator/palette_generator.dart';

const Color _kBackgroundColor = Color(0xffa0a0a0);
const Color _kSelectionRectangleBackground = Color(0x15000000);
const Color _kSelectionRectangleBorder = Color(0x80000000);
const Color _kPlaceholderColor = Color(0x80404040);

/// The main Application class.
class ColorPicker extends StatelessWidget {
  /// Creates the main Application class.
  const ColorPicker({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const ImageColors(
      image: AssetImage('assets/magic.png'),
      imageSize: Size(256.0, 170.0),
    );
  }
}

@immutable
class ImageColors extends StatefulWidget {
  /// Creates the home page.
  const ImageColors({
    super.key,
    required this.image,
    this.imageSize,
  });

  final ImageProvider image;
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
    _updatePaletteGenerator(region);
  }

  Future<void> _updatePaletteGenerator(Rect? newRegion) async {
    paletteGenerator = await PaletteGenerator.fromImageProvider(
      widget.image,
      size: widget.imageSize,
      region: newRegion,
      maximumColorCount: 20,
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
      // if (newRegion.size.width < 4 || newRegion.size.height < 4) {
      //   newRegion = null;
      // }
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

    paletteGenerator = await PaletteGenerator.fromImageProvider(
      widget.image,
      size: widget.imageSize,
      region: newRegion,
      maximumColorCount: 20,
    );

    await _updatePaletteGenerator(newRegion);
    setState(() {
      region = newRegion;
      // dragRegion = null;
      // startDrag = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: GestureDetector(
            onTapDown: _onTapDown,
            onPanDown: _onPanDown,
            onPanUpdate: _onPanUpdate,
            onPanCancel: _onPanCancel,
            onPanEnd: _onPanEnd,
            child: Stack(children: <Widget>[
              Image(
                key: imageKey,
                image: widget.image,
                width: widget.imageSize?.width,
                height: widget.imageSize?.height,
              ),
              // This is the selection circle.
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
        SingleColorDisplay(color: paletteGenerator?.dominantColor?.color),
      ],
    );
  }
}
